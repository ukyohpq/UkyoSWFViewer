package decompiler.tags.controlTags.defineSceneAndFrameLabelData
{
	import decompiler.tags.controlTags.AbstractControlTag;
	import decompiler.utils.SWFUtil;
	
	import flash.utils.ByteArray;
	
	public class DefineSceneAndFrameLabelDataTag extends AbstractControlTag
	{
		private var _scenceVec:Vector.<OffsetAndName>;
		private var _labels:Vector.<OffsetAndName>;
		public function DefineSceneAndFrameLabelDataTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			var length:int = SWFUtil.readU32($data);
			_scenceVec = new Vector.<OffsetAndName>(length);
			trace(preFix + "numScences:" + length);
			for (var i:int = 0; i < length; ++i) 
			{
				var oa:OffsetAndName = new OffsetAndName;
				oa.decodeFromBytes($data);
				_scenceVec[i] = oa;
				trace(preFix + "scence index:" + oa);
			}
			
			length = SWFUtil.readU32($data);
			trace(preFix + "numLabels:" + length);
			_labels = new Vector.<OffsetAndName>(length);
			for (i = 0; i < length; ++i) 
			{
				oa = new OffsetAndName;
				oa.decodeFromBytes($data);
				_scenceVec[i] = oa;
				trace(preFix + "label index:" + oa);
			}
			
			super.realDecode();
		}
		
		
	}
}