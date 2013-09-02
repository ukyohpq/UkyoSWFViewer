package decompiler.tags.doabc.trait.traitData
{
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * trait_function
		{
			u30 slot_id
			u30 function
		}
	 * @author ukyohpq
	 * 
	 */
	public class TraitFunction extends AbstractTraitData
	{
		/**
		 * The slot_id field is an integer from 0 to N and is used 
		 * to identify a position in which this trait resides.
		 * A value of 0 requests the AVM2 to assign a position.
		 */
		private var _slotID:uint;
		private var _function:uint;

		/**
		 * The function field is an index that points into the method array of the abcFile entry
		 */
		public function get pFunction():uint
		{
			return _function;
		}

		/**
		 * @private
		 */
		public function set pFunction(value:uint):void
		{
			modify();
			try{
				$abcFile.getMethodInfoByIndex(_function).removeReference(this, "pFunction");
			}catch(err:Error)
			{
				trace(err);
			}
			_function = value;
			$abcFile.getMethodInfoByIndex(_function).addReference(this, "pFunction");
		}

		public function TraitFunction()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_slotID = SWFUtil.readU30(byte);
			_function = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _slotID);
			SWFUtil.writeU30(byte, _function);
			return byte;
		}
		
		override public function getKind():int
		{
			return 5;
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<TraitFunction slot_id=\"" + _slotID + "\" function=\"" + _function + "\"/>");
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMethodInfoByIndex(_function).addReference(this, "pFunction");
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../../reference/IReferenceable_Fragment_1.as";
		}
	}
}