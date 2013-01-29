package dolly.core {
public interface ICopyable {
	function copy(isDeep:Boolean = false):ICopyable;
}
}
