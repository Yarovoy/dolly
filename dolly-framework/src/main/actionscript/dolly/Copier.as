package dolly {
import dolly.core.dolly_internal;
import dolly.core.metadata.MetadataName;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.IMetadataContainer;
import org.as3commons.reflect.Type;
import org.as3commons.reflect.Variable;

use namespace dolly_internal;

public class Copier {

	private static function isVariableCopyable(variable:Variable, skipMetadataChecking:Boolean = true):Boolean {
		return !variable.isStatic && (skipMetadataChecking || variable.hasMetadata(MetadataName.COPYABLE));
	}

	private static function isAccessorCopyable(accessor:Accessor, skipMetadataChecking:Boolean = true):Boolean {
		return !accessor.isStatic && accessor.isReadable() && accessor.isWriteable() &&
				(skipMetadataChecking || accessor.hasMetadata(MetadataName.COPYABLE));
	}

	dolly_internal static function getCopyableFieldsForType(type:Type):Vector.<Field> {
		const result:Vector.<Field> = new Vector.<Field>();

		var variable:Variable;
		var accessor:Accessor;

		const isClassCloneable:Boolean = type.hasMetadata(MetadataName.COPYABLE);
		if (isClassCloneable) {
			for each(variable in type.variables) {
				if (isVariableCopyable(variable)) {
					result.push(variable);
				}
			}
			for each(accessor in type.accessors) {
				if (isAccessorCopyable(accessor)) {
					result.push(accessor);
				}
			}
		} else {
			const metadataContainers:Array = type.getMetadataContainers(MetadataName.COPYABLE);
			for each(var metadataContainer:IMetadataContainer in metadataContainers) {
				if (metadataContainer is Variable) {
					variable = metadataContainer as Variable;
					if (isVariableCopyable(variable, false)) {
						result.push(variable);
					}
				} else if (metadataContainer is Accessor) {
					accessor = metadataContainer as Accessor;
					if (isAccessorCopyable(accessor, false)) {
						result.push(accessor);
					}
				}
			}
		}

		return result;
	}

	public static function copy(source:*):* {
		const type:Type = Type.forInstance(source);
		const copy:* = new (type.clazz)();

		const fieldsToCopy:Vector.<Field> = getCopyableFieldsForType(type);
		var name:String;
		for each(var field:Field in fieldsToCopy) {
			name = field.name;
			copy[name] = source[name];
		}

		return copy;
	}
}
}
