using System;
using System.Interop;
namespace SDL2
{
	public static class GPU
	{
#if BF_32_BIT
		typealias PAD_1_TO_32  = char8[1];
		typealias PAD_2_TO_32 = char8[2];
		typealias PAD_3_TO_32 = char8[3];
		typealias PAD_1_TO_64 = char8[1];
		typealias PAD_2_TO_64 = char8[2];
		typealias PAD_3_TO_64 = char8[3];
		typealias PAD_4_TO_64 = char8[4];
		typealias PAD_5_TO_64 = char8[5];
		typealias PAD_6_TO_64 = char8[6];
		typealias PAD_7_TO_64 = char8[7];
#elif BF_64_BIT
		typealias PAD_1_TO_32 = char8[1];
		typealias PAD_2_TO_32 = char8[2];
		typealias PAD_3_TO_32 = char8[3];

		typealias PAD_1_TO_64 = char8[1];
		typealias PAD_2_TO_64 = char8[2];
		typealias PAD_3_TO_64 = char8[3];
		typealias PAD_4_TO_64 = void;
		typealias PAD_5_TO_64 = char8[1];
		typealias PAD_6_TO_64 = char8[2];
		typealias PAD_7_TO_64 = char8[3];
#endif



		[CRepr]
		public struct Rect
		{
			public float x, y;
			public float w, h;
		}

		public const c_int RENDERER_ORDER_MAX = 10;

		public enum RendererE : uint32
		{
			RENDERER_UNKNOWN = 0,
			RENDERER_OPENGL_1_BASE = 1,
			RENDERER_OPENGL_1 = 2,
			RENDERER_OPENGL_2 = 3,
			RENDERER_OPENGL_3 = 4,
			RENDERER_OPENGL_4 = 5,
			RENDERER_GLES_1 = 11,
			RENDERER_GLES_2 = 12,
			RENDERER_GLES_3 = 13,
			RENDERER_D3D9 = 21,
			RENDERER_D3D10 = 22,
			RENDERER_D3D11 = 23
		}

		public const c_int RENDERER_CUSTOM_0 = 1000;

		[CRepr]
		public struct RendererID
		{
			public char8* name;
			public RendererE renderer;
			public int32 major_version;
			public int32 minor_version;

			private PAD_4_TO_64 pad;
		}

		public enum Comparison : uint32
		{
			NEVER = 0x0200,
			LESS = 0x0201,
			EQUAL = 0x0202,
			LEQUAL = 0x0203,
			GREATER = 0x0204,
			NOTEQUAL = 0x0205,
			GEQUAL = 0x0206,
			ALWAYS = 0x0207
		}

		public enum BlendFunc : uint32
		{
		    FUNC_ZERO = 0,
		    FUNC_ONE = 1,
		    FUNC_SRC_COLOR = 0x0300,
		    FUNC_DST_COLOR = 0x0306,
		    FUNC_ONE_MINUS_SRC = 0x0301,
		    FUNC_ONE_MINUS_DST = 0x0307,
		    FUNC_SRC_ALPHA = 0x0302,
		    FUNC_DST_ALPHA = 0x0304,
		    FUNC_ONE_MINUS_SRC_ALPHA = 0x0303,
		    FUNC_ONE_MINUS_DST_ALPHA = 0x0305
		}

		public enum BlendEq : uint32
		{
			EQ_ADD = 0x8006,
			EQ_SUBTRACT = 0x800A,
			EQ_REVERSE_SUBTRACT = 0x800B
		}

		[CRepr]
		public struct BlendMode
		{
			public BlendFunc source_color;
			public BlendFunc dest_color;
			public BlendFunc source_alpha;
			public BlendFunc dest_alpha;

			public BlendEq color_equation;
			public BlendEq alpha_equation;
		}

		public enum BlendPresent : uint32
		{
			BLEND_NORMAL = 0,
			BLEND_PREMULTIPLIED_ALPHA = 1,
			BLEND_MULTIPLY = 2,
			BLEND_ADD = 3,
			BLEND_SUBTRACT = 4,
			BLEND_MOD_ALPHA = 5,
			BLEND_SET_ALPHA = 6,
			BLEND_SET = 7,
			BLEND_NORMAL_KEEP_ALPHA = 8,
			BLEND_NORMAL_ADD_ALPHA = 9,
			BLEND_NORMAL_FACTOR_ALPHA = 10
		}

		public enum Filter : uint32
		{
			FILTER_NEAREST = 0,
			FILTER_LINEAR = 1,
			FILTER_LINEAR_MIPMAP = 2
		}

		public enum Snap : uint32
		{
			SNAP_NONE = 0,
			SNAP_POSITION = 1,
			SNAP_DIMENSIONS = 2,
			SNAP_POSITION_AND_DIMENSIONS = 3
		}

		public enum Wrap : uint32
		{
			WRAP_NONE = 0,
			WRAP_REPEAT = 1,
			WRAP_MIRRORED = 2
		}

		public enum Format : uint32
		{
			FORMAT_LUMINANCE = 1,
			FORMAT_LUMINANCE_ALPHA = 2,
			FORMAT_RGB = 3,
			FORMAT_RGBA = 4,
			FORMAT_ALPHA = 5,
			FORMAT_RG = 6,
			FORMAT_YCbCr422 = 7,
			FORMAT_YCbCr420P = 8,
			FORMAT_BGR = 9,
			FORMAT_BGRA = 10,
			FORMAT_ABGR = 11
		}

		public enum FileFormat : uint32
		{
			FILE_AUTO = 0,
			FILE_PNG,
			FILE_BMP,
			FILE_TGA
		}

		[CRepr]
		public struct Image
		{
			public Renderer* renderer;
			//TODO: Target* context_target;
			//TODO: Target* target;
			public void* data;

			public uint16 w, h;
			public Format format;
			public c_int num_layers;
			public c_int byter_per_pixel;
			public uint16 base_w, base_h; // Original image dimensions
			public uint16 texture_w, texture_h; // Underlying texture dimensions

			public float anchor_x; // Normalized coords for the point at which the image is blitted.  Default is (0.5, 0.5), that is, the image is drawn centered.
			public float anchor_y; // These are interpreted according to GPU_SetCoordinateMode() and range from (0.0 - 1.0) normally.

			public SDL.Color color;
			public BlendMode blend_mode;
			public Filter filter_mode;
			public Snap snap_mode;
			public Wrap wrap_mode_x;
			public Wrap wrap_mode_y;

			public c_int refcount;

			public c_bool using_virtual_resolution;
			public c_bool has_mipmaps;
			public c_bool use_blending;
			public c_bool is_alias;
		}

		public typealias TextureHandle = c_uintptr;

		[CRepr]
		public struct Camera
		{
			public float x, y, z;
			public float angle;
			public float zoom_x, zoom_y;
			public float z_near, z_far;
			public c_bool use_centered_origin;

			private PAD_7_TO_64 pad;
		}

		[CRepr]
		public struct ShaderBlock
		{
			// Attributes
			public c_int position_loc;
			public c_int texcoord_loc;
			public c_int color_loc;
			//Uniforms
			public c_int modelViewProjection_loc;
		}

		public const c_int MODEL = 0;
		public const c_int VIEW = 1;
		public const c_int PROJECTION = 2;


		//Matrix stack data structure for global vertex transforms
		[CRepr]
		public struct MatrixStack
		{
			public c_uint storage_size;
 			public c_uint size;
			public float** matrix;
		}

		// Rendering context data.  Only GPU_Targets which represent windows will store this.
		[CRepr]
		public struct Context
		{
			/*! SDL_GLContext */
			public SDL.SDL_GLContext context;

			/*! Last target used */
			//TODO: public Target* active_target;

			public ShaderBlock current_shader_block;
			public ShaderBlock default_textured_shader_block;
			public ShaderBlock default_untextured_shader_block;

			/*! SDL window ID */
			public uint32 windowID;

			/*! Actual window dimensions */
			public c_int window_w;
			public c_int window_h;

			/*! Drawable region dimensions */
			public c_int drawable_w;
			public c_int drawable_h;

			/*! Window dimensions for restoring windowed mode after GPU_SetFullscreen(1,1). */
			public c_int stored_window_w;
			public c_int stored_window_h;

			/*! Shader handles used in the default shader programs */
			public uint32 default_textured_vertex_shader_id;
			public uint32 default_textured_fragment_shader_id;
			public uint32 default_untextured_vertex_shader_id;
			public uint32 default_untextured_fragment_shader_id;

			/*! Internal state */
			public uint32 current_shader_program;
			public uint32 default_textured_shader_program;
			public uint32 default_untextured_shader_program;

			public BlendMode shapes_blend_mode;
			public float line_thickness;

			public int refcount;

			public void* data;

			public c_bool failed;
			public c_bool use_texturing;
			public c_bool shapes_use_blending;

			private PAD_5_TO_64 pad;
		}

		[CRepr]
		public struct Target
		{
			public Renderer* renderer;
			public Target* context_target;
			public Image* image;
			public void* data;
			public uint16 w, h;
			public uint16 base_w, base_h; // The true dimensions of the underlying image or window
			public Rect clip_rect;
			public SDL.Color color;

			public Rect viewport;

			/*! Perspective and object viewing transforms. */
			public c_int matrix_mode;
			public MatrixStack projection_matrix;
			public MatrixStack view_matrix;
			public MatrixStack model_matrix;

			public Camera camera;

			public c_bool using_virtual_resolution;
			public c_bool use_clip_rect;
			public c_bool use_color;
			public c_bool use_camera;

			public Comparison depth_function;

			/*! Renderer context data.  NULL if the target does not represent a window or rendering context. */
			public Context* context;
			public c_int refcount;

			public c_bool use_depth_test;
			public c_bool use_depth_write;
			public c_bool is_alias;

			private PAD_1_TO_64 pad;
		}

		[AllowDuplicates]
		public enum Feature : uint32
		{
			NON_POWER_OF_TWO = 0x1,
			RENDER_TARGETS = 0x2,
			BLEND_EQUATIONS = 0x4,
			BLEND_FUNC_SEPERATE = 0x8,
			BLEND_EQUATIONS_SEPARATE = 0x10,
			GL_BGR = 0x20,
			GL_BGRA = 0x40,
			GL_ABGR = 0x80,
			VERTEX_SHADER = 0x100,
			FRAGMENT_SHADER = 0x200,
			PIXEL_SHADER = 0x200,
			GEOMETRY_SHADER = 0x400,
			WRAP_REPEAT_MIRRORED = 0x800,
			CORE_FRAMEBUFFER_OBJECTS = 0x1000,

			ALL_BASE = .RENDER_TARGETS,
			ALL_BLEND_PRESETS = (.BLEND_EQUATIONS | .BLEND_FUNC_SEPERATE),
			ALL_GL_FORMATS = (.GL_BGR | .GL_BGRA | .GL_ABGR),
			BASIC_SHADERS = (.FRAGMENT_SHADER | .VERTEX_SHADER),
			ALL_SHADERS = (.FRAGMENT_SHADER | .VERTEX_SHADER | .GEOMETRY_SHADER)
		}

		typealias WindowFlag = uint32;

		public enum InitFlag : uint32
		{
			ENABLE_VSYNC = 0x1,
			DISABLE_VSYNC = 0x2,
			DISABLE_DOUBLE_BUFFER = 0x4,
			DISABLE_AUTO_VIRTUAL_RESOLUTION = 0x8,
			REQUEST_COMPATIBILITY_PROFILE = 0x10,
			USE_ROW_BY_ROW_TEXTURE_UPLOAD_FALLBACK = 0x20,
			USE_COPY_TEXTURE_UPLOAD_FALLBACK = 0x40,

			DEFAULT = 0
		}

		public const uint32 NONE = 0x0;


		public enum Primitive : uint32
		{
			POINTS = 0x0,
			LINES = 0x1,
			LINES_LOOP = 0x2,
			LINES_STRIP = 0x3,
			TRIANGLES = 0x4,
			TRIANGLE_STRIP = 0x5,
			TRIANGLE_FAN = 0x6
		}

		public enum BatchFlag : uint32
		{
			BATCH_XY = 0x1,
			BATCH_XYZ = 0x2,
			BATCH_ST = 0x4,
			BATCH_RGB = 0x8,
			BATCH_RGBA = 0x10,
			BATCH_RGB8 = 0x20,
			BATCH_RGBA8 = 0x40,

			BATCH_XY_ST = (.BATCH_XY | .BATCH_ST),
			BATCH_XYZ_ST = (.BATCH_XYZ | .BATCH_ST),
			BATCH_XY_RGB = (.BATCH_XY | .BATCH_RGB),
			BATCH_XYZ_RGB = (.BATCH_XYZ | .BATCH_RGB),
			BATCH_XY_RGBA = (.BATCH_XY | .BATCH_RGBA),
			BATCH_XYZ_RGBA = (.BATCH_XYZ | .BATCH_RGBA),
			BATCH_XY_ST_RGBA = (.BATCH_XY | .BATCH_ST | .BATCH_RGBA),
			BATCH_XYZ_ST_RGBA = (.BATCH_XYZ | .BATCH_ST |.BATCH_RGBA),
			BATCH_XY_RGB8 = (.BATCH_XY | .BATCH_RGB8),
			BATCH_XYZ_RGB8 = (.BATCH_XYZ | .BATCH_RGB8),
			BATCH_XY_RGBA8 = (.BATCH_XY | .BATCH_RGBA8),
			BATCH_XYZ_RGBA8 = (.BATCH_XYZ | .BATCH_RGBA8),
			BATCH_XY_ST_RGBA8 = (.BATCH_XY | .BATCH_ST | .BATCH_RGBA8),
			BATCH_XYZ_ST_RGBA8 = (.BATCH_XYZ | .BATCH_ST | .BATCH_RGBA8)
		}

		public enum Flip : uint32
		{
			FLIP_NONE = 0x0,
			FLIP_HORIZONTAL = 0x1,
			FLIP_VERTICAL = 0x2
		}

		public enum Type : uint32
		{
			TYPE_BYTE = 0x1400,
			TYPE_UNSIGNED_BYTE = 0x1401,
			TYPE_SHORT = 0x1402,
			TYPE_UNSIGNED_SHORT = 0x1403,
			TYPE_INT = 0x1404,
			TYPE_UNSIGNED_INT = 0x1405,
			TYPE_FLOAT = 0x1406,
			TYPE_DOUBLE = 0x140A
		}

		[AllowDuplicates]
		public enum Shader : uint32
		{
			VERTEX_SHADER = 0,
			FRAGMENT_SHADER = 1,
			PIXEL_SHADER = 1,
			GEOMETRY_SHADER = 2
		}

		public enum ShaderLanguage : uint32
		{
			NONE = 0,
			ARB_ASSEMBLY = 1,
			GLSL = 2,
			GLSLES = 3,
			HLSL = 4,
			CG = 5
		}

		[CRepr]
		public struct AttributeFormat
		{
			public c_int num_elems_per_value;
			public Type type;					// GPU_TYPE_FLOAT, GPU_TYPE_INT, GPU_TYPE_UNSIGNED_INT, etc.
			public c_int stride_bytes;			// Number of bytes between two vertex specifications
			public c_int offset_bytes;			// Number of bytes to skip at the beginning of 'values'
			public c_bool is_per_sprite;		// Number of bytes to skip at the beginning of 'values'
			public c_bool normalize;

			private PAD_2_TO_32 pad;
		}

		[CRepr]
		public struct Attribute
		{
			public void* values; // Expect 4 values for each sprite
			public AttributeFormat format;
			public int location;

			private PAD_4_TO_64 pad;
		}

		[CRepr]
		public struct AttributeSource
		{
			public void* next_value;
			public void* per_vertex_storage; // Could point to the attribute's values or to allocated storage

			public c_int num_values;
			// Automatic storage format
			public c_int per_vertex_storage_stride_bytes;
			public c_int per_vertex_storage_offset_bytes;
			public c_int per_vertex_storage_size;  // Over 0 means that the per-vertex storage has been automatically allocated
			public Attribute attribute;
			public c_bool enabled;

			private PAD_7_TO_64 pad;
		}

		public enum Error : uint32
		{
			NONE = 0,
			BACKEND_ERROR = 1,
			DATA_ERROR = 2,
			USER_ERROR = 3,
			UNSUPORTED_FUNCTION = 4,
			NULL_ARGUMENT = 5,
			FILE_NOT_FOUND = 6
		}

		[CRepr]
		public struct ErrorObject
		{
			public char8* _function;
			public char8* details;
			public Error error;

			private PAD_4_TO_64 pad;
		}

		[AllowDuplicates]
		public enum DebugLevel : uint32
		{
			LEVEL_0 = 0,
			LEVEL_1 = 1,
			LEVEL_2 = 2,
			LEVEL_3 = 3,
			LEVEL_MAX = 3
		}

		public enum LogLevel : uint32
		{
			INFO = 0,
			WARNING,
			ERRROR
		}

		[CRepr]
		public struct RendererImpl
		{

		}

		/*! Renderer object which specializes the API to a particular backend. */
		[CRepr]
		public struct Renderer
		{
			/*! Struct identifier of the renderer. */
			public RendererID id;
			public RendererID requested_id;
			public WindowFlag SDL_init_flags;
			public InitFlag GPU_init_flags;

			public ShaderLanguage shader_language;
			public c_int min_shader_version;
			public c_int max_shader_version;
			public Feature enabled_features;

			/*! Current display target */
			public Target* current_context_target;

			/*! Default is (0.5, 0.5) - images draw centered. */
			public float defautl_image_anchor_x;
			public float default_image_anchor_y;

			public RendererImpl* impl;

			/*! 0 for inverted, 1 for mathematical */
			public c_bool coordinate_mode;

			private PAD_7_TO_64 pad;
		}
		
		[LinkName("GPU_GetLinkedVersion")]
		///Returns the linked version of sdl_gpu
		public static extern SDL.Version GetLinkedVersion();

		[LinkName("GPU_SetInitWindow")]
		///The window corresponding to 'windowID' will be used to create the rendering context instead of creating a new window.
		public static extern void SetInitWindow(uint32 windowID);

		[LinkName("GPU_GetInitWindow")]
		///Returns the window ID that has been set via GPU_SetInitWindow().
		public static extern uint32 GetInitWindow();

		[LinkName("GPU_SetPreInitFlags")]
		///Set special flags to use for initialization. Set these before calling Init()
		///@param flags An OR'ed combination of GPU_InitFlagEnum flags.  Default flags (0) enable late swap vsync and double buffering.
		public static extern void SetPreInitFlags(InitFlag flags);
	}
}