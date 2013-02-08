package dolly.data {

[Copyable]
public class ClassLevelCopyableSubclass extends ClassLevelCopyable {

	private var _writableField2:String;

	public var property4:String;
	public var property5:String;

	public function ClassLevelCopyableSubclass() {
	}

	public function get writableField2():String {
		return _writableField2;
	}

	public function set writableField2(value:String):void {
		_writableField2 = value;
	}
}
}
