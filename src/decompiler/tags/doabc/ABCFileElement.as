package decompiler.tags.doabc
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class ABCFileElement implements IByteArrayReader, ISWFElement
	{
		protected var $abcFile:ABCFile;

		public function get abcFile():ABCFile
		{
			return $abcFile;
		}

		public function ABCFileElement()
		{
		}
		
		public function toXML(name:String = null):SWFXML
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
		}
		
		public function encode():ByteArray
		{
			return null;
		}
		
		public function setAbcFile(abcFile:ABCFile):void
		{
			$abcFile = abcFile;
		}
		
		protected function modify():void
		{
			$abcFile.isModified = true;
		}
	}
}