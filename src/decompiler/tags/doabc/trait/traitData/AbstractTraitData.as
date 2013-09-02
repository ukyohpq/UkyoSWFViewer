package decompiler.tags.doabc.trait.traitData
{
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class AbstractTraitData extends ABCFileElement implements IReferenceable
	{
		public function AbstractTraitData()
		{
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			include "../../reference/IReferenced_Fragment_1.as";
		}
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			 include "../../reference/IReferenceable_Fragment_1.as"
		}
		
		
		override public function encode():ByteArray
		{
			throw new Error("must be override");
		}
		
		public function getKind():int
		{
			throw new Error("must be override");
		}
		
		override final public function toXML(name:String = null):SWFXML
		{
			var kind:int = getKind();
			var xml:SWFXML = new SWFXML("traitData");
			xml.setAttribute("kind", kind);
			xml.setAttribute("type", TraitDataFactory.getTypeNameByKind(kind));
			contentToXML(xml);
			return xml;
		}
		
		protected function contentToXML(xml:SWFXML):void
		{
			//empty
		}
		
		public function creatRefrenceRelationship():void
		{
			//empty
		}
		
	}
}