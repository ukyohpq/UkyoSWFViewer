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
		 * 向方法体中插入pCode
		 * @param index	插入的位置
		 * @param pcodeBytes 要插入的pcodes
		 * @return 
		 * 
		 */
		public function insertPCode(index:int, pcodeBytes:Array):void
		{
			_pcodes.splice.apply(null, [index, 0].concat(pcodeBytes));
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
			var localCount:int = 0;
			var curNumStack:int = 0;
			var curNumScope:int = 0;
			var maxStack:int = 0;
			var maxScope:int = 0;
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
				
				switch(pCode.getName())
				{
					case "declocal":
					case "declocal_i":
					case "getlocal":
					case "setlocal":
						if(localCount < arr[0] + 1)
							localCount = arr[0] + 1;
					case "getlocal_3":
					case "setlocal_3":
						if(localCount < 4)
							localCount = 4;
					case "getlocal_2":
					case "setlocal_2":
						if(localCount < 3)
							localCount = 3;
					case "getlocal_1":
					case "setlocal_1":
						if(localCount < 2)
							localCount = 2;
					case "getlocal_0":
					case "setlocal_0":
						if(localCount < 1)
							localCount = 1;
						break;
				}
				curNumStack += pCode.deltaNumStack();
				curNumScope += pCode.deltaNumScope();
				if(maxStack < curNumStack)
					maxStack = curNumStack;
				if(maxScope < curNumScope)
					maxScope = curNumScope;
			}
			methodBody.initScopeDepth = 0;
			methodBody.maxScopeDepth = maxScope;
			//由于有条件分支的情况存在，我这里做的线性检查会不准确，有可能导致计算的结果比之前的还要少
			//这里先简单处理这种情况，如果计算结果比之前的还少，就用之前的
			if(methodBody.maxStack < maxStack)
				methodBody.maxStack = maxStack;
			if(methodBody.localCount < localCount)
				methodBody.localCount = localCount;
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