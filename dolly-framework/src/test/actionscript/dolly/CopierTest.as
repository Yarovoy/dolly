package dolly {
import dolly.core.dolly_internal;
import dolly.data.CopyableClass;
import dolly.data.CopyableCloneableClass;
import dolly.data.ClassLevelCopyableSubclass;
import dolly.data.PropertyLevelCopyable;
import dolly.data.PropertyLevelCopyableCloneableClass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

use namespace dolly_internal;

public class CopierTest {

	private var classLevelCopyable:CopyableClass;
	private var classLevelCopyableType:Type;

	private var classLevelCopyableSubclass:ClassLevelCopyableSubclass;
	private var classLevelCopyableSubclassType:Type;

	private var classLevelCopyableCloneable:CopyableCloneableClass;
	private var classLevelCopyableCloneableType:Type;

	private var propertyLevelCopyable:PropertyLevelCopyable;
	private var propertyLevelCopyableType:Type;

	private var propertyLevelCopyableCloneable:PropertyLevelCopyableCloneableClass;
	private var propertyLevelCopyableCloneableType:Type;

	[Before]
	public function before():void {
		classLevelCopyable = new CopyableClass();
		classLevelCopyable.property1 = "value 1";
		classLevelCopyable.writableField1 = "value 4";
		classLevelCopyableType = Type.forInstance(classLevelCopyable);

		classLevelCopyableSubclass = new ClassLevelCopyableSubclass();
		classLevelCopyableSubclass.property1 = "value 1";
		classLevelCopyableSubclass.property4 = "value4";
		classLevelCopyableSubclass.property5 = "value 5";
		classLevelCopyableSubclass.writableField1 = "value 6";
		classLevelCopyableSubclass.writableField2 = "value 7";
		classLevelCopyableSubclassType = Type.forInstance(classLevelCopyableSubclass);

		classLevelCopyableCloneable = new CopyableCloneableClass();
		classLevelCopyableCloneable.property1 = "value 1";
		classLevelCopyableCloneable.writableField1 = "value 4";
		classLevelCopyableCloneableType = Type.forInstance(classLevelCopyableCloneable);

		propertyLevelCopyable = new PropertyLevelCopyable();
		propertyLevelCopyable.property1 = "value 1";
		propertyLevelCopyable.property2 = "value 2";
		propertyLevelCopyable.property3 = "value 3";
		propertyLevelCopyable.writableField = "value 4";
		propertyLevelCopyableType = Type.forInstance(propertyLevelCopyable);

		propertyLevelCopyableCloneable = new PropertyLevelCopyableCloneableClass();
		propertyLevelCopyableCloneable.property1 = "value 1";
		propertyLevelCopyableCloneable.writableField1 = "value 4";
		propertyLevelCopyableCloneableType = Type.forInstance(propertyLevelCopyableCloneable);
	}

	[After]
	public function after():void {
		classLevelCopyable = null;
		classLevelCopyableType = null;

		classLevelCopyableSubclass = null;
		classLevelCopyableSubclassType = null;

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
	public function testGetCopyableFieldsForTypeClassLevelCopyableSubclass():void {
		const copyableFields:Vector.<Field> = Copier.getCopyableFieldsForType(classLevelCopyableSubclassType);
		assertNotNull(copyableFields);
		assertEquals(7, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
		assertNotNull(copyableFields[3]);
		assertNotNull(copyableFields[4]);
		assertNotNull(copyableFields[5]);
		assertNotNull(copyableFields[6]);
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
		const copy:CopyableClass = Copier.copy(classLevelCopyable);
		assertNotNull(copy);
		assertNotNull(copy.property1);
		assertEquals(copy.property1, classLevelCopyable.property1);
		assertNotNull(copy.writableField1);
		assertEquals(copy.writableField1, classLevelCopyable.writableField1);
	}

	[Test]
	public function testCopyClassLevelCopyableSubclass():void {
		const copy:ClassLevelCopyableSubclass = Copier.copy(classLevelCopyableSubclass);
		assertNotNull(copy);
		assertNotNull(copy.property1);
		assertEquals(copy.property1, classLevelCopyableSubclass.property1);
		assertNotNull(copy.property4);
		assertEquals(copy.property4, classLevelCopyableSubclass.property4);
		assertNotNull(copy.property5);
		assertEquals(copy.property5, classLevelCopyableSubclass.property5);
		assertNotNull(copy.writableField1);
		assertEquals(copy.writableField1, classLevelCopyableSubclass.writableField1);
		assertNotNull(copy.writableField2);
		assertEquals(copy.writableField2, classLevelCopyableSubclass.writableField2);
	}

	[Test]
	public function testCopyClassLevelCopyableCloneable():void {
		const copy:CopyableCloneableClass = Copier.copy(classLevelCopyableCloneable);
		assertNotNull(copy);
		assertNotNull(copy.property1);
		assertEquals(copy.property1, classLevelCopyable.property1);
		assertNotNull(copy.writableField1);
		assertEquals(copy.writableField1, classLevelCopyable.writableField1);
	}

	[Test]
	public function testCopyPropertyLevelCopyable():void {
		const copy:PropertyLevelCopyable = Copier.copy(propertyLevelCopyable);
		assertNotNull(copy);
		assertNull(copy.property1);
		assertNotNull(copy.writableField);
		assertEquals(copy.writableField, classLevelCopyable.writableField1);
	}

	[Test]
	public function testCopyPropertyLevelCopyableCloneable():void {
		const copy:PropertyLevelCopyableCloneableClass = Copier.copy(propertyLevelCopyableCloneable);
		assertNotNull(copy);
		assertNull(copy.property1);
		assertNotNull(copy.writableField1);
		assertEquals(copy.writableField1, classLevelCopyable.writableField1);
	}
}
}
