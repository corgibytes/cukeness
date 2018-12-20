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

    protected override JToken UnformattedPayload
    {
      get
      {
        throw new NotImplementedException();
      }
    }
  }
}
