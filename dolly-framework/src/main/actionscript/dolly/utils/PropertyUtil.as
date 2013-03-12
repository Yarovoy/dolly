package dolly.utils {

import dolly.core.dolly_internal;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

use namespace dolly_internal;

public class PropertyUtil {

	dolly_internal static function copyArray(sourceObj:*, targetObj:*, propertyName:String):void {
		targetObj[propertyName] = sourceObj[propertyName].slice();
	}

	dolly_internal static function copyArrayList(sourceObj:*, targetObj:*, propertyName:String):void {
		targetObj[propertyName] = sourceObj[propertyName] ?
				new ArrayList(sourceObj[propertyName].source) :
				new ArrayList();
	}

	dolly_internal static function copyArrayCollection(sourceObj:*, targetObj:*, propertyName:String):void {
		const arrayCollection:ArrayCollection = sourceObj[propertyName];
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
			copyArray(sourceObj, targetObj, propertyName);
			return;
		}

		if (sourceProperty is ArrayList) {
			copyArrayList(sourceObj, targetObj, propertyName);
			return;
		}

		if (sourceProperty is ArrayCollection) {
			copyArrayCollection(sourceObj, targetObj, propertyName);
			return;
		}

		copyObject(targetObj, propertyName, sourceProperty);
	}

	public static function cloneProperty(sourceObj:*, targetObj:*, propertyName:String):void {
		const sourceProperty:* = sourceObj[propertyName];

		if (sourceProperty is Array) {
			copyArray(sourceObj, targetObj, propertyName);
			return;
		}

		if (sourceProperty is ArrayList) {
			copyArrayList(sourceObj, targetObj, propertyName);
			return;
		}

		if (sourceProperty is ArrayCollection) {
			copyArrayCollection(sourceObj, targetObj, propertyName);
			return;
		}

		copyObject(targetObj, propertyName, sourceProperty);
	}
}
}
