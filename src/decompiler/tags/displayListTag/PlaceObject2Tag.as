package decompiler.tags.displayListTag
{
	import decompiler.core.SWFClipActions;
	import decompiler.core.SWFColorTransform;
	import decompiler.core.SWFMatrix;
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.tags.SWFTag;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class PlaceObject2Tag extends SWFTag implements ICanInDefineSpriteTag
	{
		private var _PlaceFlagHasClipActions:int;
		private var _PlaceFlagHasClipDepth:int;
		private var _PlaceFlagHasName:int;
		private var _PlaceFlagHasRatio:int;
		private var _PlaceFlagHasColorTransform:int;
		private var _PlaceFlagHasMatrix:int;
		private var _PlaceFlagHasCharacter:int;
		private var _PlaceFlagMove:int;
		private var _depth:int;
		private var _characterId:int = 1;
		private var _matrix:SWFMatrix;
		private var _colorTransform:SWFColorTransform;
		private var _ratio:int;
		private var _name:String;
		private var _clipDepth:int;
		private var _clipActions:SWFClipActions;
		public function PlaceObject2Tag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			var flag:int = $data.readUnsignedByte();
			_PlaceFlagHasClipActions = flag >> 7;
			_PlaceFlagHasClipDepth = flag >> 6 & 1;
			_PlaceFlagHasName = flag >> 5 & 1;
			_PlaceFlagHasRatio = flag >> 4 & 1;
			_PlaceFlagHasColorTransform = flag >> 3 & 1;
			_PlaceFlagHasMatrix = flag >> 2 & 1;
			_PlaceFlagHasCharacter = flag >> 1 & 1;
			_PlaceFlagMove = flag & 1;
			
			_depth = $data.readShort();
//			trace("_depth:" + _depth);
			if(_PlaceFlagHasCharacter)
				_characterId = $data.readShort();
//			trace("_characterId:" + _characterId);
			
			if(_PlaceFlagHasMatrix)
			{
				_matrix = new SWFMatrix;
				_matrix.decodeFromBytes($data);
			}
//			trace("_matrix:" + _matrix);
			
			if(_PlaceFlagHasColorTransform)
			{
				_colorTransform = new SWFColorTransform;
				_colorTransform.decodeFromBytes($data);
			}
//			trace("_colorTransform:" + _colorTransform);
			
			if(_PlaceFlagHasRatio)
			{
				_ratio = $data.readShort();
			}
//			trace("_ratio:" + _ratio);
			
			if(_PlaceFlagHasName)
			{
				_name = SWFUtil.readString($data);
			}
//			trace("_name:" + _name);
			
			if(_PlaceFlagHasClipDepth)
			{
				_clipDepth = $data.readShort();
			}
//			trace("_clipDepth:" + _clipDepth);
			
			if(_PlaceFlagHasClipActions)
			{
				_clipActions = new SWFClipActions;
				_clipActions.decodeFromBytes($data);
			}
//			trace("_clipActions:" + _clipActions);
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<PlaceFlagHasClipActions>" + _PlaceFlagHasClipActions + "</PlaceFlagHasClipActions>");
			xml.appendChild("<PlaceFlagHasClipDepth>" + _PlaceFlagHasClipDepth + "</PlaceFlagHasClipDepth>");
			xml.appendChild("<PlaceFlagHasName>" + _PlaceFlagHasName + "</PlaceFlagHasName>");
			xml.appendChild("<PlaceFlagHasRatio>" + _PlaceFlagHasRatio + "</PlaceFlagHasRatio>");
			xml.appendChild("<PlaceFlagHasColorTransform>" + _PlaceFlagHasColorTransform + "</PlaceFlagHasColorTransform>");
			xml.appendChild("<PlaceFlagHasMatrix>" + _PlaceFlagHasMatrix + "</PlaceFlagHasMatrix>");
			xml.appendChild("<PlaceFlagHasCharacter>" + _PlaceFlagHasCharacter + "</PlaceFlagHasCharacter>");
			xml.appendChild("<PlaceFlagMove>" + _PlaceFlagMove + "</PlaceFlagMove>");
			xml.appendChild("<_depth>" + _depth + "</_depth>");
			if(_PlaceFlagHasCharacter)
			{
				xml.appendChild("<characterId value=\"" + _characterId + "\"/>");
			}
			
			if(_PlaceFlagHasMatrix)
			{
				xml.appendChild(_matrix.toXML());
			}
			
			if(_PlaceFlagHasColorTransform)
			{
				xml.appendChild(_colorTransform.toXML());
			}
			
			if(_PlaceFlagHasRatio)
			{
				xml.appendChild(<ratio value={_ratio}/>);
			}
			
			if(_PlaceFlagHasName)
			{
				xml.appendChild(<name value={_name}/>);
			}
			
			if(_PlaceFlagHasClipDepth)
			{
				xml.appendChild(<clipDepth value={_clipDepth}/>);
			}
			
			if(_PlaceFlagHasClipActions)
			{
				xml.appendChild(_clipActions.toXML());
			}
		}
		
		
	}
}