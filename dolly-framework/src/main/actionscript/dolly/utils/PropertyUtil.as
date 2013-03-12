package dolly.utils {

import dolly.core.dolly_internal;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

use namespace dolly_internal;

public class PropertyUtil {

	dolly_internal static function copyArray(targetObj:*, propertyName:String, sourceProperty:*):void {
		targetObj[propertyName] = (sourceProperty as Array).slice();
	}

	dolly_internal static function copyArrayList(targetObj:*, propertyName:String, arrayList:ArrayList):void {
		targetObj[propertyName] = arrayList.source ? new ArrayList(arrayList.source) : new ArrayList();
	}

	dolly_internal static function copyArrayCollection(targetObj:*, propertyName:String, sourceProperty:*):void {
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

		if (sourceProperty is ArrayList) {
			copyArrayList(targetObj, propertyName, sourceObj);
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

		if (sourceProperty is ArrayList) {
			copyArrayList(targetObj, propertyName, sourceProperty);
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
