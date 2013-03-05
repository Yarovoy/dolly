package dolly.core.errors {

public class CloningError extends Error {

	public static const CLASS_IS_NOT_CLONEABLE_CODE:int = 1;
	public static const CLASS_IS_NOT_CLONEABLE_MESSAGE:String = "Class is not cloneable!";

	public function CloningError(message:* = "", id:* = 0) {
		super(message, id);
	}
}
}
