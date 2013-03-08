package dolly.data {

public class PropertyLevelCopyableSubclass extends PropertyLevelCopyableClass {

	[Copyable]
	public static var staticProperty3:String = "Value of second-level static property 3.";

	public static var staticProperty4:String = "Value of second-level static property 4.";

	[Copyable]
	private var _writableField2:String = "Value of second-level writable field.";

	[Copyable]
	public var property3:String = "Value of second-level public property 3.";

	public var property4:String = "Value of second-level public property 4.";

	public function PropertyLevelCopyableSubclass() {
	}

	[Copyable]
	public function get writableField2():String {
		return _writableField2;
	}

	public function set writableField2(value:String):void {
		_writableField2 = value;
	}

	[Copyable]
	public function get readOnlyField2():String {
		return "Value of second-level read-only field.";
	}
}
}
