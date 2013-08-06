package decompiler.core.instruction
{
	import flash.utils.ByteArray;

	/**
	 * Format
		hasnext2
		object_reg
		index_reg
	 * 	object_reg and index_reg are uints that must be indexes to a local register. The value of the
		register at position object_reg is the object that is being enumerated and is assigned to obj.
		The value of the register at position index_reg must be of type int, and that value is assigned
		to cur_index.
		Get the index of the next property after the property located at index cur_index on object
		obj. If there are no more properties on obj, then obj is set to the next object on the prototype
		chain of obj, and cur_index is set to the first index of that object. If there are no more objects
		on the prototype chain and there are no more properties on obj, then obj is set to null, and
		cur_index is set to 0.
		The register at position object_reg is set to the value of obj, and the register at position
		index_reg is set to the value of cur_index.
		If index is not 0, then push true. Otherwise push false.
	 * @author ukyohpq
	 * 
	 */
	public class Hasnext2 extends AbstractInstruction
	{
		private var object_reg:uint;
		private var index_reg:uint;
		public function Hasnext2()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			object_reg = byte.readUnsignedInt();
			index_reg = byte.readUnsignedInt();
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			byte.writeUnsignedInt(object_reg);
			byte.writeUnsignedInt(index_reg);
		}
		
		override public function getForms():int
		{
			return 50;
		}
		
		override public function getName():String
		{
			return "hasnext2";
		}
		
//		override public function toString():String
//		{
//			// TODO Auto Generated method stub
//			return super.toString();
//		}
		
		override protected function stringBody():String
		{
			return "object_reg:" + object_reg + " index_reg:" + index_reg;
		}
	}
}