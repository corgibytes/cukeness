namespace StepServer
{
  [StepCommand("end_scenario", NeedsStepAssembly = false)]
  public class EndScenarioCommand: IStepCommand
  {
    public IStepResponse Execute()
    {
      return new SuccessResponse();
    }
  }
}
