package decompiler.core
{
	import decompiler.utils.BitArray;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	final public class SWFMatrix implements ISWFElement, IByteArrayReader
	{
		//这里的_scalex和_scaleY其实并不是一个比值，而是一个最终的宽高
		private var _scaleX:Number = 0;
		private var _scaleY:Number = 0;
		
		public function get isModified():Boolean
		{
			return _isModified;
		}
		
		private var _rotateSkew0:Number = 0;
		private var _rotateSkew1:Number = 0;
		private var _translateX:Number = 0;
		private var _translateY:Number = 0;
		private var _isModified:Boolean;
		public function SWFMatrix()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			var currentLength:int;
			var bitArr:BitArray = new BitArray;
			bitArr.writeByte(byte.readUnsignedByte());
			bitArr.position = 0;
			
			//HasScale
			if(bitArr.readBit())
			{
				var nScaleBits:int = bitArr.readByte(5);
				//将positon调整到8，准备接着写数据
				bitArr.position = 8;
				//6这个数字是第1个bit加上后5bit得到的共6bit
				while(bitArr.length < nScaleBits * 2 + 6)
				{
					bitArr.writeByte(byte.readUnsignedByte());
				}
				//将postion调整到5，准备从中读取数据了
				bitArr.position = 6;
				_scaleX = bitArr.read32FBByLength(nScaleBits);
				_scaleY = bitArr.read32FBByLength(nScaleBits);
			}
//			trace("_scaleX:" + _scaleX);
//			trace("_scaleY:" + _scaleY);
			
			//记录下当前已解析的部分的长度，在检测写入多少byte才能足够读取出下一个变长数据时
			//(类似上面的bitArr.length < _nScaleBits * 2 + (1 + 5)有用，
			//也就是说，bitArr的长度，减去当前已解析的部分的bit长度，
			//至少要达到_nRotateBits * 2 + (1 + 5)
			//得出的数学表达式为:
			//bitArr.length - currentParsedBitLength < _nRotateBits * 2 + (1 + 5)
			//当前以解析的bit长度,判断需要写入多少byte才能足够读取出下一个变长数据时有用
			var currentParsedBitLength:int = bitArr.position;
			//如果bitArr已经用完了，就需要再写入一个新数据，
			//该读HasRotate了
			if(bitArr.bitsAvailable == 0)
			{
				bitArr.writeByte(byte.readUnsignedByte());
				//写入了一个byte，因为要读1bit，所以需要将position回调8bit
				bitArr.position -= 8;
			}
			
			//HasRotate
			if(bitArr.readBit())
			{
				//记录初始position，先调整position到最末
				//写入足够的bit，再调整到初始position，
				//准备读数据
				//此时位置是整个scale部分加上HasRotate的1bit
				var position:int = bitArr.position;
				//如果有rotate，那么需要检测剩余的bit够不够5
				if(bitArr.bitsAvailable < 5)
				{
					bitArr.position = bitArr.length;
					bitArr.writeByte(byte.readUnsignedByte());
					bitArr.position = position;
				}
				
				var nRotateBits:int = bitArr.readByte(5);
				//此时位置是整个scale部分加上Rotate的头部的6bit
				position = bitArr.position;
				//调整position到末尾，以备在正确的位置写入数据
				bitArr.position = bitArr.length;
				while(bitArr.length < currentParsedBitLength + nRotateBits * 2 + 6)
				{
					bitArr.writeByte(byte.readUnsignedByte());
				}
				bitArr.position = position;
				_rotateSkew0 = bitArr.read32FBByLength(nRotateBits);
				_rotateSkew1 = bitArr.read32FBByLength(nRotateBits);
			}
//			trace("_rotateSkew0:" + _rotateSkew0);
//			trace("_rotateSkew1:" + _rotateSkew1);
			
			currentLength = bitArr.position;
			if(bitArr.bitsAvailable < 5)
			{
				bitArr.position = bitArr.length;
				bitArr.writeByte(byte.readUnsignedByte());
				bitArr.position = currentLength;
			}
			var nTranslateBits:int = bitArr.readByte(5);
			bitArr.position = bitArr.length;
			while(bitArr.length < currentLength + nTranslateBits * 2 + 5)
			{
				bitArr.writeByte(byte.readUnsignedByte());
			}
			bitArr.position = currentLength + 5;
			_translateX = bitArr.readInt(nTranslateBits);
			_translateY = bitArr.readInt(nTranslateBits);
			
//			trace("_translateX:" + _translateX);
//			trace("_translateY:" + _translateY);
		}
		
		public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "Matrix";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("scaleX", _scaleX);
			xml.setAttribute("scaleY", _scaleY);
			xml.setAttribute("rotateSkew0", _rotateSkew0);
			xml.setAttribute("rotateSkew1", _rotateSkew1);
			xml.setAttribute("translateX", _translateX);
			xml.setAttribute("translateY", _translateY);
			return xml;
		}
		
		
		//尚未测试
		public function encode():ByteArray
		{
			var bitArr:BitArray = new BitArray;
			if(_scaleX == 0 && _scaleY == 0)
			{
				bitArr.writeBit(0);
			}else{
				bitArr.writeBit(1);
				writeFB(_scaleX, _scaleY);
			}
			
			if(_rotateSkew0 == 0 && _rotateSkew1 == 0)
			{
				bitArr.writeBit(0);
			}else{
				bitArr.writeBit(1);
				writeFB(_rotateSkew0, _rotateSkew1);
			}
			
			var translateXLength:int = SWFUtil.getBitLength(_translateX, true);
			var translateYLength:int = SWFUtil.getBitLength(_translateY, true);
			var nTranslateBits:int = (translateXLength > translateYLength)?translateXLength:translateYLength;
			//5是规定长度
			bitArr.writeUint(nTranslateBits, 5);
			bitArr.writeUint(_translateX, translateXLength);
			bitArr.writeUint(_translateY, translateYLength);
			
			function writeFB(bitArr:BitArray, fb1:Number, fb2:Number):void
			{
				var fb1length:int = SWFUtil.getFB32Length(fb1);
				var fb2length:int = SWFUtil.getFB32Length(fb2);
				var fbLength:int = (fb1length > fb2length)?fb1length:fb2length;
				//5是规定长度
				bitArr.writeUint(fbLength, 5);
				bitArr.write32FBByLength(fb1, fbLength);
				bitArr.write32FBByLength(fb2, fbLength);
			}
			
			return bitArr.toByteArray();
		}
		
	}
}