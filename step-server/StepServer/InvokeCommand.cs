using System;
using System.Collections.Generic;
using System.Net.NetworkInformation;
using System.Reflection;
using System.Text.RegularExpressions;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Serialization;

namespace StepServer
{
  [StepCommand("invoke", ReceivesPayload = true)]
  public class InvokeCommand: IStepCommand
  {
    private Assembly _stepsAssembly;
    private string _payload;

    public InvokeCommand(Assembly assembly, string payload)
    {
      _stepsAssembly = assembly;
      _payload = payload;
    }

    private int MethodID
    {
      get
      {
        var parsedPayload = JObject.Parse(_payload);
        return int.Parse(parsedPayload["id"].Value<string>());
      }
    }


    public IStepResponse Execute()
    {
      IStepResponse response = null;

      foreach (var type in _stepsAssembly.GetTypes())
      {
        if (type.IsPublic && type.IsClass && !type.IsAbstract)
        {
          var members = type.GetMembers();

          var memberToInvoke = members[MethodID - 1];

          var ctor = type.GetConstructor(new Type[] { });
          var instance = ctor.Invoke(new object[] { });

          try
          {
            type.InvokeMember(
              memberToInvoke.Name,
              BindingFlags.InvokeMethod | BindingFlags.Instance |
              BindingFlags.Public,
              null,
              instance,
              new object[] { }
            );
            response = new InvokeSuccessResponse();
          }
          catch (TargetInvocationException error)
          {
            var innerExceptionType = error.InnerException.GetType();

            if (innerExceptionType.Name == "PendingStepException")
            {
              response = new InvokePendingResponse(error.InnerException);
            }
            else
            {
              response = new InvokeFailureResponse(error.InnerException);
            }
          }
        }
      }

      return response;
    }
  }
}
