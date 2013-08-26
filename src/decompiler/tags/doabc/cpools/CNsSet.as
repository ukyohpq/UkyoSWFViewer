package decompiler.tags.doabc.cpools
{
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.IReferenceable;
	import decompiler.tags.doabc.Reference;
	import decompiler.tags.doabc.ReferencedElement;
	import decompiler.tags.doabc.events.ABCFileEvent;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ns_set_info
			{
				u30 count
				u30 ns[count]
			}
	 * @author ukyohpq
	 * 
	 */
	public class CNsSet extends ReferencedElement implements IReferenceable
	{
		private var _nsArr:Vector.<uint>;

		public function get nsArr():Vector.<uint>
		{
			return _nsArr;
		}

		public function setValueAt(value:uint, index:uint = -1):void
		{
			if(index < 0 || index >= _nsArr.length)
			{
				_nsArr.push(value);
				$abcFile.getNamespaceByIndex(value).addReference(this, "nsArr", _nsArr.length - 1);
			}else{
				$abcFile.getNamespaceByIndex(_nsArr[index]).removeReference(this, "nsArr", index);
				_nsArr[index] = value;
				$abcFile.getNamespaceByIndex(value).addReference(this, "nsArr", index);
			}
			modify();
		}
		
		public function CNsSet()
		{
			_nsArr = new <uint>[];
		}

		private function onParseComplete(event:ABCFileEvent):void
		{
			creatRefrenceRelationship();
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			
			var length:int = _nsArr.length;
			SWFUtil.writeU30(byte, length);
			for (var i:int = 0; i < length; ++i) 
			{
				SWFUtil.writeU30(byte, _nsArr[i]);
			}
			
			return byte;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			var length:int = SWFUtil.readU30(byte);
			_nsArr.length = length;
			for (var i:int = 0; i < length; ++i) 
			{
				_nsArr[i] = SWFUtil.readU30(byte);
			}
			
			include "../IReferenced_Fragment_1.as";
		}
		
		public function toString():String
		{
			var str:String = "";
			var length:int = _nsArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				str += "\nindex:" + i + " " + _nsArr[i];
//				str += "\nindex:" + i + " " + $abcFile.getNamespaceByIndex(_nsArr[i]);
			}
			
			return "[ NsSet length:" + length + str + "]";
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "nsset";
			var xml:SWFXML = new SWFXML(name);
			var length:int = _nsArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				xml.appendChild("<namespace>" + _nsArr[i] + "</namespace>");
			}
			
			return xml;
		}
		
		public function creatRefrenceRelationship():void
		{
			var length:int = _nsArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				$abcFile.getNamespaceByIndex(_nsArr[i]).addReference(this, "nsArr", i);
			}
		}
		
	}
}