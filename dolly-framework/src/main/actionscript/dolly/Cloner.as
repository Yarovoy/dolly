package dolly {

import dolly.core.dolly_internal;
import dolly.core.errors.CloningError;
import dolly.core.metadata.MetadataName;
import dolly.utils.PropertyUtil;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.AccessorAccess;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;

use namespace dolly_internal;

public class Cloner {

	private static function isTypeCloneable(type:Type):Boolean {
		return type.hasMetadata(MetadataName.CLONEABLE);
	}

	private static function failIfTypeIsNotCloneable(type:Type):void {
		if (!isTypeCloneable(type)) {
			throw new CloningError(
					CloningError.CLASS_IS_NOT_CLONEABLE_MESSAGE,
					CloningError.CLASS_IS_NOT_CLONEABLE_CODE
			);
		}
	}

	dolly_internal static function findAllWritableFieldsForType(type:Type):Vector.<Field> {
		failIfTypeIsNotCloneable(type);

		const result:Vector.<Field> = new Vector.<Field>();

		for each(var field:Field in type.properties) {
			if (!(field is Accessor) || (field as Accessor).access == AccessorAccess.READ_WRITE) {
				result.push(field);
			}
		}

		return result;
	}

	dolly_internal static function doClone(source:*, deep:int, type:Type = null):* {
		const fieldsToClone:Vector.<Field> = findAllWritableFieldsForType(type);
		const clonedInstance:* = new (type.clazz)();

		for each(var field:Field in fieldsToClone) {
			PropertyUtil.cloneProperty(source, clonedInstance, field.name);
		}

		return clonedInstance;
	}

	public static function clone(source:*):* {
		const type:Type = Type.forInstance(source);

		failIfTypeIsNotCloneable(type);

		const deep:int = 2;

		return doClone(source, deep, type);
	}
}
}
