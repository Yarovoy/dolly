package dolly {

[Copyable]
public class ClassMarkedAsCopyable {

	public static var staticProperty1:String;
	public static var staticProperty2:String;
	public static var staticProperty3:String;

	private var _writableField:String;
	private var _readOnlyField:String = "read-only field value";

	public var property1:String;
	public var property2:String;
	public var property3:String;

	public function ClassMarkedAsCopyable() {
	}

	public function get writableField():String {
		return _writableField;
	}

	public function set writableField(value:String):void {
		_writableField = value;
	}

	public function get readOnlyField():String {
		return _readOnlyField;
	}
}
}
