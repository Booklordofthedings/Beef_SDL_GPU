using SDL2;
//using SDL2.
namespace Testing
{
	class Program
	{
		public static int x = 10;
		public static void Main()
		{
			
			GPU.Target* screen;

			GPU.SetDebugLevel(.LEVEL_1);

			screen = GPU.Init(800,600, (.)GPU.InitFlag.DEFAULT);
			if(screen == null)
				return;

			GPU.EnableCamera(screen, true);
			MainLoop(screen);
			GPU.Quit();
		}

		public static void MainLoop(GPU.Target* screen)
		{
			uint8 done;
			SDL.Event event;
			uint32 start_time;
			uint32 end_time;
			float dt;
			GPU.Camera camera;
			GPU.Image* image1;
			GPU.Image* image2;

			image1 = GPU.LoadImage("F:/Data/Desktop/Beef_SDL_GPU/Testing/img1.png");
			image2 = GPU.LoadImage("F:/Data/Desktop/Beef_SDL_GPU/Testing/img2.png");

			camera = GPU.GetDefaultCamera();

			start_time = SDL.GetTicks();
			dt = 0.0f;

			done = 0;
			while(done != 1)
			{
				while(SDL.PollEvent(out event) != 0)
				{
					if(event.type == .Quit)
						done = 1;
					else if(event.type == .KeyDown)
					{
						if(event.key.keysym.sym == .ESCAPE)
							done = 1;
						else if(event.key.keysym.sym == .C)
						    camera.use_centered_origin = !camera.use_centered_origin;
						else if(event.key.keysym.sym == .W)
						    camera.y -= 800*dt;
						else if(event.key.keysym.sym == .S)
						    camera.y += 800*dt;
						else if(event.key.keysym.sym == .A)
						    camera.x -= 800*dt;
						else if(event.key.keysym.sym == .D)
						    camera.x += 800*dt;
						else if(event.key.keysym.sym == .D)
						    camera.x += 800*dt;
						else if(event.key.keysym.sym == .R)
						    camera.zoom_x = camera.zoom_y += 2*dt;
						else if(event.key.keysym.sym == .F)
						    camera.zoom_x = camera.zoom_y -= 2*dt;
						else if(event.key.keysym.sym == .Q)
						    camera.angle -= 45*dt;
						else if(event.key.keysym.sym == .E)
						    camera.angle += 45*dt;
					}
				}

				GPU.SetCamera(screen, &camera);

				GPU.Clear(screen);

				for (int i = -10; i < 10; i++) {
				    GPU.BlitScale(image2, null, screen, i*128, 0, 0.5f, 0.5f);
				    GPU.BlitScale(image2, null, screen, 0, i*128, 0.5f, 0.5f);
				    GPU.BlitScale(image1, null, screen, i*100, i*100, 0.5f, 0.5f);
				    GPU.BlitScale(image1, null, screen, i*100, -i*100, 0.5f, 0.5f);
				}

				GPU.Flip(screen);

				SDL.Delay(10);

				end_time = SDL.GetTicks();
				dt = (end_time - start_time) / 1000.0f;
				start_time = end_time;
			}


		}
	}
}