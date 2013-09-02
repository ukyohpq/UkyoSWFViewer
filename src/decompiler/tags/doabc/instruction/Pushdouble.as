package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		pushdouble
		index
	 * index is a u30 that must be an index into the double constant pool. The double value at
		index in the double constant pool is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushdouble extends AbstractInstruction
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
				$abcFile.getDoubleByIndex(_index).removeReference(this, "index");
			}catch(err:Error)
			{
				trace(err);
			}
			_index = value;
			$abcFile.getDoubleByIndex(_index).addReference(this, "index");
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getDoubleByIndex(_index).addReference(this, "index");
		}

		public function Pushdouble()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 47;
		}
		
		override public function getName():String
		{
			return "pushdouble";
		}
		
//		override public function toString():String
//		{
//			return "[ pushdouble double:" + $abcFile.getDoubleByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "double:" + $abcFile.getDoubleByIndex(_index);
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