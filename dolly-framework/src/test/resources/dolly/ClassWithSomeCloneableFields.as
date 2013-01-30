package dolly {

public class ClassWithSomeCloneableFields {

	public static var staticProperty1:String = "static property value 1";

	[Cloneable]
	public static var staticProperty2:String = "static property value 2";

	[Cloneable]
	public static var staticProperty3:String = "static property value 3";

	private var _writableField:String = 'writable field value';
	private var _readOnlyField:String = "read-only field value";

	public var property1:String = "value 1";

	[Cloneable]
	public var property2:String = "value 2";

	[Cloneable]
	public var property3:String = "value 3";

	public function ClassWithSomeCloneableFields() {
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
