package decompiler.tags.doabc.methodBody
{
	import decompiler.core.ISWFElement;
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.instruction.AbstractInstruction;
	import decompiler.tags.doabc.instruction.InstructionFactory;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class MethodBodyPCode extends ABCFileElement
	{
		private var _pcodes:Vector.<AbstractInstruction>;

		public function get pcodes():Vector.<AbstractInstruction>
		{
			return _pcodes;
		}

		public var methodBody:MethodBody;
		public function MethodBodyPCode()
		{
			_pcodes = new <AbstractInstruction>[];
		}
		
		public function getPCodeAt(index:int):AbstractInstruction
		{
			return _pcodes[index];
		}
		
		/**
		 * 在指定的索引设置pCode
		 * @param index	索引位置
		 * @param form	pCod的form值
		 * @param params	可选，pCode的参数，如果超出这个pCode实际所需参数个数，后面的将被忽略
		 * 
		 */
		public function setPCodeAt(index:int, form:int, params:Array = null):void
		{
			if(params && params.length)
			{
				var byte:ByteArray = new ByteArray;
				var length:int = params.length;
				for (var i:int = 0; i < length; ++i) 
				{
					byte[i] = params[i];
				}
			}
			
			var pCode:AbstractInstruction = InstructionFactory.creatInstruction(form, $abcFile);
			pCode.methodBody = methodBody;
			
			byte && pCode.decodeFromBytes(byte);
			
			if(index < 0 || index >= _pcodes.length)
			{
				return;
			}else{
				_pcodes[index] = pCode;
				modify();
			}
		}
		
		/**
		 * 向方法体中插入pCode
		 * @param index	插入的位置
		 * @param pcodeBytes 要编码的pcode
		 * @return 
		 * 
		 */
		public function insertPCode(index:int, pcodeBytes:Array):void
		{
			var byte:ByteArray = new ByteArray;
			var length:int = pcodeBytes.length;
			for (var i:int = 0; i < length; ++i) 
			{
				byte[i] = pcodeBytes[i];
			}
			
			while(byte.bytesAvailable)
			{
				var pCode:AbstractInstruction = InstructionFactory.creatInstruction(byte.readUnsignedByte(), $abcFile);
				pCode.methodBody = methodBody;
				pCode.decodeFromBytes(byte);
				_pcodes.splice(index++, 0, pCode);
			}
		}
		
		/**
		 * 从指定位置删除指定长度的pcode
		 * @param startIndex
		 * @param length
		 * 
		 */
		public function deletePCodeByLength(startIndex:int, length:int):void
		{
			_pcodes.splice(startIndex, length);
		}
		
		/**
		 * 删除从startIndex(包含)到endIndex(不包含)的pcode
		 * @param startIndex
		 * @param endIndex
		 * 
		 */
		public function deletePCodeByIndex(startIndex:int, endIndex:int):void
		{
			if(startIndex >= _pcodes.length || endIndex >= _pcodes.length)
				throw new Error("数组下标越界");
			_pcodes.splice(startIndex, endIndex - startIndex);
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			var i:int = 0;
			while(byte.bytesAvailable)
			{
				var pCode:AbstractInstruction = InstructionFactory.creatInstruction(byte.readUnsignedByte(), $abcFile);
				pCode.methodBody = methodBody;
				pCode.decodeFromBytes(byte);
				_pcodes.push(pCode);
			}
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			var length:int = _pcodes.length;
			//这里要写入的长度是字节长度，不是数组长度
			//此时还不知道字节有多长
			var codeBody:ByteArray = new ByteArray;
			for (var i:int = 0; i < length; ++i) 
			{
				var tempBytes:ByteArray = _pcodes[i].encode();
				codeBody.writeBytes(tempBytes);
				tempBytes.clear();
			}
			SWFUtil.writeU30(byte, codeBody.length);
			byte.writeBytes(codeBody);
			codeBody.clear();
			return byte;
		}
		
		public function toString():String
		{
			var str:String = "";
			var length:int = _pcodes.length;
			for (var i:int = 0; i < length; ++i) 
			{
				str += "\n" + _pcodes[i].toString();
			}
			
			return "[ MethodBodyPCode" + str + " ]";
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "opcodes";
			var length:int = _pcodes.length;
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("length", length);
			var position:int = 0
			for (var i:int = 0; i < length; ++i) 
			{
				var pCode:AbstractInstruction = _pcodes[i];
				var tempXML:SWFXML = pCode.toXML("opcode_" + i);
				tempXML.setAttribute("position", position);
				var params:Vector.<uint> = pCode.getParams();
				position += (params?params.length:0) + 1;//参数长度加上form长度1
				xml.appendChild(tempXML);
			}
			
			return xml;
		}
		
	}
}