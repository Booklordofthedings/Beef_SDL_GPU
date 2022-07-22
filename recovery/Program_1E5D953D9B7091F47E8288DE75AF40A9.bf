using SDL2;
//using SDL2.
namespace Testing
{
	class Program
	{
		public static void Main()
		{
			SDL.Version v = GPU.GetLinkedVersion();
			GPU.SetPreInitFlags(.DEFAULT)
			System.Console.WriteLine(v.major);
			System.Console.WriteLine(v.minor);
			System.Console.WriteLine(v.patch);

			System.Console.ReadLine(scope .());
		}
	}
}