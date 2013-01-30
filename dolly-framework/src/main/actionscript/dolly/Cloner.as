package dolly {

import dolly.core.dolly_internal;
import dolly.core.metadata.MetadataName;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.IMetadataContainer;
import org.as3commons.reflect.Type;
import org.as3commons.reflect.Variable;

public class Cloner {

	dolly_internal static function getCloneableFields(source:*):Array {
		const result:Array = [];

		const type:Type = Type.forInstance(source);
		var variable:Variable;
		var accessor:Accessor;

		const isClassCloneable:Boolean = type.hasMetadata(MetadataName.CLONEABLE);

		if (isClassCloneable) {
			for each(variable in type.variables) {
				result.push(variable);
			}
			for each(accessor in type.accessors) {
				if (accessor.isReadable() && accessor.isWriteable() && !accessor.isStatic) {
					result.push(accessor);
				}
			}
		} else {
			const metadataContainers:Array = type.getMetadataContainers(MetadataName.CLONEABLE);
			for each(var metadataContainer:IMetadataContainer in metadataContainers) {
				if (metadataContainer is Variable) {
					variable = metadataContainer as Variable;
					if (variable.hasMetadata(MetadataName.CLONEABLE)) {
						result.push(variable);
					}
				} else if (metadataContainer is Accessor) {
					accessor = metadataContainer as Accessor;
					if (accessor.hasMetadata(MetadataName.CLONEABLE)
							&& accessor.isReadable() && accessor.isWriteable() && !accessor.isStatic) {
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