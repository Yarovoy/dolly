package dolly.data {

[Cloneable]
[Copyable]
public class CopyableCloneableClass {

	public static var staticProperty1:String = "Value of first-level static property.";

	private var _writableField:String = "Value of first-level writable field.";

	public var property1:String = "Value of first-level public property.";

	public function CopyableCloneableClass() {
	}

	public function get writableField():String {
		return _writableField;
	}

	public function set writableField(value:String):void {
		_writableField = value;
	}

	public function get readOnlyField():String {
		return "Value of first-level read-only field.";
	}
}
}
