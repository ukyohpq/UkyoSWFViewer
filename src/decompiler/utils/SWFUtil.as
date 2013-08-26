package decompiler.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * 所有均为little_endian
	 * @author ukyohpq
	 * 
	 */
	public class SWFUtil
	{
//		public static function readSB(byteArray:ByteArray, nBit:uint):int
//		{
//			//todo
//			return 0;
//		}
//		
//		public static function readUB(byteArray:ByteArray, nBit:uint):uint
//		{
//			//todo
//			return 0;
//		}
//		
//		public static function readFB(byteArray:ByteArray, nBit:uint):uint
//		{
//			//todo
//			return 0;
//		}
		
		public static function readF32(byteArray:ByteArray):Number
		{
			var v:uint = byteArray.readUnsignedInt();
			var i:int = v >>> 16;
			var f:Number = (v & 0x10000) / 0x10000;
			
			return i + f;
		}
		
		public static function readF16(byteArray:ByteArray):Number
		{
			var v:uint = byteArray.readShort();
			var i:int = v >>> 8;
			var f:Number = (v & 0x100) / 0x100;
			
			return i + f;
		}
		
		public static function writeF32(byteArray:ByteArray, num:Number):void
		{
			var i:int = int(num);
			var f:Number = num - i;
			byteArray.writeShort(Math.ceil(f * 0x10000));
			byteArray.writeShort(i);
		}
		
		public static function writeF16(byteArray:ByteArray, num:Number):void
		{
			var i:int = int(num);
			var f:Number = num - i;
			byteArray.writeByte(Math.ceil(f * 0x100));
			byteArray.writeByte(i);
		}
		
		public static function readD64(byteArray:ByteArray):Number
		{
			return byteArray.readDouble();
		}
		
		public static function writeD64(byteArray:ByteArray, num:Number):uint
		{
			byteArray.writeDouble(num);
			return 8;
		}
		
		/**
		 * 读取变长有符号32位数
		 * 最长5byte，从第一byte开始，每个byte的第一bit表示下一个byte是否还是这个数的一部分，
		 * 1代表是，0代表否，剩余的7bit才是值，后面的byte的bit要放在高位，例如：
		 * 1000 1011 0100 0110
		 * 第一byte的高位是1，所以下一个byte还是要解析的值，剩余bit是000 1011
		 * 第二byte的高位是0，所以不需要再解析下一个byte了，剩余big是100 0110
		 * 这个数是100 0110 000 1011，字节对齐后是0010 0011 0000 1011
		 * @param byteArray	从中读取数值的ByteArray
		 * @return 	读取的值
		 * 
		 */
		public static function readS32(byteArray:ByteArray):int
		{
			var value:int;
			//变长值最大只有5byte，所以读取值的时候，超过5byte就不读了
			for (var i:int = 0; i < 5; ++i) 
			{
				//读取一个byte，将其低7bit和value合并，
				//注意，第i个byte读出来的值，需要左移7*i位后再合并
				//因为是低位在前高位在后的顺序,所以需要左移
				var temp:uint = byteArray.readUnsignedByte();
				value |= ((temp & 127) << (7 * i));
				//0111 1111 = 127，所以小于127即最高bit为0，后面的byte不再解析
				if(temp < 128)
					break;
			}
			return value;
		}
		
		/**
		 * 写入变长有符号32位数
		 * @param byteArray
		 * @param n
		 * @return 	编码后所用字节长度
		 * 
		 */
		public static function writeS32(byteArray:ByteArray, n:int):uint
		{
			//简单处理写入0的情况
			if(n == 0)
			{
				byteArray.writeByte(0);
				return 1;
			}
			//每次处理7bit，直到将n的所有bit都处理完
			//如果n还有剩余bit, 就在这7bit前加一个1，组成一个byte
			var numBytes:uint = 0;
			var m:uint = uint(n);
			while(m)
			{
				if(m > 127)
				{
					//(128 | (n & 127))
					//翻译一下就是(1000 0000 | (n & 0111 1111))
					//即是在n的末7bit前加一个1组成一个byte
					byteArray.writeByte(128 | (m & 127));
					m >>>= 7;
				}else{
					byteArray.writeByte(m);
					m = 0;
				}
				numBytes++;
			}
			
			return numBytes;
		}
		
		public static function readU30(byteArray:ByteArray):uint
		{
			var value:uint;
			var maxBytes:int = 5;
			var i:int = 0;
			while(maxBytes--) 
			{
				var temp:uint = byteArray.readUnsignedByte();
				value |= ((temp & 127) << (7 * i++));
				if(temp < 128)
					break;
			}
			
			return value;
		}
		
		public static function writeU30(byteArray:ByteArray, n:uint):uint
		{
			//1073741823就是30个1
			n &= 1073741823;
			//简单处理写入0的情况
			if(n == 0)
			{
				byteArray.writeByte(0);
				return 1;
			}
			//每次处理7bit，直到将n的所有bit都处理完
			//如果n还有剩余bit, 就在这7bit前加一个1，组成一个byte
			var numBytes:uint = 0;
			while(n)
			{
				if(n > 127)
				{
					//(128 | (n & 127))
					//翻译一下就是(1000 0000 | (n & 0111 1111))
					//即是在n的末7bit前加一个1组成一个byte
					byteArray.writeByte(128 | (n & 127));
					n >>= 7;
				}else{
					byteArray.writeByte(n);
					n = 0;
				}
				numBytes++;
			}
			
			return numBytes;
		}
		
		public static function readU32(byteArray:ByteArray):uint
		{
			var value:uint;
			var maxBytes:int = 5;
			var i:int = 0;
			while(maxBytes--) 
			{
				var temp:uint = byteArray.readUnsignedByte();
				value |= ((temp & 127) << (7 * i));
				if(temp < 128)
					break;
			}
			
			return value;
		}
		
		public static function writeU32(byteArray:ByteArray, n:uint):uint
		{
			//其实和writeS32一样
			//简单处理写入0的情况
			if(n == 0)
			{
				byteArray.writeByte(0);
				return 1;
			}
			//每次处理7bit，直到将n的所有bit都处理完
			//如果n还有剩余bit, 就在这7bit前加一个1，组成一个byte
			var numBytes:uint = 0;
			while(n)
			{
				if(n > 127)
				{
					//(128 | (n & 127))
					//翻译一下就是(1000 0000 | (n & 0111 1111))
					//即是在n的末7bit前加一个1组成一个byte
					byteArray.writeByte(128 | (n & 127));
					n >>= 7;
				}else{
					byteArray.writeByte(n);
					n = 0;
				}
				numBytes++;
			}
			
			return numBytes;
		}
		
		/**
		 * 得到一个数的bit长度
		 * @param n			要检测其bit长度的数
		 * @param signed	是否包含符号位
		 * @return 
		 * 
		 */
		public static function getBitLength(n:int, signed:Boolean = false):uint
		{
			if(n < 0)
				return 32;
			var len:int = 1;
			while(n > 1)
			{
				n >>= 1;
				len++;
			}
			
			return signed?(len + 1):len;
		}
		
		/**
		 * 得到一个带符号32bit定点数的长度
		 * @param num
		 * @return 
		 * 
		 */
		public static function getFB32Length(value:Number):uint
		{
			var num:int = int(value);
			var decimal:Number = (value - num) * 0x10000;
			var result:int = (num << 16) | decimal;
//			var tempBit:BitArray = new BitArray;
//			tempBit.writeBit(result);
			var length:int = 32;
			//这里一定要算术右移，左边0补齐
			var s:int = result >>> 31;
			//1.length至少要为1
			//2.先取出第1位bit，然后循环和后面的bit(第2bit，第3bit....)比较,
			//	如果相等，则长度需要缩减1
			while((length > 1) && (s == (result >> (length - 2) & 1)))
			{
				length--;
			}
			return length;
		}
		
		public static function readS24(byte:ByteArray):int
		{
			var value:int = 0;
			//24位是3个byte
			var length:int = 3;
			//这里的字节数组是LittleEndian
			for (var i:int = 0; i < length; ++i) 
			{
				value |= (byte.readUnsignedByte() << (i * 8));
			}
			//s24第24位是符号位，故先左移8位凑齐32位，
			//将第24位顶到第32位符号位上
			//再逻辑右移8位，得到正确的带符号24bit数
			value <<= 8;
			value >>= 8;
			return value;
		}
		
		public static function writeS24(byte:ByteArray, value:int):void
		{
			//这里的字节数组是LittleEndian
			//所以先写入低位
			var length:int = 3;
			for (var i:int = 0; i < length; ++i) 
			{
				byte.writeByte((value >> (i * 8)) & 255);
			}
		}
		
		public static function writeU24(byte:ByteArray, value:uint):void
		{
			byte.writeByte(value);
			byte.length--;
			//length--自然会position--，所以不用再position--
			//byte.position--;
		}
		
		public static function readU24(byte:ByteArray):uint
		{
			if(byte.endian == Endian.BIG_ENDIAN)
			{
				return (byte.readUnsignedByte() << 16) | (byte.readUnsignedByte() << 8) | byte.readUnsignedByte();
			}else{
				return byte.readUnsignedByte() | (byte.readUnsignedByte() << 8) | (byte.readUnsignedByte() << 16);
			}
			//这个算法有点取巧，利用它自己的接口去读4byte出来，然后去掉最高位的一个byte
			//未测试哪个效率高，但是这个存在一个极限情况，如果剩余不到4byte，就会报错
//			var v:int = byte.readUnsignedInt() & 0xFFFFFF;
//			byte.position--;
//			return v;
		}
		
		/**
		 * 读一个字符串，遇到0就结束.
		 * 先得到要读的字符串的长度，然后再用readUTFByte方法读取指定长度的字符串
		 * @param byte
		 * @return 
		 * 
		 */
		public static function readString(byte:ByteArray):String
		{
			var p:int = byte.position;
			var l:int = p;
			//循环结束后，l是字符串长度加1，因为包含了最后那个0
			while(byte[l++] != 0);
			return byte.readUTFBytes(l - p);
		}
		
		/**
		 * 写入一个字符串，最后以0结束
		 * @param byte
		 * @param str
		 * 
		 */
		public static function writeString(byte:ByteArray, str:String):void
		{
			byte.writeUTFBytes(str);
			byte.writeByte(0);
		}
	}
}