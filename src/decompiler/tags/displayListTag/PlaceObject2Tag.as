package decompiler.tags.displayListTag
{
	import decompiler.core.SWFClipActions;
	import decompiler.core.SWFColorTransform;
	import decompiler.core.SWFMatrix;
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.tags.SWFTag;
	import decompiler.utils.SWFUtil;
	
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	public class PlaceObject2Tag extends SWFTag implements ICanInDefineSpriteTag
	{
		private var PlaceFlagHasClipActions:int;
		private var PlaceFlagHasClipDepth:int;
		private var PlaceFlagHasName:int;
		private var PlaceFlagHasRatio:int;
		private var PlaceFlagHasColorTransform:int;
		private var PlaceFlagHasMatrix:int;
		private var PlaceFlagHasCharacter:int;
		private var PlaceFlagMove:int;
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
			PlaceFlagHasClipActions = flag >> 7;
			PlaceFlagHasClipDepth = flag >> 6 & 1;
			PlaceFlagHasName = flag >> 5 & 1;
			PlaceFlagHasRatio = flag >> 4 & 1;
			PlaceFlagHasColorTransform = flag >> 3 & 1;
			PlaceFlagHasMatrix = flag >> 2 & 1;
			PlaceFlagHasCharacter = flag >> 1 & 1;
			PlaceFlagMove = flag & 1;
			
			_depth = $data.readShort();
			trace(preFix + "_depth:" + _depth);
			if(PlaceFlagHasCharacter)
				_characterId = $data.readShort();
			trace(preFix + "_characterId:" + _characterId);
			
			if(PlaceFlagHasMatrix)
			{
				_matrix = new SWFMatrix;
				_matrix.decodeFromBytes($data);
			}
			trace(preFix + "_matrix:" + _matrix);
			
			if(PlaceFlagHasColorTransform)
			{
				_colorTransform = new SWFColorTransform;
				_colorTransform.decodeFromBytes($data);
			}
			trace(preFix + "_colorTransform:" + _colorTransform);
			
			if(PlaceFlagHasRatio)
			{
				_ratio = $data.readShort();
			}
			trace(preFix + "_ratio:" + _ratio);
			
			if(PlaceFlagHasName)
			{
				_name = SWFUtil.readString($data);
			}
			trace(preFix + "_name:" + _name);
			
			if(PlaceFlagHasClipDepth)
			{
				_clipDepth = $data.readShort();
			}
			trace(preFix + "_clipDepth:" + _clipDepth);
			
			if(PlaceFlagHasClipActions)
			{
				_clipActions = new SWFClipActions;
				_clipActions.decodeFromBytes($data);
			}
			trace(preFix + "_clipActions:" + _clipActions);
		}
		
		
	}
}