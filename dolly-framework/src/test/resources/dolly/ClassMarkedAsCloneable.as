package dolly {

[Cloneable]
public class ClassMarkedAsCloneable {

	private var _writableField:String = 'writable field value';
	private var _readOnlyField:String = "read-only field value";

	public var property1:String = "value 1";
	public var property2:String = "value 2";
	public var property3:String = "value 3";

	public function ClassMarkedAsCloneable() {
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
