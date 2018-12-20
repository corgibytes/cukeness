using Newtonsoft.Json.Linq;

namespace StepServer
{
  public class InvokeSuccessResponse: StepResponseBase
  {
    public InvokeSuccessResponse()
    {
      Succeeded = true;
    }

    protected override bool HasPayload
    {
      get { return false; }
    }

    protected override JArray UnformattedPayload
    {
      get { return null; }
    }
  }
}
