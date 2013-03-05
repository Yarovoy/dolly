package dolly {

import dolly.core.dolly_internal;
import dolly.core.errors.CloningError;
import dolly.core.metadata.MetadataName;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.IMetadataContainer;
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

	dolly_internal static function getCloneableFieldsForType(type:Type):Vector.<Field> {
		const result:Vector.<Field> = new Vector.<Field>();

		var variable:Variable;
		var accessor:Accessor;

		const isClassCloneable:Boolean = isTypeCloneable(type);
		if (isClassCloneable) {
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
		} else {
			const metadataContainers:Array = type.getMetadataContainers(MetadataName.CLONEABLE);
			for each(var metadataContainer:IMetadataContainer in metadataContainers) {
				if (metadataContainer is Variable) {
					variable = metadataContainer as Variable;
					if (isVariableCloneable(variable, false)) {
						result.push(variable);
					}
				} else if (metadataContainer is Accessor) {
					accessor = metadataContainer as Accessor;
					if (isAccessorCloneable(accessor, false)) {
						result.push(accessor);
					}
				}
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
		const fieldsToClone:Vector.<Field> = getCloneableFieldsForType(type);
		var name:String;
		for each(var field:Field in fieldsToClone) {
			name = field.name;
			clone[name] = source[name];
		}

		return clone;
	}
}
}
