namespace Spoofi.AmoCrmIntegration.Interface
{
    public interface IAmoCrmResponse<T> : IAmoCrmResponse
    {
        T Response { get; set; }
    }

    public interface IAmoCrmResponse
    {
        dynamic Error { get; }
    }
}