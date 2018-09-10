using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace server
{
    class Program
    {
        static void Main(string[] args)
        {
            AsyncSocketListener.StartListening();
        }
    }

    public class StateObject {
        public Socket workSocket = null;
        public const int BufferSize = 1024;
        public byte[] rawBuffer = new byte[BufferSize];
        public StringBuilder buffer = new StringBuilder();
    }

    public class AsyncSocketListener {
        public static ManualResetEvent allDone = new ManualResetEvent(false);

        public AsyncSocketListener() {
        }

        public static void StartListening() {
            var port = 9666;
            IPEndPoint localEndPoint = new IPEndPoint(IPAddress.Any, port);

            Socket listener = new Socket(AddressFamily.InterNetwork,
                SocketType.Stream, ProtocolType.Tcp
            );

            try {
                listener.Bind(localEndPoint);
                listener.Listen(100);

                while (true) {
                    allDone.Reset();

                    Console.WriteLine(
                        $@"Waiting for a connection on {
                            localEndPoint.ToString()
                        }..."
                    );
                    listener.BeginAccept(
                        new AsyncCallback(AcceptCallback),
                        listener
                    );

                    allDone.WaitOne();
                }
            } catch (Exception e) {
                Console.WriteLine(e.ToString());
            }

            Console.WriteLine("\nPress ENTER to continue...");
            Console.Read();
        }

        public static void AcceptCallback(IAsyncResult ar) {
            allDone.Set();

            Socket listener = (Socket) ar.AsyncState;
            Socket handler = listener.EndAccept(ar);

            StateObject state = new StateObject();
            state.workSocket = handler;
            handler.BeginReceive(state.rawBuffer, 0, StateObject.BufferSize, 0,
                new AsyncCallback(ReadCallback), state
            );
        }

        public static void ReadCallback(IAsyncResult ar) {
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
                    Send(handler, content);
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

                handler.Shutdown(SocketShutdown.Both);
                handler.Close();
            } catch (Exception e) {
                Console.WriteLine(e.ToString());
            }
        }
    }
}
