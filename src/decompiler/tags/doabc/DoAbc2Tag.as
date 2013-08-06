package decompiler.tags.doabc
{
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.tags.SWFTag;
	import decompiler.tags.TagType;
	import decompiler.utils.SWFUtil;
	
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
		public var flag:int;
		public var name:String;
		private var _abcData:ABCFile;
		private var _head:ByteArray;
		private var _CpoolBytes:ByteArray;
		public function DoAbc2Tag(id:int, body:ByteArray)
		{
			super(TagType.DO_ABC_2, body);
		}
		
		override protected function realDecode():void
		{
			//read flag
			flag = $data.readInt();
			trace(preFix + "flag:", flag, $data.position);
			
			//read name
			//读一个字符串，遇到0就结束
			//貌似直接用readUTF会报文件尾错误
			name = SWFUtil.readString($data);
//			trace(preFix + "name:" + name);
			//读出name后，再读一个byte，这个byte一定是0，因为我们就是读到这个0才确定的name长度
			//文档中没有提，我自己给它起个字段叫afterName
//			$data.readByte();
			var abcByte:ByteArray = new ByteArray;
			abcByte.endian = Endian.LITTLE_ENDIAN;
			$data.readBytes(abcByte);
			_abcData = ABCFile.getInstance();
			_abcData.decodeFromBytes(abcByte);
			
		}
	}
}