using FluentAssertions;
using NUnit.Framework;

namespace Cukeness.Test
{
	[TestFixture]
	public class TheTestsRun
	{
		[Test]
		public void TestThatPasses()
		{
			1.Should().BeGreaterThan(0);
		}
	}
}