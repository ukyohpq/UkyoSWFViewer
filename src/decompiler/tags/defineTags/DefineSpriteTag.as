package decompiler.tags.defineTags
{
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.tags.SWFTag;
	import decompiler.tags.TagFactory;
	
	import flash.utils.ByteArray;
	
	public class DefineSpriteTag extends AbstractDefineTag
	{
		private var Sprite_Character_ID:int;
		private var FrameCount:int;
		private var ControlTags:Vector.<SWFTag>;
		public function DefineSpriteTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			Sprite_Character_ID = $data.readShort();
			FrameCount = $data.readShort();
			ControlTags = TagFactory.creatTags($data, this);
			var length:int = ControlTags.length;
			trace(preFix + "Sprite_Character_ID:" + Sprite_Character_ID + " FrameCount:" + FrameCount + " numTags:" + length);
			for (var i:int = 0; i < length; ++i) 
			{
				var tag:SWFTag = ControlTags[i];
				trace(tag.preFix + "index:" + i);
				trace(tag.preFix + tag.toString());
				if(!(tag is ICanInDefineSpriteTag))
				{
					trace(tag.preFix + "this tag can not be in a DefineSpriteTag.");
				}
				trace(tag.preFix + "3--------------------------------");
				tag.decode();
				trace(tag.preFix + "4--------------------------------\n");
			}
			
		}
		
	}
}