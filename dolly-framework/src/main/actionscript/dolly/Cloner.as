package dolly {

import dolly.core.dolly_internal;
import dolly.core.metadata.MetadataName;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.IMetadataContainer;
import org.as3commons.reflect.Type;
import org.as3commons.reflect.Variable;

public class Cloner {

	private static function isVariableCloneable(variable:Variable, skipMetadataChecking:Boolean = true):Boolean {
		return !variable.isStatic && (skipMetadataChecking || variable.hasMetadata(MetadataName.CLONEABLE));
	}

	public static function isAccessorCloneable(accessor:Accessor, skipMetadataChecking:Boolean = true):Boolean {
		return !accessor.isStatic && accessor.isReadable() && accessor.isWriteable() &&
				(skipMetadataChecking || accessor.hasMetadata(MetadataName.CLONEABLE));
	}

	dolly_internal static function getCloneableFields(source:*):Array {
		const result:Array = [];

		const type:Type = Type.forInstance(source);
		var variable:Variable;
		var accessor:Accessor;

		const isClassCloneable:Boolean = type.hasMetadata(MetadataName.CLONEABLE);
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
		return null;
	}
}
}