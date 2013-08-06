package decompiler.tags.doabc.cpools
{
	/**
	 * 	Constant 		Kind 						Value 		Entry
						CONSTANT_Int 				0x03 		integer
						CONSTANT_UInt 				0x04 		uinteger
						CONSTANT_Double 			0x06 		double
						CONSTANT_Utf8 				0x01 		string
						CONSTANT_True 				0x0B 		-
						CONSTANT_False 				0x0A 		-
						CONSTANT_Null 				0x0C 		-
						CONSTANT_Undefined 			0x00 		-
						CONSTANT_Namespace 			0x08 		namespace
						CONSTANT_PackageNamespace 	0x16 		namespace
						CONSTANT_PackageInternalNs 	0x17 		Namespace
						CONSTANT_ProtectedNamespace 0x18 		Namespace
						CONSTANT_ExplicitNamespace 	0x19 		Namespace
						CONSTANT_StaticProtectedNs 	0x1A 		Namespace
						CONSTANT_PrivateNs 			0x05 		namespace
	 * @author ukyohpq
	 * 
	 */
	public final class ConstantKind
	{
		public static const CONSTANT_Int:int 				= 0x03;
		public static const CONSTANT_UInt:int 				= 0x04;
		public static const CONSTANT_Double:int 			= 0x06;
		public static const CONSTANT_Utf8:int 				= 0x01;
		public static const CONSTANT_True:int 				= 0x0B;
		public static const CONSTANT_False:int 				= 0x0A;
		public static const CONSTANT_Null:int 				= 0x0C;
		public static const CONSTANT_Undefined:int 			= 0x00;
		public static const CONSTANT_Namespace:int 			= 0x08;
		public static const CONSTANT_PackageNamespace:int 	= 0x16;
		public static const CONSTANT_PackageInternalNs:int 	= 0x17;
		public static const CONSTANT_ProtectedNamespace:int = 0x18;
		public static const CONSTANT_ExplicitNamespace:int 	= 0x19;
		public static const CONSTANT_StaticProtectedNs:int 	= 0x1A;
		public static const CONSTANT_PrivateNs:int 			= 0x05;
	}
}