using System.Globalization;

namespace StepServer
{
  public interface IStepResponse
  {
    bool Succeeded { get; }
    string Payload { get; }
  }
}
