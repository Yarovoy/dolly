package dolly.utils {

import mx.collections.ArrayCollection;

public class CopyUtil {

	public static function copyProperty(sourceObj:*, targetObj:*, propertyName:String):void {
		const sourceProperty:* = sourceObj[propertyName];

		if (sourceProperty is Array) {
			targetObj[propertyName] = (sourceProperty as Array).slice();
			return;
		}

		if (sourceProperty is ArrayCollection) {
			const arrayCollection:ArrayCollection = (sourceProperty as ArrayCollection);
			targetObj[propertyName] = arrayCollection.source ?
					new ArrayCollection(arrayCollection.source.slice()) :
					new ArrayCollection();
			return;
		}

		targetObj[propertyName] = sourceProperty;
	}
}
}
