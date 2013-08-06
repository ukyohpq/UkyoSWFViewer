package decompiler.tags.doabc.script
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.core.trait.TraitsInfo;
	
	import decompiler.utils.SWFUtil;
	
	/**
	 * The script_info entry is used to define characteristics of an ActionScript 3.0 script
	 * script_info
		{
			u30 init
			u30 trait_count
			traits_info trait[trait_count]
		}
	 * @author ukyohpq
	 * 
	 */
	public class ScriptInfo implements IByteArrayReader, ISWFElement
	{
		/**
		 * The init field is an index into the method array of the abcFile. 
		 * It identifies a function that is to be invoked prior to any other code in this script.
		 */
		private var _init:int;
		/**
		 * The value of trait_count is the number of entries in the trait array. 
		 * The trait array is the set of traits defined by the script.
		 */
		private var _traitsArray:Vector.<TraitsInfo>;
		public function ScriptInfo()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			//read init
			_init = SWFUtil.readU30(byte);
			
			//read trait_count
			var length:int = SWFUtil.readU30(byte);
			_traitsArray = new Vector.<TraitsInfo>(length);
			for (var i:int = 0; i < length; ++i) 
			{
				var traitInfo:TraitsInfo = new TraitsInfo;
				traitInfo.decodeFromBytes(byte);
				_traitsArray[i] = traitInfo;
			}
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			
			//write init;
			SWFUtil.writeU30(byte, _init);
			
			//write trait_count
			var length:int = _traitsArray.length;
			SWFUtil.writeU30(byte, length);
			
			for (var i:int = 0; i < length; ++i) 
			{
				var tempByte:ByteArray = _traitsArray[i].encode();
				byte.writeBytes(tempByte);
				tempByte.clear();
			}
			
			return byte;
		}
	}
}