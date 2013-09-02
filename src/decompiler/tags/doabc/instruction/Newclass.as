package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		newclass
		index
	 * 	index is a u30 that is an index of the ClassInfo that is to be created. basetype must be the
		base class of the class being created, or null if there is no base class.
		The class that is represented by the ClassInfo at position index of the ClassInfo entries is
		created with the given basetype as the base class. This will run the static initializer function
		for the class. The new class object, newclass, will be pushed onto the stack.
		When this instruction is executed, the scope stack must contain all the scopes of all base
		classes, as the scope stack is saved by the created ClassClosure.
	 * @author ukyohpq
	 * 
	 */
	public class Newclass extends AbstractInstruction
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
				$abcFile.getClassInfoByIndex(_index).removeReference(this, "index");
			}catch(err:Error)
			{
				trace(err);
			}
			_index = value;
			$abcFile.getClassInfoByIndex(_index).addReference(this, "index");
		}

		public function Newclass()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getClassInfoByIndex(_index).addReference(this, "index");
		}
		
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 88;
		}
		
		override public function getName():String
		{
			return "newclass";
		}
		
//		override public function toString():String
//		{
//			return "[ newclass class:" + $abcFile.getInstanceInfoByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "class:" + $abcFile.getInstanceInfoByIndex(_index);
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
	}
}