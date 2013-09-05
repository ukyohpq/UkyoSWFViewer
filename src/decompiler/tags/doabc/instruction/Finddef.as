package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Undocumented
	 * 看起来貌似是用了lookup cache来优化这个东西
	 * Uses lookup cache to optimize finddef in jit code (bug 515722 r=stejohns+)
  2102 			INSTR(finddef) {
  2103 				SAVE_EXPC;
  2104 				GET_MULTINAME_PTR(multiname, U30ARG);
  2105 				*(++sp) = env->finddef(multiname)->atom();
  2106 				NEXT;
  2107 			}

	 * @author ukyohpq
	 * 
	 */
	public class Finddef extends UndocumentedInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			if(_index == value)
				return;
			modify();
			try{
				$abcFile.getMultinameByIndex(_index).removeReference(this, "index");
			}catch(err:Error)
			{
				trace(err);
			}
			_index = value;
			$abcFile.getMultinameByIndex(_index).addReference(this, "index");
		}

		public function Finddef()
		{
			super();
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 95;
		}
		
		override public function getName():String
		{
			return "finddef";
		}
		
		override public function getParamNames():Vector.<String>
		{
			return Vector.<String>(["index"]);
		}
		
		override public function getParams():Vector.<int>
		{
			return Vector.<int>([_index]);
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
		}
		
		
//		override public function toString():String
//		{
//			return "[ finddef name:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
		
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getMultinameByIndex(_index);
		}
		
		override public function deltaNumStack():int
		{
			return -$abcFile.getMultinameByIndex(_index).needNumParams() + 1;
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMultinameByIndex(_index).addReference(this, "index");
		}
	}
}