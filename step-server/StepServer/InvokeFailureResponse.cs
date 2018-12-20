using System;
using Newtonsoft.Json.Linq;

namespace StepServer
{
  public class InvokeFailureResponse: StepResponseBase
  {
    private readonly Exception _failure;

    public InvokeFailureResponse(Exception failure)
    {
      _failure = failure;
      Succeeded = false;
    }
    protected override bool HasPayload
    {
      get { return true; }
    }

    protected override JToken UnformattedPayload
    {
      get
      {
        return new JObject()
        {
          ["message"] = JValue.CreateString(_failure.Message),
          ["exception"] = JValue.CreateString(_failure.GetType().Name)
        };
      }
    }
  }
}
