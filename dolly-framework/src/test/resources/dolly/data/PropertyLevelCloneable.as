package dolly.data {

public class PropertyLevelCloneable {

	public static var staticProperty1:String;

	[Cloneable]
	public static var staticProperty2:String;

	[Cloneable]
	public static var staticProperty3:String;

	private var _writableField:String;
	private var _readOnlyField:String = "read-only field value";

	public var property1:String;

	[Cloneable]
	public var property2:String;

	[Cloneable]
	public var property3:String;

	public function PropertyLevelCloneable() {
	}

	[Cloneable]
	public function get writableField():String {
		return _writableField;
	}

	public function set writableField(value:String):void {
		_writableField = value;
	}

	[Cloneable]
	public function get readOnlyField():String {
		return _readOnlyField;
	}
}
}
