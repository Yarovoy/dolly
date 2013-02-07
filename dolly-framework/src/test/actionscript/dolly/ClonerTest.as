package dolly {
import dolly.core.dolly_internal;
import dolly.data.ClassLevelCloneable;
import dolly.data.ClassLevelCopyableCloneable;
import dolly.data.PropertyLevelCloneable;
import dolly.data.PropertyLevelCopyableCloneable;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

use namespace dolly_internal;

public class ClonerTest {

	private var classLevelCloneable:ClassLevelCloneable;
	private var classLevelCloneableType:Type;

	private var classLevelCopyableCloneable:ClassLevelCopyableCloneable;
	private var classLevelCopyableCloneableType:Type;

	private var propertyLevelCloneable:PropertyLevelCloneable;
	private var propertyLevelCloneableType:Type;

	private var propertyLevelCopyableCloneable:PropertyLevelCopyableCloneable;
	private var propertyLevelCopyableCloneableType:Type;

	[Before]
	public function before():void {
		classLevelCloneable = new ClassLevelCloneable();
		classLevelCloneable.property1 = "value 1";
		classLevelCloneable.property2 = "value 2";
		classLevelCloneable.property3 = "value 3";
		classLevelCloneable.writableField = "value 4";
		classLevelCloneableType = Type.forInstance(classLevelCloneable);

		classLevelCopyableCloneable = new ClassLevelCopyableCloneable();
		classLevelCopyableCloneable.property1 = "value 1";
		classLevelCopyableCloneable.property2 = "value 2";
		classLevelCopyableCloneable.property3 = "value 3";
		classLevelCopyableCloneable.writableField = "value 4";
		classLevelCopyableCloneableType = Type.forInstance(classLevelCopyableCloneable);

		propertyLevelCloneable = new PropertyLevelCloneable();
		propertyLevelCloneable.property1 = "value 1";
		propertyLevelCloneable.property2 = "value 2";
		propertyLevelCloneable.property3 = "value 3";
		propertyLevelCloneable.writableField = "value 4";
		propertyLevelCloneableType = Type.forInstance(propertyLevelCloneable);

		propertyLevelCopyableCloneable = new PropertyLevelCopyableCloneable();
		propertyLevelCopyableCloneable.property1 = "value 1";
		propertyLevelCopyableCloneable.property2 = "value 2";
		propertyLevelCopyableCloneable.property3 = "value 3";
		propertyLevelCopyableCloneable.writableField = "value 4";
		propertyLevelCopyableCloneableType = Type.forInstance(propertyLevelCopyableCloneable);
	}

	[After]
	public function after():void {
		classLevelCloneable = null;
		classLevelCloneableType = null;

		classLevelCopyableCloneable = null;
		classLevelCopyableCloneableType = null;

		propertyLevelCloneable = null;
		propertyLevelCloneableType = null;

		propertyLevelCopyableCloneable = null;
		propertyLevelCopyableCloneableType = null;
	}

	[Test]
	public function testGetCloneableFieldsForTypeClassLevelCloneable():void {
		const cloneableFields:Vector.<Field> = Cloner.getCloneableFieldsForType(classLevelCloneableType);
		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);
	}

	[Test]
	public function testGetCloneableFieldsForTypeClassLevelCopyableCloneable():void {
		const cloneableFields:Vector.<Field> = Cloner.getCloneableFieldsForType(classLevelCopyableCloneableType);
		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);
	}

	[Test]
	public function testGetCloneableFieldsForTypePropertyLevelCloneable():void {
		const cloneableFields:Vector.<Field> = Cloner.getCloneableFieldsForType(propertyLevelCloneableType);
		assertNotNull(cloneableFields);
		assertEquals(3, cloneableFields.length);
	}

	[Test]
	public function testGetCloneableFieldsForTypePropertyLevelCopyableCloneable():void {
		const cloneableFields:Vector.<Field> = Cloner.getCloneableFieldsForType(propertyLevelCopyableCloneableType);
		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);
	}

	[Test]
	public function testCloneClassLevelCloneable():void {
		const clone:ClassLevelCloneable = Cloner.clone(classLevelCloneable);
		assertNotNull(clone);
		assertNotNull(clone.property1);
		assertEquals(clone.property1, classLevelCloneable.property1);
		assertNotNull(clone.property2);
		assertEquals(clone.property2, classLevelCloneable.property2);
		assertNotNull(clone.property3);
		assertEquals(clone.property3, classLevelCloneable.property3);
		assertNotNull(clone.writableField);
		assertEquals(clone.writableField, classLevelCloneable.writableField);
	}

	[Test]
	public function testCloneClassLevelCopyableCloneable():void {
		const clone:ClassLevelCopyableCloneable = Cloner.clone(classLevelCopyableCloneable);
		assertNotNull(clone);
		assertNotNull(clone.property1);
		assertEquals(clone.property1, classLevelCloneable.property1);
		assertNotNull(clone.property2);
		assertEquals(clone.property2, classLevelCloneable.property2);
		assertNotNull(clone.property3);
		assertEquals(clone.property3, classLevelCloneable.property3);
		assertNotNull(clone.writableField);
		assertEquals(clone.writableField, classLevelCloneable.writableField);
	}

	[Test]
	public function testCloneWithPropertyLevelMetadata():void {
		const clone1:PropertyLevelCloneable = Cloner.clone(propertyLevelCloneable);
		assertNotNull(clone1);
		assertNull(clone1.property1);
		assertNotNull(clone1.property2);
		assertEquals(clone1.property2, propertyLevelCloneable.property2);
		assertNotNull(clone1.property3);
		assertEquals(clone1.property3, propertyLevelCloneable.property3);
		assertNotNull(clone1.writableField);
		assertEquals(clone1.writableField, propertyLevelCloneable.writableField);

		const clone2:PropertyLevelCopyableCloneable = Cloner.clone(propertyLevelCopyableCloneable);
		assertNotNull(clone2);
		assertNotNull(clone2.property1);
		assertEquals(clone2.property1, propertyLevelCloneable.property1);
		assertNotNull(clone2.property2);
		assertEquals(clone2.property2, propertyLevelCloneable.property2);
		assertNotNull(clone2.property3);
		assertEquals(clone2.property3, propertyLevelCloneable.property3);
		assertNotNull(clone2.writableField);
		assertEquals(clone2.writableField, propertyLevelCloneable.writableField);
	}
}
}