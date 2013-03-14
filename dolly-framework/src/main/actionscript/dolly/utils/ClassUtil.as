package dolly.utils {
import flash.net.registerClassAlias;
import flash.utils.getQualifiedClassName;

public class ClassUtil {

	public static function getFullClassName(clazz:Class):String {
		return getQualifiedClassName(clazz).replace("::", ".");
	}

	public static function registerAliasFor(clazz:Class):void {
		registerClassAlias(
				getFullClassName(clazz),
				clazz
		);
	}
}
}
