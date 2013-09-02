package decompiler.tags.doabc.cpools.namespaces
{
	import decompiler.utils.SWFXML;

	public class CNameSpace_0 extends CNameSpace
	{
		public function CNameSpace_0()
		{
			
			super();
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "namespace";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("name", "*");
			return xml;
		}
		
		override public function toString():String
		{
			return "*";
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../../reference/IReferenceable_Fragment_1.as";
		}
	}
}