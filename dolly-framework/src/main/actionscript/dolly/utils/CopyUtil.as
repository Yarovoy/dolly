package dolly.utils {

import mx.collections.ArrayCollection;

public class CopyUtil {

	private static function copyArray(targetObj:*, propertyName:String, sourceProperty:*):void {
		targetObj[propertyName] = (sourceProperty as Array).slice();
	}

	private static function copyArrayCollection(targetObj:*, propertyName:String, sourceProperty:*):void {
		const arrayCollection:ArrayCollection = (sourceProperty as ArrayCollection);
		targetObj[propertyName] = arrayCollection.source ?
				new ArrayCollection(arrayCollection.source.slice()) :
				new ArrayCollection();
	}

	private static function copyObject(targetObj:*, propertyName:String, sourceProperty:*):void {
		targetObj[propertyName] = sourceProperty;
	}

	public static function copyProperty(sourceObj:*, targetObj:*, propertyName:String):void {
		const sourceProperty:* = sourceObj[propertyName];

		if (sourceProperty is Array) {
			copyArray(targetObj, propertyName, sourceProperty);
			return;
		}

		if (sourceProperty is ArrayCollection) {
			copyArrayCollection(targetObj, propertyName, sourceProperty);
			return;
		}

		copyObject(targetObj, propertyName, sourceProperty);
	}

	public static function cloneProperty(sourceObj:*, targetObj:*, propertyName:String):void {
		const sourceProperty:* = sourceObj[propertyName];

		if (sourceProperty is Array) {
			copyArray(targetObj, propertyName, sourceProperty);
			return;
		}

		if (sourceProperty is ArrayCollection) {
			copyArrayCollection(targetObj, propertyName, sourceProperty);
			return;
		}

		copyObject(targetObj, propertyName, sourceProperty);
	}
}
}
