package decompiler.tags.controlTags.defineSceneAndFrameLabelData
{
	import decompiler.tags.controlTags.AbstractControlTag;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
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
//			trace("numScences:" + length);
			for (var i:int = 0; i < length; ++i) 
			{
				var oa:OffsetAndName = new OffsetAndName;
				oa.decodeFromBytes($data);
				_scenceVec[i] = oa;
//				trace("scence index:" + oa);
			}
			
			length = SWFUtil.readU32($data);
//			trace("numLabels:" + length);
			_labels = new Vector.<OffsetAndName>(length);
			for (i = 0; i < length; ++i) 
			{
				oa = new OffsetAndName;
				oa.decodeFromBytes($data);
				_scenceVec[i] = oa;
//				trace("label index:" + oa);
			}
			
			super.realDecode();
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			var scenes:SWFXML = new SWFXML("scenes");
			xml.appendChild(scenes);
			var length:int = _scenceVec.length;
			for (var i:int = 0; i < length; ++i) 
			{
				scenes.appendChild(_scenceVec[i].toXML());
			}
			
			var labels:XML = <labels/>;
			xml.appendChild(labels);
			length = _labels.length;
			for (var j:int = 0; j < length; ++j) 
			{
				labels.appendChild(_labels[j].toXML());
			}
		}
		
		
	}
}