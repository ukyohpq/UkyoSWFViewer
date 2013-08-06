package decompiler.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * bit数组，用于更高精度(bit级)处理数据。提供了一系列类似ByteArray的方法，同时和ByteArray一样也支持[]访问符
	 * @author ukyohpq
	 * 
	 */
	public class BitArray extends Proxy
	{
		private var _vec:Vector.<int>;
		private var _position:uint;

		/**
		 * 当前指针位置
		 * @return 
		 * 
		 */
		public function get position():uint
		{
			return _position;
		}

		public function set position(value:uint):void
		{
			_position = value;
		}

		public function BitArray()
		{
			_vec = new <int>[];
			_position = 0;
		}
		
		/**
		 * bit数组长度
		 * @return 
		 * 
		 */
		public function get length():int
		{
			return _vec.length;
		}
		
		/**
		 * 按照指定的bit长度读出一个无符号32位整数
		 * @param length
		 * @return 
		 * 
		 */
		public function readUint(length:int):uint
		{
			return uint(readInt(length));
		}
		
		/**
		 * 按照指定的bit长度读出一个带符号32位整数
		 * @param length
		 * @return 
		 * 
		 */
		public function readInt(length:int):int
		{
			if(length >= 32)
			{
				length = 32;
			}
			var n:int;
			for (var i:int = 0; i < length; ++i) 
			{
				n <<= 1;
				n |= readBit();
			}
			return n;
		}
		
		/**
		 * 按照指定的bit长度numBits写入一个无符号整型u，带符号整型也可转成无符号整型后写入。
		 * 如果u本身不够numBits位，前面会用0补齐
		 * @param u			要写入的整数
		 * @param numBits	不能大于32位，大于32位按照32位处理
		 * 
		 */
		public function writeUint(u:uint, numBits:uint):void
		{
			if(numBits >= 32)
			{
				numBits = 32;
			}else{
				//要是写入32位的话，就不用截取u了
				//否则就要截取u的后numBits位，
				//如果u本身不够numBits位，前面会用0补齐
				u &= (1 << numBits) - 1;
			}
			
			for (var i:int = 0; i < numBits; ++i) 
			{
				_vec.push(u >> (numBits - i - 1) & 1);
			}
			_position += numBits;
		}
		
		/**
		 * 从BitArray中按照指定的bit长度读取一个小于255的整数。0表示如果剩余bit大于8位，则读取8位，
		 * 否则读取剩余所有bit
		 * @param length	要读取的bit长度，最大为8位，如果length超过了可用bit位，则报错
		 * @return 
		 * 
		 */
		public function readByte(length:int = 0):int
		{
			//检测指定的length是否越界了，此时越界将报错
			if(bitsAvailable < length)
			{
				throw new Error("遇到bit尾");
			}
			
			//检测输入的length是否是0或者大于8的数，在这种情况下，按照8位处理，
			//因为这里是自动转换成8位的，不是传入的参数8，所以此时不报错，可用bit位数不够
			//将取剩余所有bit
			if(length == 0 || length > 8)
			{
				length = 8;
			}
			
			//检测可用bit位数不够，如果不够，就取剩余所有bit
			if(bitsAvailable < length)
			{
				length = bitsAvailable;
			}
			
			//n的算法
			//从左向右取值，高位左移位数多，低位左移位数少
			//移动位数算法：
			//总位数为length，第i位的数需要左移的位数为length - i - 1
			//也可以用另一个算法
			var n:int;
			for (var i:int = 0; i < length; ++i) 
			{
				n |= _vec[ _position++ ] << (length - i - 1);
//				另一算法，n为增量值
//				将n左移一位，然后与取出来的值合并
//				n <<= 1;
//				n |= _vec[ _position++ ];
			}
			
			return n;
		}
		
		/**
		 * 把一个小于255的整数写入数组，大于255的将只写入低8位
		 * @param byte
		 * 
		 */
		public function writeByte(byte:int):void
		{
			var length:int = 8;
			if(byte > 0xFF)
			{
				byte &= 0xFF;
			}
			
			for (var i:int = 0; i < length; ++i) 
			{
				_vec[ _position++ ] = (byte >> (length - i - 1) & 1);
			}
		}
		
		/**
		 * 写入一个bit
		 * @param value
		 * 
		 */
		public function writeBit(value:int):void
		{
			if(value != 0)
			{
				value = 1;
			}
			_vec.push(value);
			_position++;
		}
		
		/**
		 * 读取一个bit
		 * @return 
		 * 
		 */
		public function readBit():int
		{
			if(bitsAvailable <= 0)
			{
				throw new Error("遇到bit尾");
			}
			return _vec[ _position++ ];
		}
		
		/**
		 * 可用bit数
		 * @return 
		 * 
		 */
		public function get bitsAvailable():int
		{
			return _vec.length - _position;
		}
		
		public function toString():String
		{
			var str:String = "";
			var length:int = _vec.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(i > 0 && i % 4 == 0)
				{
					str += " ";
				}
				str += _vec[i].toString();
			}
			return str;
		}
		
		/**
		 * 从bit流中读取 length 参数指定的数据bit数。从 offset 指定的位置开始，
		 * 将bit读入 bitArr 参数指定的 BitArray 对象中，并将bit写入目标 BitArray 中。
		 * @param bitArr	要将数据读入的 BitArray 对象。
		 * @param offset	bit 中的偏移（位置），应从该位置写入读取的数据。
		 * @param length	要读取的bit数。默认值 0 导致读取所有可用的数据。
		 * 
		 */
		public function readBits(bitArr:BitArray, offset:int = 0, length:int = 0):void
		{
			bitArr.position = offset;
			if(length == 0)
			{
				length = _vec.length;
			}
			
			for (var i:int = 0; i < length; ++i) 
			{
				bitArr[ bitArr._position++ ] = _vec[ _position++ ];
			}
		}
		
		/**
		 * 将指定字节数组 bytes（起始偏移量为 offset，从零开始的索引）中包含 length 个字节的字节序列写入bit流。 
		 * 如果省略 length 参数，则使用默认长度 0；该方法将从 offset 开始写入整个缓冲区。如果还省略了 offset 参数，则写入整个缓冲区。 
		 * 如果 offset 或 length 超出范围，它们将被锁定到 bytes 数组的开头和结尾。
		 * @param bitArr	ByitArray 对象。
		 * @param offset	从 0 开始的索引，表示在数组中开始写入的位置。
		 * @param length	一个无符号整数，表示在缓冲区中的写入范围。
		 * 
		 */
		public function writeByteArray(bytes:ByteArray, offset:int = 0, length:int = 0):void
		{
			if(offset < 0)
			{
				offset = 0;
			}
			
			if(offset >= bytes.length)
			{
				trace("偏移量溢出，归零处理");
				offset = 0;
			}
			
			if(length == 0)
			{
				length = bytes.length - offset;
			}
			var i:int = offset;
			while(length)
			{
				writeByte(bytes[i]);
				length--;
				i++;
				if(i >= bytes.length)
				{
					break;
				}
			}
		}
		
		/**
		 * 将指定bit数组 bitArr（起始偏移量为 offset，从零开始的索引）中包含 length 个bit的bit序列写入bit流。 
		 * 如果省略 length 参数，则使用默认长度 0；该方法将从 offset 开始写入整个缓冲区。如果还省略了 offset 参数，则写入整个缓冲区。 
		 * 如果 offset 或 length 超出范围，它们将被锁定到 bit 数组的开头和结尾。
		 * @param bitArr	ByitArray 对象。
		 * @param offset	从 0 开始的索引，表示在数组中开始写入的位置。
		 * @param length	一个无符号整数，表示在缓冲区中的写入范围。
		 * 
		 */
		public function writeBits(bitArr:BitArray, offset:int = 0, length:int = 0):void
		{
			if(offset < 0)
			{
				offset = 0;
			}
			
			if(offset >= bitArr.length)
			{
				trace("偏移量溢出，归零处理");
				offset = 0;
			}
			
			if(length == 0)
			{
				length = bitArr.length - offset;
			}
			var i:int = offset;
			while(length)
			{
				_vec[ _position++ ] = bitArr[i];
				length--;
				i++;
				if(i >= bitArr.length)
				{
					break;
				}
			}
		}
		
		/**
		 * 从bit数组中读取一个指定长度的32位定点数
		 * @param length
		 * @return 
		 * 
		 */
		public function read32FBByLength(length:int):Number
		{
			if(length > 32)
				length = 32;
			var ui:int = readInt(length);
			var si:int = 32 - length;
			ui = ui << si >> si;
			var decimal:Number = (ui & 0xFFFF) / 0x10000;
			var num:int = ui >> 16;
			return num + decimal;
		}
		
		/**
		 * 将一个数以定点数的形式按照指定长度写入bit数组中，如果定点数长度比指定长度要长，则高位截断
		 * @param value
		 * @return 
		 * 
		 */
		public function write32FBByLength(value:Number, length:int):void
		{
			var num:int = int(value);
			var decimal:Number = (value - num) * 0x10000;
			var result:int = (num << 16) | decimal;
			writeUint(result, length);
		}
		
		/**
		 * 制作该bit数组的一个副本
		 * @return 
		 * 
		 */
		public function clone():BitArray
		{
			var ba:BitArray = new BitArray;
			var length:int = _vec.length;
			for (var i:int = 0; i < length; ++i) 
			{
				ba[i] = _vec[i];
			}
			
			return ba;
		}
		
		/**
		 * 清除bit数组中的数据
		 * 
		 */
		public function clear():void
		{
			_vec.length = 0;
			_position = 0;
		}
		
		/**
		 * 转化为字节数组，并字节对齐
		 * @return 转化的字节数组
		 * 
		 */
		public function toByteArray():ByteArray
		{
			var tempPosition:int = _position;
			_position = 0;
			var by:ByteArray = new ByteArray;
			while(bitsAvailable)
			{
				by.writeByte(readByte());
			}
			_position = tempPosition;
			return by;
		}
		
		//实现数组访问符直接读写某bit
		override flash_proxy function getProperty(name:*):*
		{
			if(!isNaN(parseInt(name)))
			{
				return _vec[name];
			}else{
				throw new Error(name);
			}
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			if(!isNaN(parseInt(name)))
			{
				var index:int = parseInt(name);
				//这里需要给vec扩充长度，否则会下标越界
				//由于是int型的vec，所以扩充之后会将元素填0，
				//这也省去了用0占位的麻烦
				if(_vec.length < index + 1)
				{
					_vec.length = index + 1;
				}
				_vec[name] = value;
			}else{
				throw new Error(name);
			}
		}
	}
}