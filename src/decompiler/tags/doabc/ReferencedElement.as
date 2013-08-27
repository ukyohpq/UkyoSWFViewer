package decompiler.tags.doabc
{
	/**
	 * 可被引用的元素
	 * @author ukyohpq
	 * 
	 */
	public class ReferencedElement extends ABCFileElement implements IReferenced
	{
		private var _refrences:Vector.<Reference>;
		public function ReferencedElement()
		{
			_refrences = new <Reference>[];
		}
		
		public function addReference(element:IReferenceable, propertyName:String, param:int = -1):void
		{
			var reference:Reference = Reference.getFromPool(element, propertyName, param);
			_refrences.push(reference);
		}
		
		public function removeReference(element:IReferenceable, propertyName:String, param:int = -1):void
		{
			var length:int = _refrences.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(_refrences[i].equals2(element, propertyName, param))
				{
					Reference.backToPool(_refrences.splice(i, 1)[0]);
					return;
				}
			}
			throw new Error("该可引用对象尚未被其引用");
		}
		
		public function get references():Vector.<Reference>
		{
			return _refrences.slice();
		}
	}
}