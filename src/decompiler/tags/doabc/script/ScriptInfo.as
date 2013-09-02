package decompiler.tags.doabc.script
{
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.tags.doabc.trait.IHasTraits;
	import decompiler.tags.doabc.trait.TraitsInfo;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * The script_info entry is used to define characteristics of an ActionScript 3.0 script
	 * script_info
		{
			u30 init
			u30 trait_count
			traits_info trait[trait_count]
		}
	 * @author ukyohpq
	 * 
	 */
	public final class ScriptInfo extends ABCFileElement implements IReferenceable, IHasTraits
	{
		private var _init:int;

		/**
		 * The init field is an index into the method array of the abcFile. 
		 * It identifies a function that is to be invoked prior to any other code in this script.
		 */
		public function get init():int
		{
			return _init;
		}
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			 include "../reference/IReferenceable_Fragment_1.as"
			
		}
		
		
		/**
		 * @private
		 */
		public function set init(value:int):void
		{
			modify();
			try{
				$abcFile.getMethodInfoByIndex(_init).removeReference(this, "init");
			}catch(err:Error)
			{
				trace(err);
			}
			_init = value;
			$abcFile.getMethodInfoByIndex(_init).addReference(this, "init");
		}

		/**
		 * The value of trait_count is the number of entries in the trait array. 
		 * The trait array is the set of traits defined by the script.
		 */
		private var _traitsArray:Vector.<TraitsInfo>;
		public function ScriptInfo()
		{
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			//read init
			_init = SWFUtil.readU30(byte);
			
			//read trait_count
			var length:int = SWFUtil.readU30(byte);
			_traitsArray = new Vector.<TraitsInfo>(length);
			for (var i:int = 0; i < length; ++i) 
			{
				var traitInfo:TraitsInfo = $abcFile.elementFactory(TraitsInfo) as TraitsInfo;
				traitInfo.target = this;
				traitInfo.decodeFromBytes(byte);
				_traitsArray[i] = traitInfo;
			}
			
			include "../reference/IReferenced_Fragment_1.as";
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			
			//write init;
			SWFUtil.writeU30(byte, _init);
			
			//write trait_count
			var length:int = _traitsArray.length;
			SWFUtil.writeU30(byte, length);
			
			for (var i:int = 0; i < length; ++i) 
			{
				var tempByte:ByteArray = _traitsArray[i].encode();
				byte.writeBytes(tempByte);
				tempByte.clear();
			}
			
			return byte;
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "scriptInfo";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("init", "md(" + _init + ")");
			var length:int = _traitsArray.length;
			var traits:SWFXML = new SWFXML("traits");
			xml.appendChild(traits);
			for (var i:int = 0; i < length; ++i) 
			{
				traits.appendChild(_traitsArray[i].toXML("trait_" + i));
			}
			
			return xml;
		}
		
		public function creatRefrenceRelationship():void
		{
			$abcFile.getMethodInfoByIndex(_init).addReference(this, "init");
		}
		
		public function addTrait(trait:TraitsInfo):void
		{
			_traitsArray.push(trait);
			modify();
		}
		
		public function addTraitAt(trait:TraitsInfo, index:int):void
		{
			_traitsArray.splice(index, 0, trait);
			modify();
		}
		
		public function getTraits():Vector.<TraitsInfo>
		{
			return _traitsArray.slice();
		}
		
		public function removeTrait(trait:TraitsInfo):void
		{
			var index:int = _traitsArray.indexOf(trait);
			if(index == -1)
				throw new Error("并没有这个trait");
			removeTraitAt(index);
			modify();
		}
		
		public function removeTraitAt(index:int):void
		{
			_traitsArray.splice(index, 1);
			modify();
		}
		
	}
}