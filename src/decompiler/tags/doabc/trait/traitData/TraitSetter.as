package decompiler.tags.doabc.trait.traitData
{
	import decompiler.tags.doabc.reference.Reference;
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
	public class TraitSetter extends AbstractTraitData
	{
		private var _dispID:uint;

		public function get dispID():uint
		{
			return _dispID;
		}

		public function set dispID(value:uint):void
		{
			modify();
			_dispID = value;
		}

		private var _method:uint;

		public function get method():uint
		{
			return _method;
		}

		public function set method(value:uint):void
		{
			modify();
			try{
				$abcFile.getMethodInfoByIndex(_method).removeReference(this, "method");
			}catch(err:Error)
			{
				trace(err);
			}
			_method = value;
			$abcFile.getMethodInfoByIndex(_method).addReference(this, "method");
		}

		public function TraitSetter()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_dispID = SWFUtil.readU30(byte);
			_method = SWFUtil.readU30(byte);
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
			return 3;
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<TraitSetter disp_id=\"" + _dispID + "\" method=\"" + _method + "\"/>");
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMethodInfoByIndex(_method).addReference(this, "method");
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../../reference/IReferenceable_Fragment_1.as";
		}
	}
}