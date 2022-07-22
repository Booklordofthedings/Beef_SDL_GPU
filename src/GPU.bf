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

		//Actually its preset but I am horrible at writing and this deservers to stay in
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
		
#region Init		
		///Returns the linked version of sdl_gpu
		[LinkName("GPU_GetLinkedVersion")]
		public static extern SDL.Version GetLinkedVersion();



		///The window corresponding to 'windowID' will be used to create the rendering context instead of creating a new window.
		[LinkName("GPU_SetInitWindow")]
		public static extern void SetInitWindow(uint32 windowID);

		
		///Returns the window ID that has been set via GPU_SetInitWindow().
		[LinkName("GPU_GetInitWindow")]
		public static extern uint32 GetInitWindow();

		
		///Set special flags to use for initialization. Set these before calling Init()
		///@param flags An OR'ed combination of GPU_InitFlagEnum flags.  Default flags (0) enable late swap vsync and double buffering.
		[LinkName("GPU_SetPreInitFlags")]
		public static extern void SetPreInitFlags(InitFlag flags);

		///Returns the current special flags to use for initialization
		[LinkName("GPU_GetPreInitFlags")]
		public static extern InitFlag GetPreInitFlags();

		///Set required features to use for initialization. Set these before calling GPU_Init()
		///@param features An OR'ed combination of GPU_FeatureEnum flags.  Required features will force GPU_Init() to create a renderer that supports all of the given flags or else fail.
		[LinkName("GPU_SetRequiredFeatures")]
		public static extern void SetRequiredFeatures(Feature features);

		///Returns the current required features to use for initialization
		[LinkName("GPU_GetRequiredFeatures")]
		public static extern Feature GetRequiredFeatures();

		///Gets the default initialization renderer IDs for the current platform copied into the 'order' array and the number of renderer IDs into 'order_size'.  Pass NULL for 'order' to just get the size of the renderer order array.  Will return at most GPU_RENDERER_ORDER_MAX renderers.
		[LinkName("GPU_GetDefaultRendererOrder")]
		public static extern void GetDefaultRendererOrder(c_int* order_size, RendererID* order);

		///*! Gets the current renderer ID order for initialization copied into the 'order' array and the number of renderer IDs into 'order_size'.  Pass NULL for 'order' to just get the size of the renderer order array
		[LinkName("GetRendererOrder")]
		public static extern void GetRendererOrder(c_int* order_size, RendererID* order);

		///Sets the renderer ID order to use for initialization.  If 'order' is NULL, it will restore the default order
		[LinkName("GPU_SetRendererOrder")]
		public static extern void SetRenderOrder(c_int order_size, RendererID* order);

		/*! Initializes SDL's video subsystem (if necessary) and all of SDL_gpu's internal structures.
		* Chooses a renderer and creates a window with the given dimensions and window creation flags.
		* A pointer to the resulting window's render target is returned.
		* 
		* \param w Desired window width in pixels
		* \param h Desired window height in pixels
		* \param SDL_flags The bit flags to pass to SDL when creating the window.  Use GPU_DEFAULT_INIT_FLAGS if you don't care.
		* \return On success, returns the new context target (i.e. render target backed by a window).  On failure, returns NULL.
		* 
		* Initializes these systems:
		*  The 'error queue': Stores error codes and description strings.
		*  The 'renderer registry': An array of information about the supported renderers on the current platform,
		*    such as the renderer name and id and its life cycle functions.
		*  The SDL library and its video subsystem: Calls SDL_Init() if SDL has not already been initialized.
		*    Use SDL_InitSubsystem() to initialize more parts of SDL.
		*  The current renderer:  Walks through each renderer in the renderer registry and tries to initialize them until one succeeds.
		*
		* \see GPU_RendererID
		* \see GPU_InitRenderer()
		* \see GPU_InitRendererByID()
		* \see GPU_SetRendererOrder()
		* \see GPU_PushErrorCode()
		*/
		[LinkName("GPU_Init")]
		public static extern Target* Init(uint16 w, uint16 h, WindowFlag SDL_flags);


		///Initializes SDL and SDL_gpu.  Creates a window and the requested renderer context
		[LinkName("GPU_InitRenderer")]
		public static extern Target* InitRenderer(RendererE renderer_enum, uint16 w, uint16 h, WindowFlag SDL_flags);

		/*! Initializes SDL and SDL_gpu.  Creates a window and the requested renderer context.
		* By requesting a renderer via ID, you can specify the major and minor versions of an individual renderer backend.
		* \see GPU_MakeRendererID
		*/
		///Initializes SDL and SDL_gpu.  Creates a window and the requested renderer context
		[LinkName("GPU_InitRendererByID")]
		public static extern Target* InitRendererByID(RendererID renderer_request, uint16 w, uint16 h, WindowFlag SDL_flags);

		///Checks for important GPU features which may not be supported depending on a device's extension support.  Feature flags (GPU_FEATURE_*) can be bitwise OR'd together.
		[LinkName("GPU_IsFeatureEnabled")]
		public static extern c_bool IsFeatureEnabled(Feature feature);

		///Clean up the renderer state.
		[LinkName("GPU_CloseCurrentRenderer")]
		public static extern void CloseCurrentRenderer();

		[LinkName("GPU_Quit")]
		public static extern void Quit();
#endregion

#region DebuggingLoggingErrorHandling

		[LinkName("GPU_SetDebugLevel")]
		public static extern void SetDebugLevel(DebugLevel level);

		///Returns the current global debug level
		[LinkName("GPU_GetDebugLevel")]
		public static extern DebugLevel GetDebugLevel();

		///Prints an informational log message
		[LinkName("GPU_LogInfo")]
		public static extern void LogInfo(char8* format, ...);

		///Prints a warning log message
		[LinkName("GPU_LogWarning")]
		public static extern void LogWarning(char8* format, ...);

		///Prints an error log message
		[LinkName("GPU_LogError")]
		public static extern void LogError(char8* format, ...);

		///Sets a custom callback for handling logging.  Use stdio's vsnprintf() to process the va_list into a string.  Passing NULL as the callback will reset to the default internal logging
		///@param var_args You want a void* for that, and then use System.VarArgs with .ToVAList() ~Beefy
		[LinkName("GPU_SetLogCallback")]
		public static extern void SetLogCallback(function int(int32 log_level, char8* format, void* var_args) callback);


     	///Pushes a new error code into the error queue.  If the queue is full, the queue is not modified.
		///@param _function The name of the function that pushed the error
		///@param  error The error code to push on the error queue
		///@param details Additional information string, can be NULL.
		[LinkName("GPU_PushErrorCode")]
		public static extern void PushErrorCode(char8* _function,Error error,char8* details, ...);

		///Pops an error object from the error queue and returns it.  If the error queue is empty, it returns an error object with NULL function, GPU_ERROR_NONE error, and NULL details.
		[LinkName("GPU_PopErrorCode")]
		public static extern Error GetErrorCode();

		///Gets the string representation of an error code
		[LinkName("GPU_GetErrorString")]
		public static extern char8* GetErrorString(Error error);

		///Changes the maximum number of error objects that SDL_gpu will store.  This deletes all currently stored errors
		[LinkName("GPU_SetErrorQueueMax")]
		public static extern void SetErrorQueueMax(c_uint max);
#endregion

#region RendererSetup
		///Returns an initialized GPU_RendererID
		[LinkName("GPU_MakeRendererId")]
		public static extern RendererID MakeRendererId(char8* name, RendererE renderer, c_int major_version, c_int minor_version);

		///Gets the first registered renderer identifier for the given enum value
		[LinkName("GPU_GetRendererID")]
		public static extern RendererID GetRendererID(RendererE renderer);

		///Gets the number of registered (available) renderers
		[LinkName("GPU_GetNumRegisteredRenderers")]
		public static extern c_int GetNumRegisteredRenderers();

		///Gets an array of identifiers for the registered (available) renderers
		[LinkName("GPU_GetRegisteredRendererList")]
		public static extern void GetRegisteredRendererList(RendererID* renderers_array);

		///Prepares a renderer for use by SDL_gpu
		[LinkName("GPU_RegisterRenderer")]
		public static extern void RegisterRenderer(RendererID id, function Renderer*(RendererID request) create_renderer, function void(Renderer*) free_renderer);
#endregion

#region RendererControls
		///Gets the next enum ID that can be used for a custom renderer
		[LinkName("GPU_ReserveNextRendererEnum")]
		public static extern RendererE ReserveNextRendererEnum();

		///Gets the number of active (created) renderers
		[LinkName("GPU_GetNumActiveRenderers")]
		public static extern c_int GetNumActiveRenderers();

		///Gets the number of active (created) renderers
		[LinkName("GPU_GetActiveRendererList")]
		public static extern void GetActiveRendererList(RendererID* renderers_array);

		///return The current renderer
		[LinkName("GPU_GetCurrentRenderer")]
		public static extern Renderer* GetCurrentRenderer();

		///Switches the current renderer to the renderer matching the given identifier
		[LinkName("GPU_SetCurrentRenderer")]
		public static extern void SetCurrentRenderer(RendererID id);

		///return The renderer matching the given identifier.
		[LinkName("GPU_GetRenderer")]
		public static extern Renderer* GetRenderer(RendererID id);

		[LinkName("GPU_FreeRenderer")]
		public static extern void FreeRenderer(Renderer* renderer);

		///Reapplies the renderer state to the backend API (e.g. OpenGL, Direct3D).  Use this if you want SDL_gpu to be able to render after you've used direct backend calls
		[LinkName("GPU_ResetRendererState")]
		public static extern void ResetRendererState();


		///Sets the coordinate mode for this renderer.  Target and image coordinates will be either "inverted" (0,0 is the upper left corner, y increases downward) or "mathematical" (0,0 is the bottom-left corner, y increases upward).
		//@param use_math_coords 0 is for inverted coordinates, 1 is for mathematical coordinates
		[LinkName("GPU_SetCoordinateMode")]
		public static extern void SetCoordinateMode(c_bool use_math_coords);

		[LinkName("GPU_GetCoordinateMode")]
		public static extern c_bool GetCoordinateMode();

		///Sets the default image blitting anchor for newly created images
		[LinkName("GPU_SetDefaultAnchor")]
		public static extern void SetDefaultAnchor(float anchor_x, float anchor_y);
	
		///Returns the default image blitting anchor through the given variables
		[LinkName("GPU_GetDefaultAnchor")]
		public static extern void GetDefaultAnchor(float* anchor_x, float* anchor_y);
	
#endregion

#region ContextControls
		///return The renderer's current context target
		[LinkName("GPU_GetContextTarget")]
		public static extern Target* GetContextTarget();

		///return The target that is associated with the given windowID
		[LinkName("GPU_GetWindowTarget")]
		public static extern Target* GetWindowTarget(uint32 windowID);

		///Creates a separate context for the given window using the current renderer and returns a GPU_Target that represents it
		[LinkName("GPU_CreateTargetFromWindow")]
		public static extern Target* CreateTargetFromWindow(uint32 windowID);

		/*! Makes the given window the current rendering destination for the given context target.
		* This also makes the target the current context for image loading and window operations.
		* If the target does not represent a window, this does nothing.
		*/
		[LinkName("GPU_MakeCurrent")]
		public static extern void MakeCurrent(Target* target, uint32 windowID);
		
		

		///Change the actual size of the current context target's window.  This resets the virtual resolution and viewport of the context target. Aside from direct resolution changes, this should also be called in response to SDL_WINDOWEVENT_RESIZED window events for resizable windows
		[LinkName("GPU_SetWindowResolution")]
		public static extern c_bool SetWindowResolution(uint16 w, uint16 h);

		/// Enable/disable fullscreen mode for the current context target's window. On some platforms, this may destroy the renderer context and require that textures be reloaded.  Unfortunately, SDL does not provide a notification mechanism for this. return 0 if the new mode is windowed, 1 if the new mode is fullscreen
		///@param enable_fullscreen If true, make the application go fullscreen.  If false, make the application go to windowed mode.
		///@param use_desktop_resolution If true, lets the window change its resolution when it enters fullscreen mode (via SDL_WINDOW_FULLSCREEN_DESKTOP).
		[LinkName("GPU_SetFullscreen")]
		public static extern c_bool SetFullscreen(c_bool enable_fullscreen, c_bool use_desktop_resolution);

		///Returns true if the current context target's window is in fullscreen mode
		[LinkName("GPU_GetFullscreen")]
		public static extern c_bool GetFullscreen();

		///return Returns the last active target
		[LinkName("GPU_GetActiveTarget")]
		public static extern Target* GetActiveTarget();


		///return Sets the currently active target for matrix modification functions
		[LinkName("GPU_SetActiveTarget")]
		public static extern c_bool SetActiveTarget(Target* target);

		///Enables/disables alpha blending for shape rendering on the current window
		[LinkName("GPU_SetShapeBlending")]
		public static extern void SetShapeBlending(c_bool enable);

		///Translates a blend preset into a blend mode
		[LinkName("GPU_GetBlendModeFromPreset")]
		public static extern BlendMode GetBlendModeFromPreset(BlendPresent present);

		///Sets the blending component functions for shape rendering
		[LinkName("GPU_SetShapeBlendFunction")]
		public static extern void SetShapeBlendFunction(BlendFunc source_color, BlendFunc dest_color, BlendFunc source_alpha, BlendFunc dest_alpha);

		///Sets the blending component equations for shape rendering
		[LinkName("GPU_SetShapeBlendEquation")]
		public static extern void SetShapeBlendEquation(BlendEq color_equation, BlendEq alpha_equation);

		///Sets the blending mode for shape rendering on the current window, if supported by the renderer
		[LinkName("GPU_SetShapeBlendMode")]
		public static extern void SetShapeBlendMode(BlendPresent mode);

		/// Sets the thickness of lines for the current context. 
		///@param thickness New line thickness in pixels measured across the line.  Default is 1.0f.
		[LinkName("GPU_SetLineThickness")]
		public static extern float SetLineThickness(float thickness);
		
		///Returns the current line thickness value
		[LinkName("GPU_GetLineThickness")]
		public static extern float GetLineThickness();
#endregion

#region TargetControls
		///Creates a target that aliases the given target.  Aliases can be used to store target settings (e.g. viewports) for easy switching. GPU_FreeTarget() frees the alias's memory, but does not affect the original
		[LinkName("GPU_CreateAliasTarget")]
		public static extern Target* CreateAliasTarget(Target* target);

		///Creates a new render target from the given image.  It can then be accessed from image->target.  This increments the internal refcount of the target, so it should be matched with a GPU_FreeTarget()
		[LinkName("GPU_LoadTarget")]
		public static extern Target* LoadTarget(Image* image);

		///Creates a new render target from the given image.  It can then be accessed from image->target.  This does not increment the internal refcount of the target, so it will be invalidated when the image is freed
		[LinkName("GPU_GetTarget")]
		public static extern Target* GetTarget(Image* image);

		///Deletes a render target in the proper way for this renderer
		[LinkName("GPU_FreeTarget")]
		public static extern void FreeTarget(Target* target);

		///Change the logical size of the given target.  Rendering to this target will be scaled as if the dimensions were actually the ones given
		[LinkName("GPU_SetVirtualResolution")]
		public static extern void SetVirtualResolution(Target* target, uint16 w, uint16 h);

		///Query the logical size of the given target
		[LinkName("GPU_GetVirtualResolution")]
		public static extern void GetVirtualResolution(Target* target, uint16* w, uint16* h);

		///Converts screen space coordinates (such as from mouse input) to logical drawing coordinates.  This interacts with GPU_SetCoordinateMode() when the y-axis is flipped (screen space is assumed to be inverted: (0,0) in the upper-left corner)
		[LinkName("GPU_GetVirtualCoords")]
		public static extern void GetVirtualCoords(Target* target, float* x, float* y, float displayX, float displayY);

		///Reset the logical size of the given target to its original value
		[LinkName("GPU_UnsetVirtualResolution")]
		public static extern void UnsetVirtualResolution(Target* target);

		///return A GPU_Rect with the given values
		[LinkName("GPU_MakeRect")]
		public static extern Rect MakeRect(float x, float y, float w, float h);

		///return An SDL_Color with the given values
		[LinkName("GPU_MakeColor")]
		public static extern SDL.Color MakeColor(uint8 r, uint8 g, uint8 b, uint8 a);

		///Sets the given target's viewport
		[LinkName("GPU_SetViewport")]
		public static extern void SetViewport(Target* target, Rect viewport);

		///Resets the given target's viewport to the entire target area
		[LinkName("GPU_UnsetViewport")]
		public static extern void UnsetViewport(Target* target);

		///return A GPU_Camera with position (0, 0, 0), angle of 0, zoom of 1, centered origin, and near/far clipping planes of -100 and 100
		[LinkName("GPU_GetDefaultCamera")]
		public static extern Camera GetDefaultCamera();

		///return The camera of the given render target.  If target is NULL, returns the default camera
		[LinkName("GPU_GetCamera")]
		public static extern Camera GetCamera(Target* target);

		///Sets the current render target's current camera.
		///param target A pointer to the target that will copy this camera.
		///param cam A pointer to the camera data to use or NULL to use the default camera.
		[LinkName("GPU_SetCamera")]
		public static extern Camera SetCamera(Target* target, Camera* cam);

		///Enables or disables using the built-in camera matrix transforms
		[LinkName("GPU_EnableCamera")]
		public static extern void EnableCamera(Target* target, c_bool use_camera);

		///Returns 1 if the camera transforms are enabled, 0 otherwise
		[LinkName("GPU_IsCameraEnabled")]
		public static extern c_bool IsCameraEnabled(Target* target);

		/// Attach a new depth buffer to the given target so that it can use depth testing.  Context targets automatically have a depth buffer already. If successful, also enables depth testing for this target.
		[LinkName("GPU_AddDepthBuffer")]
		public static extern c_bool AddDepthBuffer();

		///Enables or disables the depth test, which will skip drawing pixels/fragments behind other fragments.  Disabled by default. This has implications for alpha blending, where compositing might not work correctly depending on render order.
		[LinkName("GPU_SetDepthTest")]
		public static extern void SetDepthTest(Target* target, c_bool enable);

		///Enables or disables writing the depth (effective view z-coordinate) of new pixels to the depth buffer.  Enabled by default, but you must call GPU_SetDepthTest() to use it
		[LinkName("GPU_SetDepthWrite")]
		public static extern void SetDepthWrite(Target* target, c_bool enable);

		///Sets the operation to perform when depth testing
		[LinkName("GPU_SetDepthFunction")]
		public static extern void SetDepthFunction(Target* target, Comparison compare_operation);

		///return The RGBA color of a pixel
		[LinkName("GPU_GetPixel")]
		public static extern SDL.Color GetPixel(Target* target, int16 x, int16 y);

		///Sets the clipping rect for the given render target
		[LinkName("GPU_SetClipRect")]
		public static extern Rect GPU_SetClipRect(Target* target, Rect rect);

		///Sets the clipping rect for the given render target
		[LinkName("GPU_SetClip")]
		public static extern Rect SetClip(Target* target, int16 x, int16 y, uint16 w, uint16 h);

		///Turns off clipping for the given target
		[LinkName("GPU_UnsetClip")]
		public static extern void UnsetClip(Target* target);

		///Returns GPU_TRUE if the given rects A and B overlap, in which case it also fills the given result rect with the intersection.  `result` can be NULL if you don't need the intersection
		[LinkName("GPU_GetLineThickness")]
		public static extern c_bool GPU_IntersectRect(Rect A, Rect B, Rect* result);

		///Returns GPU_TRUE if the given target's clip rect and the given B rect overlap, in which case it also fills the given result rect with the intersection.  `result` can be NULL if you don't need the intersection. If the target doesn't have a clip rect enabled, this uses the whole target area.
		[LinkName("GPU_IntersectClipRect")]
		public static extern c_bool IntersectClipRect(Target* target, Rect B, Rect* result);

		///Sets the modulation color for subsequent drawing of images and shapes on the given target. This has a cumulative effect with the image coloring functions. e.g. GPU_SetRGB(image, 255, 128, 0); GPU_SetTargetRGB(target, 128, 128, 128); Would make the image draw with color of roughly (128, 64, 0).
		[LinkName("GPU_SetTargetColor")]
		public static extern void SetTargetColor(Target* target, SDL.Color color);

		///Sets the modulation color for subsequent drawing of images and shapes on the given target. This has a cumulative effect with the image coloring functions.e.g. GPU_SetRGB(image, 255, 128, 0); GPU_SetTargetRGB(target, 128, 128, 128);Would make the image draw with color of roughly (128, 64, 0).
		[LinkName("GPU_GetLineThickness")]
		public static extern void GPU_SetTargetRGB(Target* target, uint8 r, uint8 g, uint8 b);

		///R Sets the modulation color for subsequent drawing of images and shapes on the given target. 
		[LinkName("GPU_SetTargetRGBA")]
		public static extern void SetTargetRGBA(Target* target, uint8 r, uint8 g, uint8 b, uint8 a);

		///Unsets the modulation color for subsequent drawing of images and shapes on the given target
		[LinkName("GPU_UnsetTargetColor")]
		public static extern void UnsetTargetColor(Target* target);
#endregion

		 ///Load surface from an image file that is supported by this renderer.  Don't forget to SDL_FreeSurface() it.
		 [LinkName("GPU_LoadSurface")] public static extern SDL.Surface*  LoadSurface(char8* filename);
		 ///Load surface from an image file in memory.  Don't forget to SDL_FreeSurface() it.
		 [LinkName("GPU_LoadSurface_RW")] public static extern SDL.Surface*  LoadSurface_RW(SDL.RWOps* rwops, c_bool free_rwops);
		 ///Save surface to a file
		 [LinkName("GPU_SaveSurface")] public static extern c_bool  SaveSurface(SDL.Surface* surface, char8* filename, FileFormat format);
		 ///Save surface to a RWops stream
		 [LinkName("GPU_SaveSurface_RW")] public static extern c_bool  SaveSurface_RW(SDL.Surface* surface, SDL.RWOps* rwops, c_bool free_rwops, FileFormat format);
		 ///Create a new, blank image with the given format
		 [LinkName("GPU_CreateImage")] public static extern Image*  CreateImage(uint16 w, uint16 h, Format format);
		 ///Create a new image that uses the given native texture handle as the image texture
		 [LinkName("GPU_CreateImageUsingTexture")] public static extern Image*  CreateImageUsingTexture(TextureHandle handle, c_bool take_ownership);
		 ///Load image from an image file that is supported by this renderer
		 [LinkName("GPU_LoadImage")] public static extern Image*  LoadImage(char8* filename);
		 ///Load image from an image file in memory
		 [LinkName("GPU_LoadImage_RW")] public static extern Image*  LoadImage_RW(SDL.RWOps* rwops, c_bool free_rwops);
		 ///Creates an image that aliases the given image.  Aliases can be used to store image settings
		 [LinkName("GPU_CreateAliasImage")] public static extern Image*  CreateAliasImage(Image* image);
		 ///Copy an image to a new image
		 [LinkName("GPU_CopyImage")] public static extern Image*  CopyImage(Image* image);
		 ///Deletes an image in the proper way for this renderer.  Also deletes the corresponding GPU_Target if applicable
		 [LinkName("GPU_FreeImage")] public static extern void  FreeImage(Image* image);
		 ///Change the logical size of the given image.  Rendering this image will scaled it as if the dimensions were actually the ones given
		 [LinkName("GPU_SetImageVirtualResolution")] public static extern void  SetImageVirtualResolution(Image* image, uint16 w, uint16 h);
		 ///Reset the logical size of the given image to its original value
		 [LinkName("GPU_UnsetImageVirtualResolution")] public static extern void  UnsetImageVirtualResolution(Image* image);

		 [LinkName("GPU_UpdateImage")] public static extern void  UpdateImage(Image* image, Rect* image_rect, SDL.Surface* surface, Rect* surface_rect);

		 [LinkName("GPU_UpdateImageBytes")] public static extern void  UpdateImageBytes(Image* image, Rect* image_rect, char8* bytes, c_int bytes_per_row); //TODO:

		 [LinkName("GPU_ReplaceImage")] public static extern c_bool  ReplaceImage(Image* image, SDL.Surface* surface, Rect* surface_rect);

		 [LinkName("GPU_SaveImage")] public static extern c_bool  SaveImage(Image* image, char8* filename, FileFormat format);

		 [LinkName("GPU_SaveImage_RW")] public static extern c_bool  SaveImage_RW(Image* image, SDL.RWOps* rwops, c_bool free_rwops, FileFormat format);

		 [LinkName("GPU_GenerateMipmaps")] public static extern void  GenerateMipmaps(Image* image);

		 [LinkName("GPU_SetColor")] public static extern void  SetColor(Image* image, SDL.Color color);

		 [LinkName("GPU_SetRGB")] public static extern void  SetRGB(Image* image, uint8 r, uint8 g, uint8 b);

		 [LinkName("GPU_SetRGBA")] public static extern void  SetRGBA(Image* image, uint8 r, uint8 g, uint8 b, uint8 a);

		 [LinkName("GPU_UnsetColor")] public static extern void  UnsetColor(Image* image);

		 [LinkName("GPU_GetBlending")] public static extern c_bool  GetBlending(Image* image);

		 [LinkName("GPU_SetBlending")] public static extern void  SetBlending(Image* image, c_bool enable);

		 [LinkName("GPU_SetBlendFunction")] public static extern void  SetBlendFunction(Image* image, BlendFunc source_color, BlendFunc dest_color, BlendFunc source_alpha, BlendFunc dest_alpha);

		 [LinkName("GPU_SetBlendEquation")] public static extern void  SetBlendEquation(Image* image, BlendEq color_equation, BlendEq alpha_equation);

		 [LinkName("GPU_SetBlendMode")] public static extern void  SetBlendMode(Image* image, BlendPresent mode);

		 [LinkName("GPU_SetImageFilter")] public static extern void  SetImageFilter(Image* image, Filter filter);

		 [LinkName("GPU_SetAnchor")] public static extern void  SetAnchor(Image* image, float anchor_x, float anchor_y);

		 [LinkName("GPU_GetAnchor")] public static extern void  GetAnchor(Image* image, float* anchor_x, float* anchor_y);

		 [LinkName("GPU_GetSnapMode")] public static extern Snap  GetSnapMode(Image* image);

		 [LinkName("GPU_SetSnapMode")] public static extern void  SetSnapMode(Image* image, Snap mode);

		 [LinkName("GPU_SetWrapMode")] public static extern void  SetWrapMode(Image* image, Wrap wrap_mode_x, Wrap wrap_mode_y);

		 [LinkName("GPU_GetTextureHandle")] public static extern TextureHandle  GetTextureHandle(Image* image);

		 [LinkName("GPU_CopyImageFromSurface")] public static extern Image*  CopyImageFromSurface(SDL.Surface* surface);

		 [LinkName("GPU_CopyImageFromSurfaceRect")] public static extern Image*  CopyImageFromSurfaceRect(SDL.Surface* surface, Rect* surface_rect);

		 [LinkName("GPU_CopyImageFromTarget")] public static extern Image*  CopyImageFromTarget(Target* target);

		 [LinkName("GPU_CopySurfaceFromTarget")] public static extern SDL.Surface*  CopySurfaceFromTarget(Target* target);

		 [LinkName("GPU_CopySurfaceFromImage")] public static extern SDL.Surface*  CopySurfaceFromImage(Image* image);

		 [LinkName("GPU_VectorLength")] public static extern float  VectorLength(float* vec3);

		 [LinkName("GPU_VectorNormalize")] public static extern void  VectorNormalize(float* vec3);

		 [LinkName("GPU_VectorDot")] public static extern float  VectorDot(float* A, float* B);

		 [LinkName("GPU_VectorCross")] public static extern void  VectorCross(float* result, float* A, float* B);

		 [LinkName("GPU_VectorCopy")] public static extern void  VectorCopy(float* result, float* A);

		 [LinkName("GPU_VectorApplyMatrix")] public static extern void  VectorApplyMatrix(float* vec3, float* matrix_4x4);

		 [LinkName("GPU_Vector4ApplyMatrix")] public static extern void  Vector4ApplyMatrix(float* vec4, float* matrix_4x4);

		 [LinkName("GPU_MatrixCopy")] public static extern void  MatrixCopy(float* result, float* A);

		 [LinkName("GPU_MatrixIdentity")] public static extern void  MatrixIdentity(float* result);

		 [LinkName("GPU_MatrixOrtho")] public static extern void  MatrixOrtho(float* result, float left, float right, float bottom, float top, float z_near, float z_far);

		 [LinkName("GPU_MatrixFrustum")] public static extern void  MatrixFrustum(float* result, float left, float right, float bottom, float top, float z_near, float z_far);

		 [LinkName("GPU_MatrixPerspective")] public static extern void  MatrixPerspective(float* result, float fovy, float aspect, float z_near, float z_far);

		 [LinkName("GPU_MatrixLookAt")] public static extern void  MatrixLookAt(float* matrix, float eye_x, float eye_y, float eye_z, float target_x, float target_y, float target_z, float up_x, float up_y, float up_z);

		 [LinkName("GPU_MatrixTranslate")] public static extern void  MatrixTranslate(float* result, float x, float y, float z);

		 [LinkName("GPU_MatrixScale")] public static extern void  MatrixScale(float* result, float sx, float sy, float sz);

		 [LinkName("GPU_MatrixRotate")] public static extern void  MatrixRotate(float* result, float degrees, float x, float y, float z);

		 [LinkName("GPU_MatrixMultiply")] public static extern void  MatrixMultiply(float* result, float* A, float* B);

		 [LinkName("GPU_MultiplyAndAssign")] public static extern void  MultiplyAndAssign(float* result, float* B);

		 [LinkName("GPU_GetMatrixString")] public static extern char8*  GetMatrixString(float* A);

		 [LinkName("GPU_GetCurrentMatrix")] public static extern float*  GetCurrentMatrix();

		 [LinkName("GPU_GetTopMatrix")] public static extern float*  GetTopMatrix(MatrixStack* _stack);

		 [LinkName("GPU_GetModel")] public static extern float*  GetModel();

		 [LinkName("GPU_GetView")] public static extern float*  GetView();

		 [LinkName("GPU_GetProjection")] public static extern float*  GetProjection();

		 [LinkName("GPU_GetModelViewProjection")] public static extern void  GetModelViewProjection(float* result);

		 [LinkName("GPU_CreateMatrixStack")] public static extern MatrixStack*  CreateMatrixStack();

		 [LinkName("GPU_FreeMatrixStack")] public static extern void  FreeMatrixStack(MatrixStack* _stack);

		 [LinkName("GPU_InitMatrixStack")] public static extern void  InitMatrixStack(MatrixStack* _stack);

		 [LinkName("GPU_CopyMatrixStack")] public static extern void  CopyMatrixStack(MatrixStack* source, MatrixStack* dest);

		 [LinkName("GPU_ClearMatrixStack")] public static extern void  ClearMatrixStack(MatrixStack* _stack);

		 [LinkName("GPU_ResetProjection")] public static extern void  ResetProjection(Target* target);

		 [LinkName("GPU_MatrixMode")] public static extern void  MatrixMode(Target* target, int matrix_mode);

		 [LinkName("GPU_SetProjection")] public static extern void  SetProjection(float* A);

		 [LinkName("GPU_SetView")] public static extern void  SetView(float* A);

		 [LinkName("GPU_SetModel")] public static extern void  SetModel(float* A);

		 [LinkName("GPU_SetProjectionFromStack")] public static extern void  SetProjectionFromStack(MatrixStack* _stack);

		 [LinkName("GPU_SetViewFromStack")] public static extern void  SetViewFromStack(MatrixStack* _stack);

		 [LinkName("GPU_SetModelFromStack")] public static extern void  SetModelFromStack(MatrixStack* _stack);

		 [LinkName("GPU_PushMatrix")] public static extern void  PushMatrix();

		 [LinkName("GPU_PopMatrix")] public static extern void  PopMatrix();

		 [LinkName("GPU_LoadIdentity")] public static extern void  LoadIdentity();

		 [LinkName("GPU_LoadMatrix")] public static extern void  LoadMatrix(float* matrix4x4);

		 [LinkName("GPU_Ortho")] public static extern void  Ortho(float left, float right, float bottom, float top, float z_near, float z_far);

		 [LinkName("GPU_Frustum")] public static extern void  Frustum(float left, float right, float bottom, float top, float z_near, float z_far);

		 [LinkName("GPU_Perspective")] public static extern void  Perspective(float fovy, float aspect, float z_near, float z_far);

		 [LinkName("GPU_LookAt")] public static extern void  LookAt(float eye_x, float eye_y, float eye_z, float target_x, float target_y, float target_z, float up_x, float up_y, float up_z);

		 [LinkName("GPU_Translate")] public static extern void  Translate(float x, float y, float z);

		 [LinkName("GPU_Scale")] public static extern void  Scale(float sx, float sy, float sz);

		 [LinkName("GPU_Rotate")] public static extern void  Rotate(float degrees, float x, float y, float z);

		 [LinkName("GPU_MultMatrix")] public static extern void  MultMatrix(float* matrix4x4);

		 [LinkName("GPU_Clear")] public static extern void  Clear(Target* target);

		 [LinkName("GPU_ClearColor")] public static extern void  ClearColor(Target* target, SDL.Color color);

		 [LinkName("GPU_ClearRGB")] public static extern void  ClearRGB(Target* target, uint8 r, uint8 g, uint8 b);

		 [LinkName("GPU_ClearRGBA")] public static extern void  ClearRGBA(Target* target, uint8 r, uint8 g, uint8 b, uint8 a);

		 [LinkName("GPU_Blit")] public static extern void  Blit(Image* image, Rect* src_rect, Target* target, float x, float y);

		 [LinkName("GPU_BlitRotate")] public static extern void  BlitRotate(Image* image, Rect* src_rect, Target* target, float x, float y, float degrees);

		 [LinkName("GPU_BlitScale")] public static extern void  BlitScale(Image* image, Rect* src_rect, Target* target, float x, float y, float scaleX, float scaleY);

		 [LinkName("GPU_BlitTransform")] public static extern void  BlitTransform(Image* image, Rect* src_rect, Target* target, float x, float y, float degrees, float scaleX, float scaleY);

		 [LinkName("GPU_BlitTransformX")] public static extern void  BlitTransformX(Image* image, Rect* src_rect, Target* target, float x, float y, float pivot_x, float pivot_y, float degrees, float scaleX, float scaleY);

		 [LinkName("GPU_BlitRect")] public static extern void  BlitRect(Image* image, Rect* src_rect, Target* target, Rect* dest_rect);

		 [LinkName("GPU_BlitRectX")] public static extern void  BlitRectX(Image* image, Rect* src_rect, Target* target, Rect* dest_rect, float degrees, float pivot_x, float pivot_y, Flip flip_direction);

		 [LinkName("GPU_TriangleBatch")] public static extern void  TriangleBatch(Image* image, Target* target, uint16 num_vertices, float* values, c_uint num_indices, uint16* indices, BatchFlag flags);

		 [LinkName("GPU_TriangleBatchX")] public static extern void  TriangleBatchX(Image* image, Target* target, uint16 num_vertices, void* values, uint16 num_indices, uint16* indices, BatchFlag flags);

		 [LinkName("GPU_PrimitiveBatch")] public static extern void  PrimitiveBatch(Image* image, Target* target, Primitive primitive_type, uint16 num_vertices, float* values, uint16 num_indices, uint16* indices, BatchFlag flags);

		 [LinkName("GPU_PrimitiveBatchV")] public static extern void  PrimitiveBatchV(Image* image, Target* target, Primitive primitive_type, uint16 num_vertices, void* values, c_uint num_indices, uint16* indices, BatchFlag flags);

		 [LinkName("GPU_FlushBlitBuffer")] public static extern void  FlushBlitBuffer();

		 [LinkName("GPU_Flip")] public static extern void  Flip(Target* target);

		 [LinkName("GPU_Pixel")] public static extern void  Pixel(Target* target, float x, float y, SDL.Color color);

		 [LinkName("GPU_Line")] public static extern void  Line(Target* target, float x1, float y1, float x2, float y2, SDL.Color color);

		 [LinkName("GPU_Arc")] public static extern void  Arc(Target* target, float x, float y, float radius, float start_angle, float end_angle, SDL.Color color);

		 [LinkName("GPU_ArcFilled")] public static extern void  ArcFilled(Target* target, float x, float y, float radius, float start_angle, float end_angle, SDL.Color color);

		 [LinkName("GPU_Circle")] public static extern void  Circle(Target* target, float x, float y, float radius, SDL.Color color);

		 [LinkName("GPU_CircleFilled")] public static extern void  CircleFilled(Target* target, float x, float y, float radius, SDL.Color color);

		 [LinkName("GPU_Ellipse")] public static extern void  Ellipse(Target* target, float x, float y, float rx, float ry, float degrees, SDL.Color color);

		 [LinkName("GPU_EllipseFilled")] public static extern void  EllipseFilled(Target* target, float x, float y, float rx, float ry, float degrees, SDL.Color color);

		 [LinkName("GPU_Sector")] public static extern void  Sector(Target* target, float x, float y, float inner_radius, float outer_radius, float start_angle, float end_angle, SDL.Color color);

		 [LinkName("GPU_SectorFilled")] public static extern void  SectorFilled(Target* target, float x, float y, float inner_radius, float outer_radius, float start_angle, float end_angle, SDL.Color color);

		 [LinkName("GPU_Tri")] public static extern void  Tri(Target* target, float x1, float y1, float x2, float y2, float x3, float y3, SDL.Color color);

		 [LinkName("GPU_TriFilled")] public static extern void  TriFilled(Target* target, float x1, float y1, float x2, float y2, float x3, float y3, SDL.Color color);

		 [LinkName("GPU_Rectangle")] public static extern void  Rectangle(Target* target, float x1, float y1, float x2, float y2, SDL.Color color);

		 [LinkName("GPU_Rectangle2")] public static extern void  Rectangle2(Target* target, Rect rect, SDL.Color color);

		 [LinkName("GPU_RectangleFilled")] public static extern void  RectangleFilled(Target* target, float x1, float y1, float x2, float y2, SDL.Color color);

		 [LinkName("GPU_RectangleFilled2")] public static extern void  RectangleFilled2(Target* target, Rect rect, SDL.Color color);

		 [LinkName("GPU_RectangleRound")] public static extern void  RectangleRound(Target* target, float x1, float y1, float x2, float y2, float radius, SDL.Color color);

		 [LinkName("GPU_RectangleRound2")] public static extern void  RectangleRound2(Target* target, Rect rect, float radius, SDL.Color color);

		 [LinkName("GPU_RectangleRoundFilled")] public static extern void  RectangleRoundFilled(Target* target, float x1, float y1, float x2, float y2, float radius, SDL.Color color);

		 [LinkName("GPU_RectangleRoundFilled2")] public static extern void  RectangleRoundFilled2(Target* target, Rect rect, float radius, SDL.Color color);

		 [LinkName("GPU_Polygon")] public static extern void  Polygon(Target* target, c_uint num_vertices, float* vertices, SDL.Color color);

		 [LinkName("GPU_Polyline")] public static extern void  Polyline(Target* target, c_uint num_vertices, float* vertices, SDL.Color color, c_bool close_loop);

		 [LinkName("GPU_PolygonFilled")] public static extern void  PolygonFilled(Target* target, c_uint num_vertices, float* vertices, SDL.Color color);

		 [LinkName("GPU_CreateShaderProgram")] public static extern uint32  CreateShaderProgram();

		 [LinkName("GPU_FreeShaderProgram")] public static extern void  FreeShaderProgram(uint32 program_object);

		 [LinkName("GPU_CompileShader_RW")] public static extern uint32  CompileShader_RW(Shader shader_type, SDL.RWOps* shader_source, c_bool free_rwops);

		 [LinkName("GPU_CompileShader")] public static extern uint32 CompileShader(Shader shader_type, char8* shader_source);

		 [LinkName("GPU_LoadShader")] public static extern uint32  LoadShader(Shader shader_type, char8* filename);

		 [LinkName("GPU_LinkShaders")] public static extern uint32  LinkShaders(uint32 shader_object1, uint32 shader_object2);

		 [LinkName("GPU_LinkManyShaders")] public static extern uint32  LinkManyShaders(uint32 *shader_objects, c_int count);

		 [LinkName("GPU_FreeShader")] public static extern void  FreeShader(uint32 shader_object);

		 [LinkName("GPU_AttachShader")] public static extern void  AttachShader(uint32 program_object, uint32 shader_object);

		 [LinkName("GPU_DetachShader")] public static extern void  DetachShader(uint32 program_object, uint32 shader_object);

		 [LinkName("GPU_LinkShaderProgram")] public static extern c_bool  LinkShaderProgram(uint32 program_object);

		 [LinkName("GPU_GetCurrentShaderProgram")] public static extern uint32  GetCurrentShaderProgram();

		 [LinkName("GPU_IsDefaultShaderProgram")] public static extern c_bool  IsDefaultShaderProgram(uint32 program_object);

		 [LinkName("GPU_ActivateShaderProgram")] public static extern void  ActivateShaderProgram(uint32 program_object, ShaderBlock* block);

		 [LinkName("GPU_DeactivateShaderProgram")] public static extern void  DeactivateShaderProgram();

		 [LinkName("GPU_GetShaderMessage")] public static extern char8*  GetShaderMessage();

		 [LinkName("GPU_GetAttributeLocation")] public static extern c_int  GetAttributeLocation(uint32 program_object, char8* attrib_name);

		 [LinkName("GPU_MakeAttributeFormat")] public static extern AttributeFormat  MakeAttributeFormat(int num_elems_per_vertex, Type type, c_bool normalize, c_int stride_bytes, c_int offset_bytes);

		 [LinkName("GPU_MakeAttribute")] public static extern Attribute  MakeAttribute(int location, void* values, AttributeFormat format);

		 [LinkName("GPU_GetUniformLocation")] public static extern c_int  GetUniformLocation(uint32 program_object, char8* uniform_name);

		 [LinkName("GPU_LoadShaderBlock")] public static extern ShaderBlock  LoadShaderBlock(uint32 program_object, char8* position_name, char8* texcoord_name, char8* color_name, char8* modelViewMatrix_name);

		 [LinkName("GPU_SetShaderBlock")] public static extern void  SetShaderBlock(ShaderBlock block);

		 [LinkName("GPU_GetShaderBlock")] public static extern ShaderBlock  GetShaderBlock();

		 [LinkName("GPU_SetShaderImage")] public static extern void  SetShaderImage(Image* image, c_int location, c_int image_unit);

		 [LinkName("GPU_GetUniformiv")] public static extern void  GetUniformiv(uint32 program_object, c_int location, c_int* values);

		 [LinkName("GPU_SetUniformi")] public static extern void  SetUniformi(c_int location, c_int value);

		 [LinkName("GPU_SetUniformiv")] public static extern void  SetUniformiv(c_int location, c_int num_elements_per_value, c_int num_values, c_int* values);

		 [LinkName("GPU_GetUniformuiv")] public static extern void  GetUniformuiv(uint32 program_object, c_int location, c_uint* values);

		 [LinkName("GPU_SetUniformui")] public static extern void  SetUniformui(c_int location, c_uint value);

		 [LinkName("GPU_SetUniformuiv")] public static extern void  SetUniformuiv(c_int location, c_int num_elements_per_value, c_int num_values, c_uint* values);

		 [LinkName("GPU_GetUniformfv")] public static extern void  GetUniformfv(uint32 program_object, c_int location, float* values);

		 [LinkName("GPU_SetUniformf")] public static extern void  SetUniformf(c_int location, float value);

		 [LinkName("GPU_SetUniformfv")] public static extern void  SetUniformfv(c_int location, c_int num_elements_per_value, c_int num_values, float* values);

		 [LinkName("GPU_GetUniformMatrixfv")] public static extern void  GetUniformMatrixfv(uint32 program_object, c_int location, float* values);

		 [LinkName("GPU_SetUniformMatrixfv")] public static extern void  SetUniformMatrixfv(c_int location, c_int num_matrices, c_int num_rows, c_int num_columns, c_bool transpose, float* values);

		 [LinkName("GPU_SetAttributef")] public static extern void  SetAttributef(c_int location, float value);

		 [LinkName("GPU_SetAttributei")] public static extern void  SetAttributei(c_int location, c_int value);

		 [LinkName("GPU_SetAttributeui")] public static extern void  SetAttributeui(c_int location, c_uint value);

		 [LinkName("GPU_SetAttributefv")] public static extern void  SetAttributefv(c_int location, c_int num_elements, float* value);

		 [LinkName("GPU_SetAttributeiv")] public static extern void  SetAttributeiv(c_int location, c_int num_elements, c_int* value);

		 [LinkName("GPU_SetAttributeuiv")] public static extern void  SetAttributeuiv(c_int location, c_int num_elements, c_uint* value);

		 [LinkName("GPU_SetAttributeSource")] public static extern void  SetAttributeSource(c_int num_values, Attribute source);

	}

}