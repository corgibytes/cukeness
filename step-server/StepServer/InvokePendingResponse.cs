using System;
using Newtonsoft.Json.Linq;

namespace StepServer
{
  public class InvokePendingResponse: StepResponseBase
  {
    private readonly Exception _exception;
    public InvokePendingResponse(Exception exception)
    {
      Succeeded = false;
      _exception = exception;
    }

    protected override bool HasPayload { get; } = true;

    protected override string Status { get; } = "pending";

    protected override JToken UnformattedPayload
    {
      get { return JValue.CreateString(_exception.Message); }
    }
  }
}
