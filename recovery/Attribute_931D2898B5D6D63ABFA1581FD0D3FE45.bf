using System;
namespace SDL2
{
	extension GPU
	{
		[CRepr]
		struct Attribute
		{
			public int location;
			public void* values;
			public AttributeFormat format
		}
	}
}