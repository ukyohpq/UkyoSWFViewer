package decompiler.tags.doabc.method
{
	public final class MethodInfoFlagName
	{
		public static const NEED_ARGUMENTS:int 	= 0x01;
		public static const NEED_ACTIVATION:int = 0x02; 
		public static const NEED_REST:int 		= 0x04;
		public static const HAS_OPTIONAL:int 	= 0x08;
		public static const SET_DXNS:int 		= 0x40;
		public static const HAS_PARAM_NAMES:int = 0x80;
	}
}