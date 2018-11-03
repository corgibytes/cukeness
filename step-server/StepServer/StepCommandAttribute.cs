using System;

namespace StepServer
{
  [AttributeUsage(AttributeTargets.Class, Inherited = false)]
  public class StepCommandAttribute: Attribute
  {
    public string CommandName { get; }
    public bool ReceivesPayload { get; set; }
    public bool NeedsStepAssembly { get; set; }

    public StepCommandAttribute(string commandName)
    {
      CommandName = commandName;
      ReceivesPayload = false;
      NeedsStepAssembly = true;
    }
  }
}
