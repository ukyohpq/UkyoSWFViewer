package decompiler.tags.doabc
{
	public final class ABCMethod
	{
		/*method_info
		{
			u30 param_count
			u30 return_type
			u30 param_type[param_count]
			u30 name
			u8 flags
			option_info options
			param_info param_names
		}*/
		public var param_count:uint;
		public var return_type:uint;
		public var param_type:Vector.<uint> = new <uint>[];
		public var name:uint;
		public var flags:uint;
		public var option_info:Vector.<uint> = new <uint>[];
		public var param_info:Vector.<uint> = new <uint>[];
		
		public function ABCMethod()
		{
		}
	}
}