namespace StepServer
{
  [StepCommand("begin_scenario", NeedsStepAssembly = false)]
  public class BeginScenarioCommand: IStepCommand
  {
    public IStepResponse Execute()
    {
      return new SuccessResponse();
    }
  }
}
