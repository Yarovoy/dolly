package dolly.data {

public class PropertyLevelCopyableCloneableClass {

	[Copyable]
	[Cloneable]
	public static var staticProperty1:String = "Value of first-level static property.";

	[Copyable]
	[Cloneable]
	private var _writableField1:String = "Value of first-level writable field.";

	[Copyable]
	[Cloneable]
	public var property1:String = "Value of first-level public property 1.";

	public var property2:String = "Value of first-level public property 2.";

	public function PropertyLevelCopyableCloneableClass() {
	}

	[Copyable]
	[Cloneable]
	public function get writableField1():String {
		return _writableField1;
	}

	public function set writableField1(value:String):void {
		_writableField1 = value;
	}

	[Copyable]
	[Cloneable]
	public function get readOnlyField1():String {
		return "Value of first-level read-only field.";
	}
}
}
