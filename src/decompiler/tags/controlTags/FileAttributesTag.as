package decompiler.tags.controlTags
{
	import flash.utils.ByteArray;
	
	public class FileAttributesTag extends AbstractControlTag
	{
		private var UseNetwork:uint;
		private var ActionScript3:uint;
		private var HasMetadata:uint;
		private var UseGPU:uint;
		private var UseDirectBlit:uint;
		private var suppressCrossDomainCaching:uint;
		private var swfRelativeUrls:uint;
		public function FileAttributesTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			var n:uint = $data.readUnsignedInt();
			//Reserved 24bits
			UseDirectBlit = (n & 64) >> 6;//100 0000 If 1, this SWF file is given network file access when loaded locally.
			//Reserved 1bits
			UseGPU = (n & 32) >> 5;//10 0000
			HasMetadata = (n & 16) >> 4;//1 0000
			ActionScript3 = (n & 8) >> 3;//1000
			suppressCrossDomainCaching  = (n & 4) >> 2;//100
			swfRelativeUrls   = (n & 2) >> 1;//10
			UseNetwork = n & 1;
			//Reserved 1bit
			trace("UseDirectBlit:" + UseDirectBlit + 
				" UseGPU:" + UseGPU + 
				" HasMetadata:" + HasMetadata + 
				" ActionScript3:" + ActionScript3 + 
				" suppressCrossDomainCaching:" + suppressCrossDomainCaching +
				" swfRelativeUrls:" + swfRelativeUrls + 
				" UseNetwork:" + UseNetwork
			);
		}
		
//		override public function encode():ByteArray
//		{
//			$data.clear();
//			$data = new ByteArray;
//			$data.endian = Endian.LITTLE_ENDIAN;
//			var n:int = (UseNetwork << 7) | (ActionScript3 << 4) | (HasMetadata << 3) | (UseGPU << 2) | (UseDirectBlit << 1);
//			$data.writeInt(n);
//			
//			return super.encode();
//		}
		
		override public function toString():String
		{
			// TODO Auto Generated method stub
			return super.toString();
		}
		
		
		
	}
}