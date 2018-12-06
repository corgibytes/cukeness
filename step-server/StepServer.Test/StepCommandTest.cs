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
      var stepCommand = CukenessStepsCommandFactory.Create(
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
    public void StepMatchesGivenWithNoArguments()
    {
      var stepCommand = FixtureStepsCommandFactory.Create(
        @"[""step_matches"",{""name_to_match"":""it passes without arguments""}]"
      );
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().Be(
        @"[{""id"":""1"",""args"":[]}]"
      );
      response.ToString().Should().Be(
        @"[""success"",[{""id"":""1"",""args"":[]}]]"
      );
    }

    [TestMethod]
    public void StepMatchesWhenWithNoArguments()
    {
      Assert.Fail();
    }

    [TestMethod]
    public void StepMatchesThenWithNoArguments()
    {
      AssertStepMatch("it fails without arguments", "3");
    }

    private static void AssertStepMatch(string matchExpression, string id)
    {
      var stepCommand = FixtureStepsCommandFactory.Create(
        @"[""step_matches"",{""name_to_match"":""" + matchExpression + @"""}]"
      );
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().Be(
        @"[{""id"":""" + id + @""",""args"":[]}]"
      );
      response.ToString().Should().Be(
        @"[""success"",[{""id"":""" + id + @""",""args"":[]}]]"
      );
    }

    [TestMethod]
    public void StepMatchesGivenWithAnArgument()
    {
      Assert.Fail();
    }

    [TestMethod]
    public void StepMatchesThenWithAnArgument()
    {
      Assert.Fail();
    }

    [TestMethod]
    public void StepMatchesWhenWithAnArgument()
    {
      Assert.Fail();
    }

    [TestMethod]
    public void BeginScenario()
    {
      var stepCommand = CukenessStepsCommandFactory.Create(@"[""begin_scenario""]");
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().BeNull();
      response.ToString().Should().Be(@"[""success""]");
    }

    [TestMethod]
    public void EndScenario()
    {
      var stepCommand = CukenessStepsCommandFactory.Create(@"[""end_scenario""]");
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().BeNull();
      response.ToString().Should().Be(@"[""success""]");
    }

    [TestMethod]
    public void InvokePassing()
    {
      var stepCommand = FixtureStepsCommandFactory.Create(
        @"[""invoke"",{""id"":""1""}]"
      );
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().BeNull();
      response.ToString().Should().Be(@"[""success""]");
    }

    [TestMethod]
    public void InvokePending()
    {
      var stepCommand = FixtureStepsCommandFactory.Create(
        @"[""invoke"",{""id"":""2""]"
      );
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().BeNull();
      response.ToString().Should().Be(
        @"[""pending"", " +
        @"""One or more step definitions are not implemented yet.""]"
      );
    }

    [TestMethod]
    public void InvokeFailing()
    {
      var stepCommand = FixtureStepsCommandFactory.Create(
        @"[""invoke"",{""id"":""3""]"
      );
      var response = stepCommand.Execute();
      response.Succeeded.Should().Be(true);
      response.Payload.Should().BeNull();
      response.ToString().Should().Be(
        @"[""failing"", ""this fails and takes no arguments""]"
      );
    }

    [TestMethod]
    public void InvokePassingWithArgument()
    {
      throw new Exception();
    }

    [TestMethod]
    public void InvokePendingWithArgument()
    {
      throw new Exception();
    }

    [TestMethod]
    public void InvokeFailingWithArgument()
    {
      throw new Exception();
    }

    private static StepCommandFactory GetFactoryForAssemblyName(string name)
    {
      var stepsAssembly = Assembly.LoadFile(
        Path.Combine(AssemblyDirectory, name)
      );

      var stepCommandFactory = new StepCommandFactory(stepsAssembly);
      return stepCommandFactory;
    }

    private static StepCommandFactory CukenessStepsCommandFactory
    {
      get { return GetFactoryForAssemblyName("Cukeness.Specs.dll"); }
    }

    private static StepCommandFactory FixtureStepsCommandFactory
    {
      get
      {
        return GetFactoryForAssemblyName("StepServer.SpecsFixture.dll");
      }
    }
  }
}
