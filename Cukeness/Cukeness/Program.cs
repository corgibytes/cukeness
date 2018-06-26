using System;
using Nancy.Hosting.Self;

namespace Cukeness
{
	internal class Program
	{
		private static void Main(string[] args)
		{
			var configuration = new HostConfiguration {UrlReservations = new UrlReservations {CreateAutomatically = true}};
			using (var host = new NancyHost(configuration, new Uri("http://localhost:1234")))
			{
				host.Start();
				Console.WriteLine("Running on http://localhost:1234");
				Console.ReadLine();
			}
		}
	}
}