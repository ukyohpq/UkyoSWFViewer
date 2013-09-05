package decompiler.tags.doabc.methodBody
{
	import decompiler.core.ISWFElement;
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.instruction.AbstractInstruction;
	import decompiler.tags.doabc.instruction.InstructionFactory;
	import decompiler.tags.doabc.instruction.Lookupswitch;
	import decompiler.tags.doabc.instruction.jump.IJump;
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
		 * 向方法体中插入pCode。该方法只能将新代码插入到pcode与pcode之间，而不能将代码插入到某个pcode中间。
		 * 其实向某pcode中间插入代码会导致很多不可预料的错误，因此也没必要做到这一点，通常会修改pcode而不是插入代码到pcode中。
		 * @param index	插入的位置，一个pcodes的索引
		 * @param pcodeBytes 要插入的pcodes
		 * @param pcodeByteLength 要插入的pcodes的字节长度
		 * @return 
		 * 
		 */
		public function insertPCode(index:int, pcodeBytes:Array, pcodeByteLength:int):void
		{
			var length:int = _pcodes.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var pcode:IJump = _pcodes[i] as IJump;
				//仅处理含有跳转的语句
				//需要修改跳转偏移量的充要条件是:
				//1.跳转方向和插入位置匹配
				//2.当前跳转pcode和插入处pcode之间的所有原始pcode的字节长度总和要不大于原始偏移量
				//例如，索引3是一跳转pcode，其offset是10bytes，而要在索引7的位置插入新pcode,
				//而从索引3到索引7之间的索引4,5,6的pcode，它们的字节总长为15，那么，从索引3跳10byte,
				//是到不了索引7处的，即是说，在索引7出插入的新的pcode，并不影响该跳转，故不需要修改该跳转的offset
				
				//index <= i表示原始pcode在新插入的pcode之前，
				//这些pcode里如果有向上跳转(offset < 0)，则跳转方向和插入位置匹配
				//而index > i表示原始pcode在新插入的pcode之后，
				//这些pcode里如果有向下跳转(offset > 0), 则跳转方向和插入位置匹配
				if(pcode)
				{
					//从索引index处到索引i处之间的原始pcode的字节长度总和
					//用来判断在跳转方向和插入位置匹配的情况下，是否需要修改偏移量
					var bytesLengthBetweenIndexAndI:int = 0;
					if(index <= i)
					{
						//前插比后插要多一个元素，例如，5,6,7,8,9,10，10是跳转，
						//在5处插入，实际上，原始的5在新的pcode和10之间，计算字节长时要包含进来
						//而如果5,6,7,8,9,10，5是跳转，在10出插入，而原始的10，就在5和新的pcode之外，
						//计算字节长时不包含进来，所以这两个for循环，前跳是开区间，后跳是闭区间
						for (var j:int = index; j < i; ++j) //闭区间
						{
							bytesLengthBetweenIndexAndI += _pcodes[j].getBytesLength();
						}
					}else{
						for (j = i + 1; j < index; ++j) //开区间
						{
							bytesLengthBetweenIndexAndI += _pcodes[j].getBytesLength();
						}
					}
					pcode.modifyOffset(pcodeByteLength, index > i, bytesLengthBetweenIndexAndI);
				}
			}
			
			_pcodes.splice.apply(null, [index, 0].concat(pcodeBytes));
		}
		
		/**
		 * 获取指定的索引处的pcode之前的pcode的字节长度总和
		 * @param index	该索引前的所有pcode都将参与计算
		 * @return 
		 * 
		 */
		public function getCodeByteLengthBefore(index:int):int
		{
			var len:int = 0;
			for (var i:int = 0; i < index; ++i) 
			{
				len += _pcodes[i].getBytesLength();
			}
			return len;
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
				var pCode:AbstractInstruction = _pcodes[i];
				var arr:Vector.<int> = pCode.getParams();
				var tempBytes:ByteArray = pCode.encode();
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
				var params:Vector.<int> = pCode.getParams();
				position += (params?params.length:0) + 1;//参数长度加上form长度1
				xml.appendChild(tempXML);
			}
			
			return xml;
		}
		
	}
}