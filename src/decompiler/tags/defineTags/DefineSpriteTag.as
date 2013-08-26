package decompiler.tags.defineTags
{
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.tags.SWFTag;
	import decompiler.tags.TagFactory;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class DefineSpriteTag extends AbstractDefineTag
	{
		public var FrameCount:int;
		public var ControlTags:Vector.<SWFTag>;
		public function DefineSpriteTag(id:int, data:ByteArray)
		{
			super(id, data);
			$charactorID = 0;
			FrameCount = 0;
			ControlTags = Vector.<SWFTag>([]);
		}
		
		override protected function realDecode():void
		{
			$charactorID = $data.readShort();
			FrameCount = $data.readShort();
			ControlTags = TagFactory.creatTags($data, this);
			var length:int = ControlTags.length;
//			trace("Sprite_Character_ID:" + Sprite_Character_ID + " FrameCount:" + FrameCount + " numTags:" + length);
			for (var i:int = 0; i < length; ++i) 
			{
				var tag:SWFTag = ControlTags[i];
//				trace("index:" + i);
//				trace(tag.toString());
				if(!(tag is ICanInDefineSpriteTag))
				{
					trace("this tag can not be in a DefineSpriteTag.");
				}
//				trace("3--------------------------------");
				tag.decode();
//				trace("4--------------------------------\n");
			}
		}
		
		override protected function encodeData():void
		{
			$data.writeShort($charactorID);
			$data.writeShort(FrameCount);
			while(ControlTags.length)
			{
				$data.writeBytes(ControlTags.shift().encode());
			}
		}
		
		public function addTagAt(tag:SWFTag, index:int = -1):void
		{
			if(index < 0)
			{
				addTag(tag);
			}else if(index >= ControlTags.length){
				index = ControlTags.length - 1;
			}
			
			ControlTags.splice(index, 0, tag);
		}
		
		public function addTag(tag:SWFTag):void
		{
			ControlTags.push(tag);
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<Sprite_Character_ID>" + $charactorID + "</Sprite_Character_ID>");
			xml.appendChild("<FrameCount>" + FrameCount + "</FrameCount>");
			var tags:SWFXML = new SWFXML("childTags");
			xml.appendChild(tags);
			var length:int = ControlTags.length;
			for (var i:int = 0; i < length; ++i) 
			{
				tags.appendChild(ControlTags[i].toXML());
			}
		}
		
	}
}