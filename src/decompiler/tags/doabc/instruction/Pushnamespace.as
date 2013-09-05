package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		pushnamespace
		index
	 * index is a u30 that must be an index into the namespace constant pool. The namespace value
		at index in the namespace constant pool is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushnamespace extends AbstractInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			modify();
			try{
				$abcFile.getNamespaceByIndex(_index).removeReference(this, "index");
			}catch(err:Error)
			{
				trace(err);
			}
			_index = value;
			$abcFile.getNamespaceByIndex(_index).addReference(this, "index");
		}

		public function Pushnamespace()
		{
			super();
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getNamespaceByIndex(_index).addReference(this, "index");
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 49;
		}
		
		override public function getName():String
		{
			return "pushnamespace";
		}
		
//		override public function toString():String
//		{
//			return "[ pushnamespace namespace:" + $abcFile.getNamespaceByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "namespace:" + $abcFile.getNamespaceByIndex(_index);
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_index];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_index"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../reference/IReferenceable_Fragment_1.as";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}