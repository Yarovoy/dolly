package dolly {

import dolly.core.dolly_internal;
import dolly.core.errors.CloningError;
import dolly.core.metadata.MetadataName;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.AccessorAccess;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;

use namespace dolly_internal;

public class Cloner {

	private static function isTypeCloneable(type:Type):Boolean {
		return type.hasMetadata(MetadataName.CLONEABLE);
	}

	dolly_internal static function findAllWritableFieldsForType(type:Type):Vector.<Field> {
		const result:Vector.<Field> = new Vector.<Field>();

		for each(var field:Field in type.fields) {
			if (field.isStatic) {
				continue;
			}

			if (!(field is Accessor) || (field as Accessor).access == AccessorAccess.READ_WRITE) {
				result.push(field);
			}
		}

		return result;
	}

	public static function clone(source:*):* {
		const type:Type = Type.forInstance(source);

		if (!isTypeCloneable(type)) {
			throw new CloningError(
					CloningError.CLASS_IS_NOT_CLONEABLE_MESSAGE,
					CloningError.CLASS_IS_NOT_CLONEABLE_CODE
			);
		}

		const clone:* = new (type.clazz)();

		// Find all public writable fields in a hierarchy of a source object
		// and assign their values to a clone object.
		const fieldsToClone:Vector.<Field> = findAllWritableFieldsForType(type);
		var name:String;
		for each(var field:Field in fieldsToClone) {
			name = field.name;
			clone[name] = source[name];
		}

		return clone;
	}
}
}
