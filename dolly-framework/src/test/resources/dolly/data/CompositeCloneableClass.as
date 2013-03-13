package dolly.data {
import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

[Cloneable]
public class CompositeCloneableClass {

	public var cloneable:CloneableClass;

	public var array:Array = [0, 1, 2, 3, 4];

	public var arrayList:ArrayList = new ArrayList([0, 1, 2, 3, 4]);

	public var arrayCollection:ArrayCollection = new ArrayCollection([0, 1, 2, 3, 4]);

	public function CompositeCloneableClass() {
	}
}
}
