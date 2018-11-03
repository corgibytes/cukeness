using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace StepServer
{
  public class StepMatchesResponse: StepResponseBase
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

    public string[] Args { get; }
    public string MatchId { get; }

    protected override bool HasPayload => true;
    protected override JArray UnformattedPayload
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
  }
}
