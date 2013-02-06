package dolly.data {

public class PropertyLevelCopyableCloneable {

	private var _writableField:String;
	private var _readOnlyField:String = "read-only field value";

	[Cloneable]
	public var property1:String;

	[Copyable]
	[Cloneable]
	public var property2:String;

	[Copyable]
	[Cloneable]
	public var property3:String;

	public function PropertyLevelCopyableCloneable() {
	}

	[Copyable]
	[Cloneable]
	public function get writableField():String {
		return _writableField;
	}

	public function set writableField(value:String):void {
		_writableField = value;
	}

	[Copyable]
	[Cloneable]
	public function get readOnlyField():String {
		return _readOnlyField;
	}
}
}
