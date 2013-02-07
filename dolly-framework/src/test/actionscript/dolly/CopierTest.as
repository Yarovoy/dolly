package dolly {
import dolly.core.dolly_internal;
import dolly.data.ClassLevelCopyable;
import dolly.data.ClassLevelCopyableCloneable;
import dolly.data.PropertyLevelCopyable;
import dolly.data.PropertyLevelCopyableCloneable;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

use namespace dolly_internal;

public class CopierTest {

	private var classLevelCopyable:ClassLevelCopyable;
	private var classLevelCopyableType:Type;

	private var classLevelCopyableCloneable:ClassLevelCopyableCloneable;
	private var classLevelCopyableCloneableType:Type;

	private var propertyLevelCopyable:PropertyLevelCopyable;
	private var propertyLevelCopyableType:Type;

	private var propertyLevelCopyableCloneable:PropertyLevelCopyableCloneable;
	private var propertyLevelCopyableCloneableType:Type;

	[Before]
	public function before():void {
		classLevelCopyable = new ClassLevelCopyable();
		classLevelCopyable.property1 = "value 1";
		classLevelCopyable.property2 = "value 2";
		classLevelCopyable.property3 = "value 3";
		classLevelCopyable.writableField = "value 4";
		classLevelCopyableType = Type.forInstance(classLevelCopyable);

		classLevelCopyableCloneable = new ClassLevelCopyableCloneable();
		classLevelCopyableCloneable.property1 = "value 1";
		classLevelCopyableCloneable.property2 = "value 2";
		classLevelCopyableCloneable.property3 = "value 3";
		classLevelCopyableCloneable.writableField = "value 4";
		classLevelCopyableCloneableType = Type.forInstance(classLevelCopyableCloneable);

		propertyLevelCopyable = new PropertyLevelCopyable();
		propertyLevelCopyable.property1 = "value 1";
		propertyLevelCopyable.property2 = "value 2";
		propertyLevelCopyable.property3 = "value 3";
		propertyLevelCopyable.writableField = "value 4";
		propertyLevelCopyableType = Type.forInstance(propertyLevelCopyable);

		propertyLevelCopyableCloneable = new PropertyLevelCopyableCloneable();
		propertyLevelCopyableCloneable.property1 = "value 1";
		propertyLevelCopyableCloneable.property2 = "value 2";
		propertyLevelCopyableCloneable.property3 = "value 3";
		propertyLevelCopyableCloneable.writableField = "value 4";
		propertyLevelCopyableCloneableType = Type.forInstance(propertyLevelCopyableCloneable);
	}

	[After]
	public function after():void {
		classLevelCopyable = null;
		classLevelCopyableType = null;

		classLevelCopyableCloneable = null;
		classLevelCopyableCloneableType = null;

		propertyLevelCopyable = null;
		propertyLevelCopyableType = null;

		propertyLevelCopyableCloneable = null;
		propertyLevelCopyableCloneableType = null;
	}

	[Test]
	public function testGetCopyableFieldsForTypeClassLevelCopyable():void {
		const copyableFields:Vector.<Field> = Copier.getCopyableFieldsForType(classLevelCopyableType);
		assertNotNull(copyableFields);
		assertEquals(4, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
		assertNotNull(copyableFields[3]);
	}

	[Test]
	public function testGetCopyableFieldsForTypeClassLevelCopyableCloneable():void {
		const copyableFields:Vector.<Field> = Copier.getCopyableFieldsForType(classLevelCopyableCloneableType);
		assertNotNull(copyableFields);
		assertEquals(4, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
		assertNotNull(copyableFields[3]);
	}

	[Test]
	public function testGetCopyableFieldsForTypePropertyLevelCopyable():void {
		const copyableFields:Vector.<Field> = Copier.getCopyableFieldsForType(propertyLevelCopyableType);
		assertNotNull(copyableFields);
		assertEquals(3, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
	}

	[Test]
	public function testGetCopyableFieldsForTypePropertyLevelCopyableCloneable():void {
		const copyableFields:Vector.<Field> = Copier.getCopyableFieldsForType(propertyLevelCopyableCloneableType);
		assertNotNull(copyableFields);
		assertEquals(3, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
	}

	[Test]
	public function testCopyClassLevelCopyable():void {
		const copy:ClassLevelCopyable = Copier.copy(classLevelCopyable);
		assertNotNull(copy);
		assertNotNull(copy.property1);
		assertEquals(copy.property1, classLevelCopyable.property1);
		assertNotNull(copy.property2);
		assertEquals(copy.property2, classLevelCopyable.property2);
		assertNotNull(copy.property3);
		assertEquals(copy.property3, classLevelCopyable.property3);
		assertNotNull(copy.writableField);
		assertEquals(copy.writableField, classLevelCopyable.writableField);
	}

	[Test]
	public function testCopyClassLevelCopyableCloneable():void {
		const copy:ClassLevelCopyableCloneable = Copier.copy(classLevelCopyableCloneable);
		assertNotNull(copy);
		assertNotNull(copy.property1);
		assertEquals(copy.property1, classLevelCopyable.property1);
		assertNotNull(copy.property2);
		assertEquals(copy.property2, classLevelCopyable.property2);
		assertNotNull(copy.property3);
		assertEquals(copy.property3, classLevelCopyable.property3);
		assertNotNull(copy.writableField);
		assertEquals(copy.writableField, classLevelCopyable.writableField);
	}

	[Test]
	public function testCopyPropertyLevelCopyable():void {
		const copy:PropertyLevelCopyable = Copier.copy(propertyLevelCopyable);
		assertNotNull(copy);
		assertNull(copy.property1);
		assertNotNull(copy.property2);
		assertEquals(copy.property2, classLevelCopyable.property2);
		assertNotNull(copy.property3);
		assertEquals(copy.property3, classLevelCopyable.property3);
		assertNotNull(copy.writableField);
		assertEquals(copy.writableField, classLevelCopyable.writableField);
	}

	[Test]
	public function testCopyPropertyLevelCopyableCloneable():void {
		const copy:PropertyLevelCopyableCloneable = Copier.copy(propertyLevelCopyableCloneable);
		assertNotNull(copy);
		assertNull(copy.property1);
		assertNotNull(copy.property2);
		assertEquals(copy.property2, classLevelCopyable.property2);
		assertNotNull(copy.property3);
		assertEquals(copy.property3, classLevelCopyable.property3);
		assertNotNull(copy.writableField);
		assertEquals(copy.writableField, classLevelCopyable.writableField);
	}
}
}
