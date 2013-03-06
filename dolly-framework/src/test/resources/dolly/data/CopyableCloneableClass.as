package dolly.data {

[Cloneable]
[Copyable]
public class CopyableCloneableClass {

	public static var staticProperty1:String = "Value of first-level static property.";

	private var _writableField1:String = "Value of first-level writable field.";

	public var property1:String = "Value of first-level public property.";

	public function CopyableCloneableClass() {
	}

	public function get writableField1():String {
		return _writableField1;
	}

	public function set writableField1(value:String):void {
		_writableField1 = value;
	}

	public function get readOnlyField1():String {
		return "Value of first-level read-only field.";
	}
}
}
