using System;
using System.Interop;
namespace SDL2
{
	extension GPU
	{
		//I Dont actually think we need this for anything
		public class OpenGL_4
		{
			public const char8* DEFAULT_TEXTURED_VERTEX_SHADER_SOURCE = """
				#version 400

				in vec2 gpu_Vertex;
				in vec2 gpu_TexCoord;
				in vec4 gpu_Color;
				uniform mat4 gpu_ModelViewProjectionMatrix;

				out vec4 color;
				out vec2 texCoord;

				void main(void)
				{
					color = gpu_Color;
					texCoord = vec2(gpu_TexCoord);
					gl_Position = gpu_ModelViewProjectionMatrix * vec4(gpu_Vertex, 0.0, 1.0);
				}
				""";

			public const char8* DEFAULT_UNTEXTURED_VERTEX_SHADER_SOURCE = """
				#version 400
				
				in vec2 gpu_Vertex;
				in vec4 gpu_Color;
				uniform mat4 gpu_ModelViewProjectionMatrix;
				
				out vec4 color;
				
				void main(void)
				{
					color = gpu_Color;
					gl_Position = gpu_ModelViewProjectionMatrix * vec4(gpu_Vertex, 0.0, 1.0);
				}
				""";

			public const char8* DEFAULT_TEXTURED_FRAGMENT_SHADER_SOURCE = """
				#version 400
				
				in vec4 color;
				in vec2 texCoord;
				
				uniform sampler2D tex;
				
				out vec4 fragColor;
				
				void main(void)
				{
				    fragColor = texture(tex, texCoord) * color;
				}
				""";

			public const char8* DEFAULT_UNTEXTURED_FRAGMENT_SHADER_SOURCE = """
				#version 400
				
				in vec4 color;
				
				out vec4 fragColor;
				
				void main(void)
				{
				    fragColor = color;
				}
				""";

			[CRepr]
			public struct ContextData_OpenGL_4
			{
				public SDL.Color last_color;
				public c_bool last_use_texturing;
				public c_uint last_shape;
				public c_bool last_use_blending;
				public BlendMode last_blend_mode;
				public Rect last_viewport;
				public Camera last_camera_inverted;

				public c_bool last_depth_test;
				public c_bool last_depth_write;
				public Comparison last_depth_function;

				public Image last_image;
				public float* blit_buffer; // Holds sets of 4 vertices, each with interleaved position, tex coords, and colors (e.g. [x0, y0, z0, s0, t0, r0, g0, b0, a0, ...]).
				public uint16 blit_buffer_num_verticies;
				public uint16 blit_buffer_max_num_verticies;
				public uint16* index_buffer; // Indexes into the blit buffer so we can use 4 vertices for every 2 triangles (1 quad)
				public c_uint index_buffer_num_verticies;
				public c_uint index_buffer_max_num_verticies;

				// Tier 3 rendering
				public c_uint blit_VAO;
				public c_uint[2] blit_VBO; // For double-buffering
				public c_uint blit_IDO;
				public c_bool blit_VBO_flop;

				public AttributeSource[16] shader_attributes;
				public c_uint[16] attribute_VBO;
			}

			[CRepr]
			public struct ImageData_OpenGL_4
			{
				public c_int refcount;
				public c_bool owns_handle;
				public uint32 handle;
				public uint32 format;
			}

			[CRepr]
			public struct TargetData_OpenGL_4
			{
				public c_int refcount;
				public uint32 handle;
				public uint32 format;
			}
		}
	}
}