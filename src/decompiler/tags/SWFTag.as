package decompiler.tags
{
	import decompiler.core.ICanModify;
	import decompiler.core.ISWFElement;
	import decompiler.tags.defineTags.DefineSpriteTag;
	import decompiler.tags.doabc.DoAbc2Tag;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class SWFTag implements ISWFElement, ICanModify
	{
		public var parentTag:DefineSpriteTag;
		protected var $id:uint;
		protected var $isModified:Boolean;

		/**
		 * 该tag是否修改过，如果修改过，需要重新编译tag体，否则，不需要编译tag体
		 */
		public function get isModified():Boolean
		{
			return $isModified;
		}

		private var _xml:XML = <tag/>;
		final public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "tag";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("name", tagName);
			xml.setAttribute("id", id);
			contentToXML(xml);
			return xml;
		}
		
		protected function contentToXML(xml:SWFXML):void
		{
			//empty
		}
		
		protected var $data:ByteArray;

		public function get tagName():String
		{
			return TagType.getNameByID(id);
		}

		public function SWFTag(id:int, data:ByteArray)
		{
			if(this["constructor"] == SWFTag)
				throw new Error("抽象类不能实例化");
			$id = id;
			$data = data;
			$data.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function get data():ByteArray
		{
			return $data;
		}

		public function get id():uint
		{
			return $id;
		}
		
		/**
		 * 不修改数据，直接编码tag
		 * @return 
		 * 
		 */
		final public function encode():ByteArray
		{
			//如果该tag修改过，则重新编译tag体
			if(isModified)
			{
				$data.clear();
				encodeData();
			}
			
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			//creatHead
			var shortPartLength:int = TagConfig.SHORT_TAG_LOW_LENGTH;
			var shortPart:int = TagConfig.SHORT_TAG_LOW_PART;
			var head:uint = $id << shortPartLength;
			var length:uint = $data.length;
			if(length < shortPart)
			{
				head |= length;
				byte.writeShort(head);
			}else{
				head |= shortPart;
				byte.writeShort(head);
				byte.writeUnsignedInt(length);
			}
			
			byte.writeBytes($data);
			return byte;
		}
		
		protected function encodeData():void
		{
			//todo
		}
		
		final public function decode():void
		{
//			try{
				realDecode();
//			}catch(err:Error)
//			{
//				trace("tag parse err.");
//				throw (err);
//			}
		}
		
		protected function realDecode():void
		{
			//must be override
		}
		
		public function toString():String
		{
			return "[ id:" + $id + ", tagName:" + tagName + ", length:" + length + " ]";
		}
		
		public function get length():int
		{
			return $data.length + 2;
		}
		
		/**
		 * 复制tag
		 * @return 
		 * 
		 */
		public function clone():SWFTag
		{
			return convert($id);
		}
		
		/**
		 * 把tag转型成为指定id的tag
		 * @param tagID	要转型的tag
		 * @return 
		 * 
		 */
		public function convert(tagID:int, offset:int = 0):SWFTag
		{
			if(offset == 0)
				return new (TagFactory.getTagClassByID(tagID))(tagID, $data);
			
			var byte:ByteArray = new ByteArray;
			byte.writeBytes($data, offset);
			
			return new (TagFactory.getTagClassByID(72))(tagID, byte);
		}
		
		public function toHex():String
		{
			var byte:ByteArray = encode();
			var str:String = "";
			var length:int = byte.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var b:int = byte[i];
				if(b < 16)
				{
					str += "0" + byte[i].toString(16) + " ";
				}else{
					str += byte[i].toString(16) + " ";
				}
				
			}
			
			return str;
		}
		
	}
}