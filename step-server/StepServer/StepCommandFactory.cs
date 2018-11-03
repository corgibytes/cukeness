using System;
using System.Collections.Generic;
using System.Reflection;
using Newtonsoft.Json.Linq;

namespace StepServer
{
  public class StepCommandFactory
  {
    private Assembly _stepsAssembly;
    private Dictionary<
      string,
      (Type stepCommandType, bool needsStepAssembly, bool receivesPayload)
    > _commands;

    public StepCommandFactory(Assembly stepsStepsAssembly)
    {
      _stepsAssembly = stepsStepsAssembly;

      _commands = new Dictionary<string, (Type, bool, bool)>();
      foreach (var type in Assembly.GetExecutingAssembly().GetTypes())
      {
        if (type.IsClass && !type.IsAbstract)
        {
          foreach (var attribute in type.GetCustomAttributes())
          {
            if (attribute is StepCommandAttribute stepCommandAttribute)
            {
              _commands.Add(
                stepCommandAttribute.CommandName,
                (
                  stepCommandType: type,
                  needsStepAssembly: stepCommandAttribute.NeedsStepAssembly,
                  receivesPayload: stepCommandAttribute.ReceivesPayload
                )
              );
            }
          }
        }
      }
    }

    public IStepCommand Create(string message)
    {
      IStepCommand result = null;

      var parsedMessage = JArray.Parse(message);
      var command = parsedMessage[0].Value<string>();

      var commandMatch = _commands[command];

      if (commandMatch.receivesPayload && commandMatch.needsStepAssembly)
      {
        var constructor = commandMatch.stepCommandType.GetConstructor(
          new Type[] {typeof(Assembly), typeof(string)}
        );
        result = (IStepCommand) constructor.Invoke(
          new object[] {_stepsAssembly, parsedMessage[1].ToString()}
        );
      }
      else
      {
        var constructor = commandMatch.stepCommandType.GetConstructor(
          new Type[] { }
        );
        result = (IStepCommand) constructor.Invoke(new object[] { });
      }

      return result;
    }
  }
}
