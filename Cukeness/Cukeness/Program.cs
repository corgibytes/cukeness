using System;
using Nancy.Hosting.Self;

namespace Cukeness
{
	internal class Program
	{
		private static void Main(string[] args)
		{
			using (var host =
				new NancyHost(new HostConfiguration {UrlReservations = new UrlReservations {CreateAutomatically = true}},
					new Uri("http://localhost:1234")))
			{
				host.Start();
				Console.WriteLine("Running on http://localhost:1234");
				Console.ReadLine();
			}
		}
	}
}