using System.Reflection;

namespace StepServer
{
  [StepCommand("invoke", ReceivesPayload = true)]
  public class InvokeCommand: IStepCommand
  {
    public InvokeCommand(Assembly assembly, string payload)
    {

    }

    public IStepResponse Execute()
    {
      throw new System.NotImplementedException();
    }
  }
}
