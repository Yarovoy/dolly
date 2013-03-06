package dolly.data {

public class PropertyLevelCopyableCloneableClass {

	[Copyable]
	[Cloneable]
	public static var staticProperty1:String;

	[Copyable]
	[Cloneable]
	private var _writableField1:String;

	[Copyable]
	[Cloneable]
	private var _readOnlyField1:String = "read-only field value";

	[Cloneable]
	public var property1:String;

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
		return _readOnlyField1;
	}
}
}
