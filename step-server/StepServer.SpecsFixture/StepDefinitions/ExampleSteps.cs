using System;
using System.Diagnostics;
using TechTalk.SpecFlow;

namespace StepServer.SpecsFixture.StepDefinitions
{
  [Binding]
  public class ExampleSteps
  {
    [Given("it passes without arguments")]
    public void PassingNoArgs()
    {
    }

    [When("it is pending without arguments")]
    public void PendingNoArgs()
    {
      throw new TechTalk.SpecFlow.PendingStepException();
    }

    [Then("it fails without arguments")]
    public void FailingNoArgs()
    {
      throw new Exception("this fails and takes no arguments");
    }

    [Given(@"it passes with an argument ""([^\""]*)""")]
    public void PassingTakesArguments(string first)
    {
    }

    [When(@"it is pending with an argument ""([^\""]*)""")]
    public void PendingTakesArguments(string first)
    {
      throw new TechTalk.SpecFlow.PendingStepException();
    }

    [Then(@"it fails with an argument ""([^\""]*)""")]
    public void FailingTakesArguments(string first)
    {
      throw new Exception("this fails and takes an argument");
    }
  }
}
