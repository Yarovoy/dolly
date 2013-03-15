package dolly {

import dolly.core.dolly_internal;
import dolly.core.errors.CloningError;
import dolly.core.metadata.MetadataName;
import dolly.utils.ClassUtil;

import flash.utils.ByteArray;
import flash.utils.Dictionary;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.AccessorAccess;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;

use namespace dolly_internal;

public class Cloner {

	private static var _isClassPreparedForCloningMap:Dictionary = new Dictionary();

	private static function isTypeCloneable(type:Type):Boolean {
		return type.hasMetadata(MetadataName.CLONEABLE);
	}

	private static function isTypePreparedForCloning(type:Type):Boolean {
		return _isClassPreparedForCloningMap[type.clazz];
	}

	private static function failIfTypeIsNotCloneable(type:Type):void {
		if (!isTypeCloneable(type)) {
			throw new CloningError(
					CloningError.CLASS_IS_NOT_CLONEABLE_MESSAGE,
					CloningError.CLASS_IS_NOT_CLONEABLE_CODE
			);
		}
	}

	private static function prepareTypeForCloning(type:Type):void {
		ClassUtil.registerAliasFor(type.clazz);

		_isClassPreparedForCloningMap[type.clazz] = true;
	}

	dolly_internal static function findAllWritableFieldsForType(type:Type):Vector.<Field> {
		failIfTypeIsNotCloneable(type);

		if (!isTypePreparedForCloning(type)) {
			prepareTypeForCloning(type);
		}

		const result:Vector.<Field> = new Vector.<Field>();

		for each(var field:Field in type.properties) {
			if (!(field is Accessor) || (field as Accessor).access == AccessorAccess.READ_WRITE) {
				result.push(field);
			}
		}

		return result;
	}

	dolly_internal static function doClone(source:*, type:Type = null):* {
		if (!type) {
			type = Type.forInstance(source);
		}

		if (!isTypePreparedForCloning(type)) {
			prepareTypeForCloning(type);
		}

		const fieldsToClone:Vector.<Field> = findAllWritableFieldsForType(type);

		for each(var field:Field in fieldsToClone) {
			var fieldType:Type = field.type;
			if (isTypeCloneable(fieldType) && !isTypePreparedForCloning(fieldType)) {
				prepareTypeForCloning(fieldType);
			}
		}

		const byteArray:ByteArray = new ByteArray();
		byteArray.writeObject(source);
		byteArray.position = 0;

		const clonedInstance:* = byteArray.readObject();

		return clonedInstance;
	}

	public static function clone(source:*):* {
		const type:Type = Type.forInstance(source);

		failIfTypeIsNotCloneable(type);

		return doClone(source, type);
	}
}
}
