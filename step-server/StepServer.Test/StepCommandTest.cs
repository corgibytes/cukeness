using System;
using System.IO;
using System.Reflection;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using FluentAssertions;

namespace StepServer.Test
{
  [TestClass]
  public class StepCommandTest
  {
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

    [TestMethod]
    public void StepMatches()
    {
      var stepCommand = StepCommandFactory.Create(
        @"[""step_matches"",{""name_to_match"":""there is an organization " +
        @"named \""git\"" with a project named \""interactions\""""}]"
      );
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().Be(
        @"[{""id"":""1"",""args"":[""git"",""interactions""]}]"
      );
      response.ToString().Should().Be(
        @"[""success"",[{""id"":""1"",""args"":[""git"",""interactions""]}]]"
      );
    }

    [TestMethod]
    public void BeginScenario()
    {
      var stepCommand = StepCommandFactory.Create(@"[""begin_scenario""]");
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().BeNull();
      response.ToString().Should().Be(@"[""success""]");
    }

    [TestMethod]
    public void EndScenario()
    {
      var stepCommand = StepCommandFactory.Create(@"[""end_scenario""]");
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().BeNull();
      response.ToString().Should().Be(@"[""success""]");
    }

    private static StepCommandFactory StepCommandFactory
    {
      get
      {
        var stepsAssembly = Assembly.LoadFile(
          Path.Combine(AssemblyDirectory, "Cukeness.Specs.dll")
        );

        var stepCommandFactory = new StepCommandFactory(stepsAssembly);
        return stepCommandFactory;
      }
    }
  }
}
