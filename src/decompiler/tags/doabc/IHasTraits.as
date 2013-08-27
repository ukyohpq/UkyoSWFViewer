package decompiler.tags.doabc
{
	import decompiler.tags.doabc.trait.TraitsInfo;

	public interface IHasTraits
	{
		function getTraits():Vector.<TraitsInfo>;
		function addTrait(trait:TraitsInfo):void;
		function addTraitAt(trait:TraitsInfo, index:int):void;
		function removeTrait(trait:TraitsInfo):void;
		function removeTraitAt(index:int):void;
	}
}