using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace StepServer
{
  public class StepMatchesResponse: IStepResponse
  {

    public StepMatchesResponse(
      bool succeeded,
      string matchId=null,
      params string[] args
    )
    {
      Succeeded = succeeded;
      Args = args;
      MatchId = matchId;
    }

    public bool Succeeded { get; }
    public string[] Args { get; }
    public string MatchId { get; }

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
          return "failure";
        }
      }
    }

    public override string ToString()
    {
      var result = new JArray();
      var status = JValue.CreateString(Status);

      result.Add(status);
      result.Add(UnformattedPayload);

      return result.ToString(Formatting.None, Array.Empty<JsonConverter>());
    }

    private JArray UnformattedPayload
    {
      get
      {
        var messages = new JArray();

        var message = new JObject
        {
          ["id"] = JValue.CreateString(MatchId)
        };

        var args = new JArray();
        foreach (var arg in Args)
        {
          args.Add(JValue.CreateString(arg));
        }

        message["args"] = args;

        messages.Add(message);
        return messages;
      }
    }

    public string Payload => UnformattedPayload.ToString(
      Formatting.None, Array.Empty<JsonConverter>()
    );
  }
}
