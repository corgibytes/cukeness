namespace StepServer
{
  public class EndScenarioCommand: IStepCommand
  {
    public IStepResponse Execute()
    {
      return new SuccessResponse();
    }
  }
}
