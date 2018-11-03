using System;
using TechTalk.SpecFlow;

namespace Cukeness.Specs.StepDefinitions
{
    [Binding]
    public class GitSteps
    {
        [When(
          @"there is an organization named ""([^\""]*)"" with a project " +
          @"named ""([^\""]*)"""
        )]
        public void WhenThereIsANewOrganizationNamedWithAProjectNamed(
            string organizationName,
            string projectName
        )
        {
            throw new NotImplementedException();
        }
    }
}
