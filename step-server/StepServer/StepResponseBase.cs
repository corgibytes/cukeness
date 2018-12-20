using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace StepServer
{
  public abstract class StepResponseBase : IStepResponse
  {
    public bool Succeeded { get; protected set; }

    private string Status
    {
      get
      {
        if (Succeeded)
        {
          return "success";
        }
        else
        {
          return "fail";
        }
      }
    }

    protected abstract bool HasPayload { get; }
    protected abstract JToken UnformattedPayload { get; }

    public string Payload
    {
      get
      {
        if (HasPayload)
        {
          return UnformattedPayload.ToString(
            Formatting.None, Array.Empty<JsonConverter>()
          );
        }

        return null;
      }
    }

    public override string ToString()
    {
      var result = new JArray();
      var status = JValue.CreateString(Status);

      result.Add(status);
      if (HasPayload)
      {
        result.Add(UnformattedPayload);
      }

      return result.ToString(Formatting.None, Array.Empty<JsonConverter>());
    }
  }
}
