namespace StepServer
{
  public class BeginScenarioCommand: IStepCommand
  {
    public IStepResponse Execute()
    {
      return new SuccessResponse();
    }
  }
}
