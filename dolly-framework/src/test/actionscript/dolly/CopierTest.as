package dolly {

import dolly.core.dolly_internal;
import dolly.data.PropertyLevelCopyableClass;
import dolly.data.PropertyLevelCopyableCloneableClass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

use namespace dolly_internal;

public class CopierTest {
	private var propertyLevelCopyable:PropertyLevelCopyableClass;
	private var propertyLevelCopyableType:Type;

	private var propertyLevelCopyableCloneable:PropertyLevelCopyableCloneableClass;
	private var propertyLevelCopyableCloneableType:Type;

	[Before]
	public function before():void {
		propertyLevelCopyable = new PropertyLevelCopyableClass();
		propertyLevelCopyable.property1 = "value 1";
		propertyLevelCopyable.property2 = "value 2";
		propertyLevelCopyable.writableField1 = "value 4";
		propertyLevelCopyableType = Type.forInstance(propertyLevelCopyable);

		propertyLevelCopyableCloneable = new PropertyLevelCopyableCloneableClass();
		propertyLevelCopyableCloneable.property1 = "value 1";
		propertyLevelCopyableCloneable.writableField1 = "value 4";
		propertyLevelCopyableCloneableType = Type.forInstance(propertyLevelCopyableCloneable);
	}

	[After]
	public function after():void {
		propertyLevelCopyable = null;
		propertyLevelCopyableType = null;

		propertyLevelCopyableCloneable = null;
		propertyLevelCopyableCloneableType = null;
	}


	[Test]
	public function testGetCopyableFieldsForTypePropertyLevelCopyable():void {
		const copyableFields:Vector.<Field> = Copier.findCopyableFieldsForType(propertyLevelCopyableType);
		assertNotNull(copyableFields);
		assertEquals(3, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
	}

	[Test]
	public function testGetCopyableFieldsForTypePropertyLevelCopyableCloneable():void {
		const copyableFields:Vector.<Field> = Copier.findCopyableFieldsForType(propertyLevelCopyableCloneableType);
		assertNotNull(copyableFields);
		assertEquals(3, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
	}

	[Test]
	public function testCopyPropertyLevelCopyable():void {
		const copy:PropertyLevelCopyableClass = Copier.copy(propertyLevelCopyable);
		assertNotNull(copy);
		assertNull(copy.property1);
		assertNotNull(copy.writableField1);
	}

	[Test]
	public function testCopyPropertyLevelCopyableCloneable():void {
		const copy:PropertyLevelCopyableCloneableClass = Copier.copy(propertyLevelCopyableCloneable);
		assertNotNull(copy);
		assertNull(copy.property1);
		assertNotNull(copy.writableField1);
	}
}
}
