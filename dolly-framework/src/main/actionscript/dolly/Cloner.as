package dolly {

import dolly.core.dolly_internal;
import dolly.core.errors.CloningError;
import dolly.core.metadata.MetadataName;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.as3commons.reflect.Variable;

use namespace dolly_internal;

public class Cloner {

	private static function isTypeCloneable(type:Type):Boolean {
		return type.hasMetadata(MetadataName.CLONEABLE);
	}

	private static function isVariableCloneable(variable:Variable, skipMetadataChecking:Boolean = true):Boolean {
		return !variable.isStatic && (skipMetadataChecking || variable.hasMetadata(MetadataName.CLONEABLE));
	}

	private static function isAccessorCloneable(accessor:Accessor, skipMetadataChecking:Boolean = true):Boolean {
		return !accessor.isStatic && accessor.isReadable() && accessor.isWriteable() &&
				(skipMetadataChecking || accessor.hasMetadata(MetadataName.CLONEABLE));
	}

	dolly_internal static function getWritableFieldsOfType(type:Type):Vector.<Field> {
		const result:Vector.<Field> = new Vector.<Field>();

		var variable:Variable;
		var accessor:Accessor;

		for each(variable in type.variables) {
			if (isVariableCloneable(variable)) {
				result.push(variable);
			}
		}
		for each(accessor in type.accessors) {
			if (isAccessorCloneable(accessor)) {
				result.push(accessor);
			}
		}

		return result;
	}

	dolly_internal static function findAllCloneableFieldsForType(type:Type):Vector.<Field> {
		const result:Vector.<Field> = getWritableFieldsOfType(type);

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
		const fieldsToClone:Vector.<Field> = findAllCloneableFieldsForType(type);
		var name:String;
		for each(var field:Field in fieldsToClone) {
			name = field.name;
			clone[name] = source[name];
		}

		return clone;
	}
}
}
