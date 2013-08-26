package decompiler.tags.doabc.trait.traitData
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * trait_method
		{
			u30 disp_id
			u30 method
		}
	 * @author ukyohpq
	 * 
	 */
	public class TraitMethod extends AbstractTraitData
	{
		private var _dispID:uint;

		/**
		 * The disp_id field is a compiler assigned integer that is 
		 * used by the AVM2 to optimize the resolution of virtual function calls.
		 * An overridden method must have the same disp_id as that of the method in the base class. 
		 * A value of zero disables this optimization.
		 */
		public function get dispID():uint
		{
			return _dispID;
		}

		/**
		 * @private
		 */
		public function set dispID(value:uint):void
		{
			modify();
			_dispID = value;
		}

		private var _method:uint;

		/**
		 * The method field is an index that points into the method array of the abcFile entry
		 */
		public function get method():uint
		{
			return _method;
		}

		/**
		 * @private
		 */
		public function set method(value:uint):void
		{
			modify();
			$abcFile.getMethodInfoByIndex(_method).removeReference(this, "method");
			_method = value;
			$abcFile.getMethodInfoByIndex(_method).addReference(this, "method");
		}

		public function TraitMethod()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_dispID = SWFUtil.readU30(byte);
//			trace("TraitMethod disp_id:" + _dispID);
			_method = SWFUtil.readU30(byte);
//			trace("TraitMethod method:" + $abcFile.getMethodByIndex(_method));
			super.decodeFromBytes(byte);
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _dispID);
			SWFUtil.writeU30(byte, _method);
			return byte;
		}
		
		override public function getKind():int
		{
			return 1;
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<TraitMethod disp_id=\"" + _dispID + "\" method=\"" + _method + "\"/>");
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMethodInfoByIndex(_method).addReference(this, "method");
		}
		
		
	}
}