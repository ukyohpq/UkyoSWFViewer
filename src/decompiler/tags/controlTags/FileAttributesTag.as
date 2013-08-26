package decompiler.tags.controlTags
{
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class FileAttributesTag extends AbstractControlTag
	{
		private var _UseNetwork:uint;

		public function get UseNetwork():uint
		{
			return _UseNetwork;
		}

		public function set UseNetwork(value:uint):void
		{
			$isModified = true;
			_UseNetwork = value;
		}

		private var _ActionScript3:uint;

		public function get ActionScript3():uint
		{
			return _ActionScript3;
		}

		public function set ActionScript3(value:uint):void
		{
			$isModified = true;
			_ActionScript3 = value;
		}

		private var _HasMetadata:uint;

		public function get HasMetadata():uint
		{
			return _HasMetadata;
		}

		public function set HasMetadata(value:uint):void
		{
			$isModified = true;
			_HasMetadata = value;
		}

		private var _UseGPU:uint;

		public function get UseGPU():uint
		{
			return _UseGPU;
		}

		public function set UseGPU(value:uint):void
		{
			$isModified = true;
			_UseGPU = value;
		}

		private var _UseDirectBlit:uint;

		public function get UseDirectBlit():uint
		{
			return _UseDirectBlit;
		}

		public function set UseDirectBlit(value:uint):void
		{
			$isModified = true;
			_UseDirectBlit = value;
		}

		private var _suppressCrossDomainCaching:uint;

		public function get suppressCrossDomainCaching():uint
		{
			return _suppressCrossDomainCaching;
		}

		public function set suppressCrossDomainCaching(value:uint):void
		{
			$isModified = true;
			_suppressCrossDomainCaching = value;
		}

		private var _swfRelativeUrls:uint;

		public function get swfRelativeUrls():uint
		{
			return _swfRelativeUrls;
		}

		public function set swfRelativeUrls(value:uint):void
		{
			$isModified = true;
			_swfRelativeUrls = value;
		}

		public function FileAttributesTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			var n:uint = $data.readUnsignedInt();
			//Reserved 24bits
			_UseDirectBlit = (n & 64) >> 6;//100 0000 If 1, this SWF file is given network file access when loaded locally.
			//Reserved 1bits
			_UseGPU = (n & 32) >> 5;//10 0000
			_HasMetadata = (n & 16) >> 4;//1 0000
			_ActionScript3 = (n & 8) >> 3;//1000
			_suppressCrossDomainCaching  = (n & 4) >> 2;//100
			_swfRelativeUrls   = (n & 2) >> 1;//10
			_UseNetwork = n & 1;
			//Reserved 1bit
//			trace("UseDirectBlit:" + UseDirectBlit + 
//				" UseGPU:" + UseGPU + 
//				" HasMetadata:" + HasMetadata + 
//				" ActionScript3:" + ActionScript3 + 
//				" suppressCrossDomainCaching:" + suppressCrossDomainCaching +
//				" swfRelativeUrls:" + swfRelativeUrls + 
//				" UseNetwork:" + UseNetwork
//			);
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<UseDirectBlit>" + _UseDirectBlit + "</UseDirectBlit>");
			xml.appendChild("<UseGPU>" + _UseGPU + "</UseGPU>");
			xml.appendChild("<HasMetadata>" + _HasMetadata + "</HasMetadata>");
			xml.appendChild("<ActionScript3>" + _ActionScript3 + "</ActionScript3>");
			xml.appendChild("<suppressCrossDomainCaching>" + _suppressCrossDomainCaching + "</suppressCrossDomainCaching>");
			xml.appendChild("<swfRelativeUrls>" + _swfRelativeUrls + "</swfRelativeUrls>");
			xml.appendChild("<UseNetwork>" + _UseNetwork + "</UseNetwork>");
		}
		
		override protected function encodeData():void
		{
			var n:int = (_UseNetwork << 7) | (_ActionScript3 << 4) | (_HasMetadata << 3) | (_UseGPU << 2) | (_UseDirectBlit << 1);
			$data.writeInt(n);
		}
		
		
	}
}