package dolly.data {

public class PropertyLevelCopyableClass {

	public static var staticProperty1:String;

	[Copyable]
	public static var staticProperty2:String;

	[Copyable]
	public static var staticProperty3:String;

	private var _writableField:String;
	private var _readOnlyField:String = "read-only field value";

	public var property1:String;

	[Copyable]
	public var property2:String;

	[Copyable]
	public var property3:String;

	public function PropertyLevelCopyableClass() {
	}

	[Copyable]
	public function get writableField():String {
		return _writableField;
	}

	public function set writableField(value:String):void {
		_writableField = value;
	}

	[Copyable]
	public function get readOnlyField():String {
		return _readOnlyField;
	}
}
}
