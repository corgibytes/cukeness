using System;
using Newtonsoft.Json.Linq;

namespace StepServer
{
  public class SuccessResponse: StepResponseBase
  {
    public SuccessResponse()
    {
      Succeeded = true;
    }

    protected override bool HasPayload => false;

    protected override JArray UnformattedPayload
    {
      get
      {
        throw new NotImplementedException();
      }
    }
  }
}
