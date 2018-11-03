using System;
using TechTalk.SpecFlow;

namespace Cukeness.Specs.StepDefinitions
{
    [Binding]
    public class GitSteps
    {
        //private readonly CukenessDriver _driver;

        //public GitSteps(CukenessDriver driver) 
        //{
        //    _driver = driver ?? throw new ArgumentNullException(nameof(driver));
        //}

        [When(@"there is an organization named ""([^\""]*)"" with a project named ""([^\""]*)""")]   
        public void WhenThereIsANewOrganizationNamedWithAProjectNamed(
            string organizationName, string projectName) 
        {
            throw new NotImplementedException();
        }
    }
}
