package decompiler.tags.doabc
{
	/**
	 * doabc中的引用
	 * @author ukyohpq
	 * 
	 */
	public class Reference
	{
		private static var _pool:Vector.<Reference> = new <Reference>[];
		public static function getFromPool(element:IReferenceable, propertyName:String, param:int = 0):Reference
		{
			var reference:Reference;
			if(_pool.length)
			{
				reference = _pool.shift();
				reference._element = element;
				reference._propertyName = propertyName;
				reference._param = param;
			}else{
				reference = new Reference(element, propertyName, param);
			}
			
			return reference;
		}
		
		public static function backToPool(reference:Reference):void
		{
			reference._element = null;
			reference._propertyName = null;
			reference._param = 0;
			_pool.push(reference);
		}
		
		private var _element:IReferenceable;

		public function get element():IReferenceable
		{
			return _element;
		}

		private var _propertyName:String;

		public function get propertyName():String
		{
			return _propertyName;
		}

		private var _param:int;

		public function get param():int
		{
			return _param;
		}

		/**
		 * 
		 * @param element	引用对象元素
		 * @param propertyName	该元素通过该名称的属性引用了一个引用对象
		 * @param params	该名称属性的参数，可选，因为有的情况是属性是个数组，数组的某索引的元素引用了一个引用对象
		 * 
		 */
		public function Reference(element:IReferenceable, propertyName:String, param:int = 0)
		{
			_element = element;
			_propertyName = propertyName;
			_param = param;
		}
		
		public function equals(re:Reference):Boolean
		{
			return _element == re._element && _propertyName == re._propertyName && _param == re._param;
		}
		
		public function equals2(element:IReferenceable, propertyName:String, param:int = 0):Boolean
		{
			return _element == element && _propertyName == propertyName && _param == param;
		}
		
		public function toString():String
		{
			return "[Reference element:" + _element + " propertyName:" + _propertyName + " param:" + _param + "]";
		}
	}
}