package decompiler.core
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.utils.BitArray;
	import decompiler.utils.SWFUtil;

	public final class SWFRect implements ISWFElement, IByteArrayReader
	{
		/**
		 * 矩形最小x
		 * @return 
		 * 
		 */
		public function get minX():Number
		{
			return _rectVec[0] / TWIPS;
		}
		
		public function set minX(value:Number):void
		{
			_rectVec[0] = uint(value * TWIPS);
		}

		/**
		 * 矩形最大x
		 * @return 
		 * 
		 */
		public function get maxX():Number
		{
			return _rectVec[1] / TWIPS;
		}
		
		public function set maxX(value:Number):void
		{
			_rectVec[1] = uint(value * TWIPS);
		}

		/**
		 * 矩形最小y
		 * @return 
		 * 
		 */
		public function get minY():Number
		{
			return _rectVec[2] / TWIPS;
		}
		
		public function set minY(value:Number):void
		{
			_rectVec[2] = uint(value * TWIPS);
		}

		/**
		 * 矩形最大y
		 * @return 
		 * 
		 */
		public function get maxY():Number
		{
			return _rectVec[3] / TWIPS;
		}
		
		public function set maxY(value:Number):void
		{
			_rectVec[3] = uint(value * TWIPS);
		}

		/**
		 * 1像素等于20twips
		 */
		private static const TWIPS:int = 20;
		
		/**
		 * 矩形用于描述元素bit长的bit长，固定为5，即第一byte的前5bit是用来描述矩形四元素的长度
		 */
		private static const RECT_SIZE_LENGTH:int = 5;
		
		/**
		 * 存矩形4元素的数组
		 */
		private var _rectVec:Vector.<uint>;
		
		/**
		 * swf文件中的矩形类，分别由元素长度，minX, maxX, minY, maxY表示，其中，元素长度是四个数值中最大值的bit长度+1
		 * encode时，会根据四个数值中的最大值的bit长度来决定元素长度，
		 * decode时，会把第一个byte的前5为解析为元素长度bit值
		 * @param minX
		 * @param maxX
		 * @param minY
		 * @param maxY
		 * 
		 */
		public function SWFRect(minX:Number = 0, maxX:Number = 0, minY:Number = 0, maxY:Number = 0)
		{
			_rectVec = new Vector.<uint>(4);
			this.minX = minX;
			this.maxX = maxX;
			this.minY = minY;
			this.maxY = maxY;
		}
		
		public function decodeFromBytes(byteArray:ByteArray):void
		{
			//算法1:易懂，但效率稍低
			var bitArr:BitArray = new BitArray;
			bitArr.writeByte(byteArray.readUnsignedByte());
			//因为要读矩形元素的bit长，所以要将位置挪回去，读完了还要挪回来
			bitArr.position = 0;
			//5是规定，前5bit是长度
			var rectBitLength:int = bitArr.readByte(5);
			//读完矩形元素的bit长，把位置再挪回来
			bitArr.position = 8;
			//最少的总长是矩形4*矩形元素长度+规定的5bit的头
			while(bitArr.length < rectBitLength * 4 + 5)
			{
				bitArr.writeByte(byteArray.readUnsignedByte());
			}
			//前5bit是矩形元素长，已经读过了，
			//这里需要读矩形元素，故将位置挪到5
			bitArr.position = 5;
			_rectVec[0] = bitArr.readUint(rectBitLength);
			_rectVec[1] = bitArr.readUint(rectBitLength);
			_rectVec[2] = bitArr.readUint(rectBitLength);
			_rectVec[3] = bitArr.readUint(rectBitLength);
			bitArr.clear();
			return;
			//算法2:做法复杂一些，不易懂，但是感觉应该更高效
			//除去第一字节中的5位矩形头部信息，还剩下3位是矩形尺寸需要的数据
			//临时数据，当一个字节读完时，存在部分数据位数不够一个rect长度(nBit)的，
			//先用存在这个临时数据总，等下下面解析后拼接
			//初始时，第一字节头5位是长度信息，所以抛去后，剩下3位是坐标数据。
			var rectHead:uint = byteArray.readUnsignedByte();
			var nBit:int = rectHead >> (8 - RECT_SIZE_LENGTH);//取一个字节的前5位，所以要右移3位，前5为是bit长度 11111 111
			var tempBits:int = rectHead & 7;//7 = 111，第一个字节的后3位先放临时bit中
			//初始标记3位   11111 111
			var mark:int = 8 - RECT_SIZE_LENGTH;
			var rectArrLength:int = _rectVec.length;
			//已解析的矩形元素个数
			var rectParseNum:int = 0;
			while(rectParseNum < rectArrLength)
			{
				//矩形元素的长度为nBit，从上个字节中解析剩下的长度为mark，
				//故这个长度是跨字节的，这里处理的是跨多少字节
				//distance是元素长度nBit-以解析bit长度mark，用来记录距离一个元素长度还差多少bit
				//如果nBit - mark大于一个字节长(8bits)，则表示下一个字节全部都用来描述这一个元素，解析将继续跨字节
				//如果nBit - mark不大于一个字节长(8bits)，则表示该字节部分用来描述这一个元素，剩余部分用来描述下一个元素
				var distance:int = nBit - mark;
				if(distance > 8)
				{
					//整个字节都用来描述该元素
					mark += 8;//需要跨字节，所以将已经解析的标记+一个字节长
					tempBits <<= 8;//解析了一个字节，所以需要将用来描述该元素的bits左移一字节长(8)
					tempBits |= byteArray.readUnsignedByte();//然后|从byteArray中读出的一字节，合并后作为新的临时bit
				}else{
					//该字节前部用于描述上一个元素，后部用来描述下一个元素
					var byte:int = byteArray.readUnsignedByte();//先读出该字节的值，用于分割处理
					mark =  8 - distance;//上一个元素将在这次解析完成，需要记录剩余部分的长度，这是下一个元素已经解析的长度
					//将之前的临时bit左移distance位，|上该字节的前distance位，即是将两部分合并
					//该字节的前distance位即是从byte >> mark得来，因为mark + distance = 一字节长8
					_rectVec[rectParseNum] = (tempBits << distance) | (byte >> mark);
					tempBits = byte & ((1 << mark) - 1);//下一个元素的临时bit
					++rectParseNum;//已经解析完成一个矩形元素
				}
			}
		}
		
		public function encode():ByteArray
		{
			//找出矩形四个元素中最大的那个，以它的bit长作为每个元素的bit长
			var max:int = 0;
			var length:int = _rectVec.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var temp:int = _rectVec[i];
				if(max < temp)
				{
					max = temp;
				}
			}
			
			//加1是规定，首bit必须是0
			var numBit:uint = SWFUtil.getBitLength(max, true);
			var bita:BitArray = new BitArray;
			//将矩形元素的bit长度的后5bit写入
			bita.writeUint(numBit, 5);
			//将矩形每个元素都写入到bit数组中
			for (i = 0; i < length; ++i) 
			{
				bita.writeUint(_rectVec[i], numBit);
			}
			return bita.toByteArray();
		}
		
		public function toString():String
		{
			var str:String = "[ ";
			str += "minX:" + minX + ", ";
			str += "maxX:" + maxX + ", ";
			str += "minY:" + minY + ", ";
			str += "maxY:" + maxY + " ]";
			return str;
		}
	}
}