namespace StepServer
{
  public class SuccessResponse: IStepResponse
  {
    public bool Succeeded => true;
    public string Payload => null;

    public override string ToString()
    {
      return base.ToString();
    }
  }
}
