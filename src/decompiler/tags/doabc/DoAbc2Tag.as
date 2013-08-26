package decompiler.tags.doabc
{
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.tags.SWFTag;
	import decompiler.tags.TagType;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * http://stackoverflow.com/questions/553445/how-do-generics-vector-work-inside-the-avm
	 * 
	 * 文档中无记载的MultinameKind:0x1D
	 * 文档中无记载的opcode:0x53
	 * 估计是因为fp10以后增加了Vector类，有泛型的特征，而MultinameKind 0x1D的名称就是CONSTANT_GenericName
	 * 
	 * The other interesting thing is how instances of the class are created. 
	 * A new opcode was added in Flash 10 (0x53), which I will call MakeGenericType. 
	 * MakeGenericType is declared with the following stack:
	 * TypeDefinition, ParameterType1, ParameterTypeN -> GenericType
	 * @author ukyohpq
	 * 
	 */
	public final class DoAbc2Tag extends SWFTag implements ICanInDefineSpriteTag
	{
		private var _flag:int;

		public function get flag():int
		{
			return _flag;
		}

		private var _name:String;

		public function get name():String
		{
			return _name;
		}

		private var _abcFile:ABCFile;

		public function get abcFile():ABCFile
		{
			return _abcFile;
		}

		public function DoAbc2Tag(id:int, body:ByteArray)
		{
			super(TagType.DO_ABC_2, body);
			_abcFile = new ABCFile;
		}
		
		override protected function realDecode():void
		{
			_flag = $data.readInt();
//			trace("flag:", flag, $data.position);
			
			_name = SWFUtil.readString($data);
			_abcFile.decodeFromBytes($data);
		}
		
		override protected function encodeData():void
		{
			$data.writeInt(_flag);
			SWFUtil.writeString($data, _name);
			$data.writeBytes(_abcFile.encode());
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<flag>" + _flag + "</flag>");
			xml.appendChild("<name>" + _name + "</name>");
			xml.appendChild(_abcFile.toXML());
		}
		
		override public function get isModified():Boolean
		{
			return _abcFile.isModified;
		}
		
	}
}