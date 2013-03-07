package dolly {

import dolly.core.dolly_internal;
import dolly.core.metadata.MetadataName;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.AccessorAccess;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.IMetadataContainer;
import org.as3commons.reflect.Type;
import org.as3commons.reflect.Variable;

use namespace dolly_internal;

public class Copier {

	private static function getCopyableFieldsOfType(type:Type):Vector.<Field> {
		const result:Vector.<Field> = new Vector.<Field>();

		var variable:Variable;
		var accessor:Accessor;

		const isTypeCloneable:Boolean = type.hasMetadata(MetadataName.COPYABLE);
		if (isTypeCloneable) {
			for each(variable in type.variables) {
				if (!variable.isStatic) {
					result.push(variable);
				}
			}
			for each(accessor in type.accessors) {
				if (!accessor.isStatic && accessor.access == AccessorAccess.READ_WRITE) {
					result.push(accessor);
				}
			}
		} else {
			const metadataContainers:Array = type.getMetadataContainers(MetadataName.COPYABLE);
			for each(var metadataContainer:IMetadataContainer in metadataContainers) {
				if (metadataContainer is Variable) {
					variable = metadataContainer as Variable;
					if (!variable.isStatic && variable.hasMetadata(MetadataName.COPYABLE)) {
						result.push(variable);
					}
				} else if (metadataContainer is Accessor) {
					accessor = metadataContainer as Accessor;
					if (!accessor.isStatic
							&& accessor.access == AccessorAccess.READ_WRITE
							&& accessor.hasMetadata(MetadataName.COPYABLE)) {
						result.push(accessor);
					}
				}
			}
		}

		return result;
	}

	dolly_internal static function findCopyableFieldsForType(type:Type):Vector.<Field> {
		var result:Vector.<Field> = getCopyableFieldsOfType(type);

		var superType:Type;
		var superTypeCopyableFields:Vector.<Field>;

		for each(var superTypeName:String in type.extendsClasses) {
			superType = Type.forName(superTypeName);
			superTypeCopyableFields = getCopyableFieldsOfType(superType);
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
