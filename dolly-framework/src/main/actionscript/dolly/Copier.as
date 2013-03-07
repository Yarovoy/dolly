package dolly {

import dolly.core.dolly_internal;
import dolly.core.metadata.MetadataName;

import flash.utils.Dictionary;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.AccessorAccess;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.IMetadataContainer;
import org.as3commons.reflect.Type;
import org.as3commons.reflect.Variable;

use namespace dolly_internal;

public class Copier {

	private static function getCopyableFieldsOfType(type:Type, foundFields:Dictionary):Vector.<Field> {
		const result:Vector.<Field> = new Vector.<Field>();

		var variable:Variable;
		var accessor:Accessor;

		const isTypeCloneable:Boolean = type.hasMetadata(MetadataName.COPYABLE);
		if (isTypeCloneable) {
			for each(variable in type.variables) {
				if (!foundFields[variable.name] && !variable.isStatic) {
					foundFields[variable.name] = variable;
					result.push(variable);
				}
			}
			for each(accessor in type.accessors) {
				if (!foundFields[accessor.name]
						&& !accessor.isStatic
						&& accessor.access == AccessorAccess.READ_WRITE) {
					foundFields[accessor.name] = accessor;
					result.push(accessor);
				}
			}
		} else {
			const metadataContainers:Array = type.getMetadataContainers(MetadataName.COPYABLE);
			for each(var metadataContainer:IMetadataContainer in metadataContainers) {
				if (metadataContainer is Variable) {
					variable = metadataContainer as Variable;
					if (!foundFields[variable.name]
							&& !variable.isStatic
							&& variable.hasMetadata(MetadataName.COPYABLE)) {
						foundFields[variable.name] = variable;
						result.push(variable);
					}
				} else if (metadataContainer is Accessor) {
					accessor = metadataContainer as Accessor;
					if (!foundFields[accessor.name]
							&& !accessor.isStatic
							&& accessor.access == AccessorAccess.READ_WRITE
							&& accessor.hasMetadata(MetadataName.COPYABLE)) {
						foundFields[accessor.name] = accessor;
						result.push(accessor);
					}
				}
			}
		}

		return result;
	}

	dolly_internal static function findCopyableFieldsForType(type:Type):Vector.<Field> {
		var foundFields:Dictionary = new Dictionary();
		var result:Vector.<Field> = getCopyableFieldsOfType(type, foundFields);

		var superType:Type;
		var superTypeCopyableFields:Vector.<Field>;

		for each(var superTypeName:String in type.extendsClasses) {
			superType = Type.forName(superTypeName);
			superTypeCopyableFields = getCopyableFieldsOfType(superType, foundFields);
			if (superTypeCopyableFields.length > 0) {
				result = result.concat(superTypeCopyableFields);
			}
		}

		return result;
	}

	public static function copy(source:*):* {
		const type:Type = Type.forInstance(source);
		const copy:* = new (type.clazz)();

		const fieldsToCopy:Vector.<Field> = findCopyableFieldsForType(type);
		var name:String;
		for each(var field:Field in fieldsToCopy) {
			name = field.name;
			copy[name] = source[name];
		}

		return copy;
	}
}
}
