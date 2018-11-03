using System.Reflection;
using Newtonsoft.Json.Linq;

namespace StepServer
{
  public class StepCommandFactory
  {
    private Assembly _stepsAssembly;

    public StepCommandFactory(Assembly stepsStepsAssembly)
    {
      _stepsAssembly = stepsStepsAssembly;
    }

    public IStepCommand Create(string message)
    {
      IStepCommand result = null;

      var parsedMessage = JArray.Parse(message);
      var command = parsedMessage[0].Value<string>();

      if (command == "step_matches")
      {
        result = new StepMatchesCommand(
          _stepsAssembly,
          parsedMessage[1].ToString()
        );
      }

      return result;
    }
  }
}
