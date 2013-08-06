package decompiler.tags.defineTags
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class DefineBinaryDataTag extends AbstractDefineTag
	{
		private var _characterID:int;
		private var _binaData:ByteArray;
		public function DefineBinaryDataTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function encodeData():void
		{
			super.encodeData();
			$data.writeShort(_characterID);
			$data.writeInt(0);
			$data.writeBytes(_binaData);
		}
		
		override protected function realDecode():void
		{
			_characterID = $data.readShort();
			$data.readInt();//Reserved, must be 0
			_binaData = new ByteArray;
			$data.readBytes(_binaData);
			trace("[ DefineBinaryData characterID:" + _characterID + " ]");
		}
		
		override public function toString():String
		{
			return "[ DefineBinaryData characterID:" + _characterID + " ]";
		}
	}
}