package decompiler.utils
{
	public class SWFXML
	{
		private var _name:String;
		private var _body:Array = [];
		private var _attributes:Object;
		/**
		 * 简化的xml
		 * @param name	xml的根节点名称
		 * 
		 */
		public function SWFXML(name:String = "xml")
		{
			_name = name;
			_attributes = {};
		}
		
		/**
		 * 添加子节点，会调用该对象的toString方法
		 * @param ob
		 * 
		 */
		public function appendChild(ob:Object):void
		{
			_body.push(ob);
//			_body += ob.toString();
		}
		
		/**
		 * 设置xml的属性
		 * @param key
		 * @param value
		 * 
		 */
		public function setAttribute(key:String, value:Object):void
		{
			_attributes[key] = value.toString();
		}
		
		/**
		 * 转化成XML
		 * @return 
		 * 
		 */
		public function toXML():XML
		{
			return XML(toString());
		}
		
		public function toString():String
		{
			var str1:String = "<" + _name;
			for(var key:String in _attributes) 
			{
				var attributeValue:String = _attributes[key];
				attributeValue = modifyStrToXMLForm(attributeValue);
				str1 += " " + key + "=\"" + attributeValue + "\"";
			}
			str1 += ">";
			var length:int = _body.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var ob:* = _body[i];
				str1 += ob.toString();
//				if(ob is SWFXML)
//				{
//					str1 += ob.toString();
//				}else{
//					var s:String = ob.toString();
//					s = modifyStrToXMLForm(s);
//					str1 += s;
//				}
			}
			
			return str1 + "</" + _name + ">";
		}
		
		/**
		 * 把不符合xml格式的字符串进行调整
		 * 这个方法，其实不应该在这里出现，原本是想将CString中的非法字符处理掉，
		 * 但是又会影响到别的地方，例如，有很多地方，为了效率，在swfxml中使用的是xml的字符串形式，
		 * 这样就和字符串常量池中的，合符xml格式的字符串，发生混淆，在swfxml中使用的是xml的字符串形式，
		 * 这种情况需要处理成一个xml节点， 而字符串常量池中的，合符xml格式的字符串，却不能处理为xml节点，
		 * 所以使用XML(str)这种方式检查字符串的合法性，并不准确，而这个检查，实际上只应该在CString中处理，
		 * 因为只有这里，才是swf被编译出时，由用户决定的字符串，而别的地方，是不可能出现这个不合xml规则的字符串，
		 * 所以，现在修改为，在Ctring中的toXML方法中检测字符串的合法性，这个方法，不再使用，仅作为算法参考保留。
		 * @param str
		 * @return 
		 * 
		 */
		private static function modifyStrToXMLForm(str:String):String
		{
			try{
				XML(str);
			}catch(err:Error)
			{
				if(str.indexOf("<![CDATA[") == -1 && str.indexOf("]]>") == -1)
				{
					str = "<![CDATA[" + str + "]]>";
				}else{
					str = encodeURIComponent(str);
				}
			}
			return str;
		}
		
	}
}