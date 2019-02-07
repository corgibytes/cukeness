using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Reflection;
using System.Text;
using System.Threading;
using Newtonsoft.Json.Linq;

namespace StepServer
{
    class Program
    {
        static void Main(string[] args)
        {
            AppDomain.CurrentDomain.UnhandledException += (sender, exceptionArgs) =>
            {
                var ex = exceptionArgs.ExceptionObject as Exception;
                // TODO: test the exception object type and log it
                Console.WriteLine(ex.Message);
                Console.WriteLine(ex.StackTrace);
            };

            AsyncSocketListener.StartListening();
        }
    }

    // Sample server code based on sample at
    // https://docs.microsoft.com/en-us/dotnet/framework/network-programming/asynchronous-server-socket-example

    public class StateObject {
        public Socket workSocket = null;
        public const int BufferSize = 1024;
        public byte[] rawBuffer = new byte[BufferSize];
        public StringBuilder buffer = new StringBuilder();
    }

    public class AsyncSocketListener {
        public static ManualResetEvent allDoneListening = new ManualResetEvent(false);
        public static ManualResetEvent allDoneReceiving = new ManualResetEvent(false);

        public AsyncSocketListener() {
        }

        public static void StartListening() {
            // TODO: remove hard coded port
            var port = 9666;
            IPEndPoint localEndPoint = new IPEndPoint(IPAddress.Any, port);

            Socket listener = new Socket(AddressFamily.InterNetwork,
                SocketType.Stream, ProtocolType.Tcp
            );

            try {
                listener.Bind(localEndPoint);
                listener.Listen(100);

                while (true) {
                    allDoneListening.Reset();

                    Console.WriteLine(
                        $@"Waiting for a connection on {
                            localEndPoint.ToString()
                        }..."
                    );
                    listener.BeginAccept(
                        new AsyncCallback(AcceptCallback),
                        listener
                    );

                    allDoneListening.WaitOne();
                }
            } catch (Exception e) {
                Console.WriteLine(e.ToString());
            }

            Console.WriteLine("\nPress ENTER to continue...");
            Console.Read();
        }

        public static void AcceptCallback(IAsyncResult ar) {
            allDoneListening.Set();

            Socket listener = (Socket) ar.AsyncState;
            Socket handler = listener.EndAccept(ar);

            while (true)
            {
              allDoneReceiving.Reset();

              StateObject state = new StateObject();
              state.workSocket = handler;
              handler.BeginReceive(state.rawBuffer, 0, StateObject.BufferSize,
                0,
                new AsyncCallback(ReadCallback), state
              );

              allDoneReceiving.WaitOne();
            }
        }

        public static void ProcessStepMatches(String request) {
          Console.WriteLine($"Ready to process step matches for {request}");

          var requestData = JObject.Parse(request);
          var nameToMatch = requestData["name_to_match"].Value<string>();

          Console.WriteLine($"Looking for a match for {nameToMatch}");
        }

        private static string AssemblyDirectory
        {
          get
          {
            var codeBase = Assembly.GetExecutingAssembly().CodeBase;
            var uri = new UriBuilder(codeBase);
            var path = Uri.UnescapeDataString(uri.Path);
            return Path.GetDirectoryName(path);
          }
        }

        public static void ReadCallback(IAsyncResult ar) {
            allDoneReceiving.Set();
            String content = String.Empty;

            StateObject state = (StateObject) ar.AsyncState;
            Socket handler = state.workSocket;

            int bytesRead = handler.EndReceive(ar);

            if (bytesRead > 0) {
                state.buffer.Append(Encoding.UTF8.GetString(
                    state.rawBuffer, 0, bytesRead
                ));

                content = state.buffer.ToString();
                if (content.IndexOf("\n") > -1) {
                    Console.WriteLine(
                        $"Read {content.Length} bytes from socket. \n" +
                        $"Data : {content}"
                    );

                    var stepsAssembly = Assembly.LoadFile(
                      Path.Combine(AssemblyDirectory, "Cukeness.Specs.dll")
                    );
                    var commandFactory = new StepCommandFactory(stepsAssembly);
                    var command = commandFactory.Create(content);

                    var response = command.Execute();

                    Send(handler, response.ToString() + "\r\n");

                } else {
                    handler.BeginReceive(
                        state.rawBuffer, 0, StateObject.BufferSize, 0,
                        new AsyncCallback(ReadCallback), state
                    );
                }
            }
        }

        public static void Send(Socket handler, String data) {
            byte[] rawData = Encoding.UTF8.GetBytes(data);

            Console.WriteLine(BitConverter.ToString(rawData));

            // TODO: Switch to using Environment.NewLine everywhere that \n appears
            Console.WriteLine(
              $"Write {data.Length} bytes to socket. " +
              Environment.NewLine + $"Data : {data}"
            );
            handler.BeginSend(
                rawData, 0, rawData.Length, 0,
                new AsyncCallback(SendCallback), handler
            );
        }

        public static void SendCallback(IAsyncResult ar) {
            try {
                Socket handler = (Socket) ar.AsyncState;

                int bytesSent = handler.EndSend(ar);

                Console.WriteLine(
                    $"Sent {bytesSent} bytes to client."
                );
            } catch (Exception e) {
                Console.WriteLine(e.ToString());
            }
        }
    }
}
