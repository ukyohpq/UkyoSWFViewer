package decompiler
{
	import com.wirelust.as3zlib.JZlib;
	import com.wirelust.as3zlib.ZStream;
	
	import decompiler.core.IToXMLable;
	import decompiler.core.SWFRect;
	import decompiler.tags.SWFTag;
	import decompiler.tags.TagFactory;
	import decompiler.tags.doabc.DoAbc2Tag;
	import decompiler.tags.doabc.DoAbcTag;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import flash.utils.Endian;

	public class SWFFile implements IToXMLable
	{
		public var version:uint;
		public var size:uint;
		public var frameRate:Number;
		public var numFrames:uint;
		public var tagsArr:Vector.<SWFTag>;

		private var swfRect:SWFRect;
		public function SWFFile(fileByteArray:ByteArray)
		{
			fileByteArray.endian = Endian.LITTLE_ENDIAN;
			//swf文件类型，分为FWS,CWS,ZWS 
			var swfType:String = fileByteArray.readUTFBytes(3);//3字节
			//swf 版本
			version = fileByteArray.readByte();//1字节
			//文件大小
			size = fileByteArray.readUnsignedInt(); //4字节
			//临时作为除去头8bytes的数据载体的字节数组
			var swfMainByteArray:ByteArray;
			switch(swfType)
			{
				case "CWS":
					swfMainByteArray = new ByteArray;
					fileByteArray.readBytes(swfMainByteArray);
					try{
						swfMainByteArray.uncompress();
					}catch(err:Error){
						trace("不能用ByteArray的uncompress方法解压，结尾被加了内容！");
						trace("使用JZlib解压");
						swfMainByteArray = uncompressSelf(swfMainByteArray);
					}
					
					fileByteArray.position = 8;
					fileByteArray.writeBytes(swfMainByteArray);
					fileByteArray.position = 8;
					swfMainByteArray.clear();
					break;
				case "ZWS":
//					SWF file LZMA header
//					bytes 0-3: ZWS+version bytes 4-7: Uncompressed length (includes ZWS+version (4 bytes) and uncompressed length (4 bytes)) bytes 8-11: Compressed length bytes 12-16: LZMAproperties bytes 17-n: Compressed data
//					7z LZMA header
//					bytes 0-4: LZMA properties bytes 5-12: Uncompressed length (take the swf lzma length - 8 (don't include ZWS+version + uncompressed length)) bytes 13-n: Compressed data
					swfMainByteArray = new ByteArray;
					swfMainByteArray.endian = Endian.LITTLE_ENDIAN;
					var i:int;
					//5bytes
					//LZMA properties bytes
					//在swf中是12~16,在LZMA中是 0~4
					for (i = 0; i < 5; ++i) 
					{
						swfMainByteArray[i] = fileByteArray[12 + i];
					}
					// calculate uncompressed length, subtract 8 (remove header bytes) 
					//解压后长度，由于swf文件有文件头的8bytes，所以LZMA里要减去8
					//长度在swf中是4~7,在LZMA中是5~12，所以要补上4bytes的0
					var scriptlen:uint = (fileByteArray[4] | (fileByteArray[5] << 8 ) | (fileByteArray[6] << 16) | (fileByteArray[7] << 24)) - 8;
					for (i = 0; i < 8; i++) 
					{
						if(i < 4)
						{
							swfMainByteArray[5 + i] = (scriptlen >> (8 * i)) & 0xFF;
						}else{
							swfMainByteArray[5 + i] = 0;
						}
					}
					fileByteArray.position = 17;
					fileByteArray.readBytes(swfMainByteArray,13,fileByteArray.bytesAvailable);
					swfMainByteArray.uncompress(CompressionAlgorithm.LZMA);
					
					fileByteArray.position = 8;
					fileByteArray.writeBytes(swfMainByteArray);
					fileByteArray.position = 8;
					swfMainByteArray.clear();
					break;
				case "FWS":
					//FWS就不用处理了
					break;
				default:
					throw new Error("this is not a swf file!");
					break;
			}
			//============= 解析swf的rect数据 =======================
			swfRect = new SWFRect;
			swfRect.decodeFromBytes(fileByteArray);
			//======================================================
			frameRate = SWFUtil.readF16(fileByteArray);
			numFrames = fileByteArray.readShort();//读取 总帧数
//			trace("swfType:",swfType,"swf_version:",version,"rect:",swfRect,"frameRate:",frameRate,"frameTotal:",numFrames);
			tagsArr = TagFactory.creatTags(fileByteArray);
		}
		
		public function getDoabc():Vector.<DoAbcTag>
		{
			var vec:Vector.<DoAbcTag> = new <DoAbcTag>[];
			for each (var i:SWFTag in tagsArr) 
			{
				if(i is DoAbcTag)
					vec.push(i);
			}
			return vec;
		}
		
		public function getDoabc2():Vector.<DoAbc2Tag>
		{
			var vec:Vector.<DoAbc2Tag> = new <DoAbc2Tag>[];
			for each (var i:SWFTag in tagsArr) 
			{
				if(i is DoAbc2Tag)
					vec.push(i);
			}
			return vec;
		}
		
		public function getTagByID(tagID:int):SWFTag
		{
			var length:int = tagsArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(tagsArr[i].id == tagID)
				{
					return tagsArr[i]; 
				}
			}
			
			return null;
		}
		
		public function compile(swfType:String = "FWS"):ByteArray
		{
			var body:ByteArray = new ByteArray;
			body.endian = Endian.LITTLE_ENDIAN;
			var tempBytes:ByteArray;
			
			tempBytes = swfRect.encode();
			body.writeBytes(tempBytes);
			tempBytes.clear();
			
			SWFUtil.writeF16(body, frameRate);
//			body.writeByte(frameRate);
//			body.writeShort(frameRate << 8);
			body.writeShort(numFrames);
			var length:int = tagsArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				tempBytes = tagsArr[i].encode();
				body.writeBytes(tempBytes);
				tempBytes.clear();
			}
			
			var swfBytes:ByteArray = new ByteArray;
			swfBytes.endian = Endian.LITTLE_ENDIAN;
			swfBytes.writeUTFBytes(swfType);
			swfBytes.writeByte(version);
			
			var bodyLength:uint = body.length;
			switch(swfType)
			{
				case "FWS":
					swfBytes.writeUnsignedInt(bodyLength + 8);
					swfBytes.writeBytes(body);
					body.clear();
					break;
				case "CWS":
					body.compress();
					swfBytes.writeUnsignedInt(bodyLength + 8);
					swfBytes.writeBytes(body);
					body.clear();
					break;
				case "ZWS"://这个编码还是有问题，虽然编码出来的东西还是能够正常解码，但是fp不支持，看来fp的解码算法其实另有玄机
					body.compress(CompressionAlgorithm.LZMA);
					body.position = 5;
					swfBytes.writeUnsignedInt(bodyLength + 8);
					swfBytes.writeUnsignedInt(body.length);
					swfBytes.writeBytes(body, 0, 5);
					swfBytes.writeBytes(body, 13);
					break;
				default:
					throw new Error("this is not a swf file!");
					break;
			}
			
			return swfBytes;
		}
		
		private function uncompressSelf(compressed:ByteArray):ByteArray{
			var d_stream:ZStream = new ZStream();
			var uncompr:ByteArray = new ByteArray();
			
			d_stream.next_in = compressed;
			d_stream.next_in_index = 0;
			d_stream.next_out = uncompr;
			d_stream.next_out_index = 0;
			
			var err:int;
			err=d_stream.inflateInit();
			checkErr(d_stream, err, "inflateInit");
			
			var outcount:int = 0;
			while(d_stream.total_out < size - 8 && d_stream.total_in < compressed.length) {
				d_stream.avail_in=d_stream.avail_out=1; /* force small buffers */
				err=d_stream.inflate(JZlib.Z_NO_FLUSH);
				if(err == JZlib.Z_STREAM_END) {
					break;
				}
				
				outcount++;
//				trace(outcount + ":" + d_stream.total_out);
				
				if (!checkErr(d_stream, err, "inflate")) {
					break;
				}
			}
			trace("JZlib解压结束：剩余长度：" + d_stream.next_in.bytesAvailable);
			err=d_stream.inflateEnd();
			checkErr(d_stream, err, "inflateEnd");
			return uncompr;
		}
		
		public static function checkErr(z:ZStream, err:int, msg:String):Boolean {
			if (err != JZlib.Z_OK) {
				if (z.msg!=null) {
					trace(z.msg + " ");
				} 
				trace(msg + " error: " + err);
				return false;
			}
			return true;
		}
		
		public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "SWF";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("version", version);
			xml.setAttribute("size", size);
			xml.setAttribute("frameRate", frameRate);
			xml.setAttribute("numFrames", numFrames);
			xml.appendChild(swfRect.toXML());
			
			var tags:SWFXML = new SWFXML("tags");
			xml.appendChild(tags);
			var length:int = tagsArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				tags.appendChild(tagsArr[i].toXML());
			}
			
			return xml;
		}
		
	}
}