package dolly.data {

[Copyable]
public class CopyableSubclass extends CopyableClass {

	public static var staticProperty2:String = "Value of second-level static property.";

	private var _writableField2:String = "Value of second-level writable field.";

	public var property2:String = "Value of second-level public property.";

	public function CopyableSubclass() {
		super();
	}

	public function get writableField2():String {
		return _writableField2;
	}

	public function set writableField2(value:String):void {
		_writableField2 = value;
	}

	public function get readOnlyField2():String {
		return "Value of second-level read-only field.";
	}
}
}
