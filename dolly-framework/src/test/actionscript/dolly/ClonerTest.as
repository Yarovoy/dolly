package dolly {

import dolly.core.dolly_internal;
import dolly.data.CloneableClass;
import dolly.data.CloneableSubclass;
import dolly.data.ClassLevelCopyableCloneable;
import dolly.data.PropertyLevelCloneable;
import dolly.data.PropertyLevelCopyableCloneable;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class ClonerTest {

	private var cloneableClass:CloneableClass;
	private var cloneableClassType:Type;

	private var cloneableSubclass:CloneableSubclass;
	private var cloneableSubclassType:Type;

	private var classLevelCopyableCloneable:ClassLevelCopyableCloneable;
	private var classLevelCopyableCloneableType:Type;

	private var propertyLevelCloneable:PropertyLevelCloneable;
	private var propertyLevelCloneableType:Type;

	private var propertyLevelCopyableCloneable:PropertyLevelCopyableCloneable;
	private var propertyLevelCopyableCloneableType:Type;

	[Before]
	public function before():void {
		cloneableClass = new CloneableClass();
		cloneableClass.property1 = "value 1";
		cloneableClass.property2 = "value 2";
		cloneableClass.property3 = "value 3";
		cloneableClass.writableField = "value 4";
		cloneableClassType = Type.forInstance(cloneableClass);

		classLevelCopyableCloneable = new ClassLevelCopyableCloneable();
		classLevelCopyableCloneable.property1 = "value 1";
		classLevelCopyableCloneable.property2 = "value 2";
		classLevelCopyableCloneable.property3 = "value 3";
		classLevelCopyableCloneable.writableField = "value 4";
		classLevelCopyableCloneableType = Type.forInstance(classLevelCopyableCloneable);

		cloneableSubclass = new CloneableSubclass();
		cloneableSubclass.property1 = "value 1";
		cloneableSubclass.property2 = "value 2";
		cloneableSubclass.property3 = "value 3";
		cloneableSubclass.property4 = "value 4";
		cloneableSubclass.property5 = "value 5";
		cloneableSubclass.writableField = "value 6";
		cloneableSubclass.writableField2 = "value 7";
		cloneableSubclassType = Type.forInstance(cloneableSubclass);

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
		cloneableClass = null;
		cloneableClassType = null;

		classLevelCopyableCloneable = null;
		classLevelCopyableCloneableType = null;

		cloneableSubclass = null;
		cloneableSubclassType = null;

		propertyLevelCloneable = null;
		propertyLevelCloneableType = null;

		propertyLevelCopyableCloneable = null;
		propertyLevelCopyableCloneableType = null;
	}

	[Test]
	public function testFindAllWritableFieldsForTypeClassLevelCloneable():void {
		const cloneableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(cloneableClassType);
		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);
	}

	[Test]
	public function testFindAllWritableFieldsForTypeClassLevelCloneableSubclass():void {
		const cloneableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(cloneableSubclassType);
		assertNotNull(cloneableFields);
		assertEquals(7, cloneableFields.length);
	}

	[Test]
	public function testFindAllWritableFieldsForTypeClassLevelCopyableCloneable():void {
		const cloneableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(classLevelCopyableCloneableType);
		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);
	}

	[Test]
	public function testFindAllWritableFieldsForTypePropertyLevelCloneable():void {
		const cloneableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(propertyLevelCloneableType);
		assertNotNull(cloneableFields);
		assertEquals(3, cloneableFields.length);
	}

	[Test]
	public function testFindAllWritableFieldsForTypePropertyLevelCopyableCloneable():void {
		const cloneableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(propertyLevelCopyableCloneableType);
		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);
	}

	[Test]
	public function testCloneClassLevelCloneable():void {
		const clone:CloneableClass = Cloner.clone(cloneableClass);
		assertNotNull(clone);
		assertNotNull(clone.property1);
		assertEquals(clone.property1, cloneableClass.property1);
		assertNotNull(clone.property2);
		assertEquals(clone.property2, cloneableClass.property2);
		assertNotNull(clone.property3);
		assertEquals(clone.property3, cloneableClass.property3);
		assertNotNull(clone.writableField);
		assertEquals(clone.writableField, cloneableClass.writableField);
	}

	[Test]
	public function testCloneClassLevelCloneableSubclass():void {
		const clone:CloneableSubclass = Cloner.clone(cloneableSubclass);
		assertNotNull(clone);
		assertNotNull(clone.property1);
		assertEquals(clone.property1, cloneableSubclass.property1);
		assertNotNull(clone.property2);
		assertEquals(clone.property2, cloneableSubclass.property2);
		assertNotNull(clone.property3);
		assertEquals(clone.property3, cloneableSubclass.property3);
		assertNotNull(clone.property4);
		assertEquals(clone.property4, cloneableSubclass.property4);
		assertNotNull(clone.property5);
		assertEquals(clone.property5, cloneableSubclass.property5);
		assertNotNull(clone.writableField);
		assertEquals(clone.writableField, cloneableSubclass.writableField);
		assertNotNull(clone.writableField2);
		assertEquals(clone.writableField2, cloneableSubclass.writableField2);
	}

	[Test]
	public function testCloneClassLevelCopyableCloneable():void {
		const clone:ClassLevelCopyableCloneable = Cloner.clone(classLevelCopyableCloneable);
		assertNotNull(clone);
		assertNotNull(clone.property1);
		assertEquals(clone.property1, cloneableClass.property1);
		assertNotNull(clone.property2);
		assertEquals(clone.property2, cloneableClass.property2);
		assertNotNull(clone.property3);
		assertEquals(clone.property3, cloneableClass.property3);
		assertNotNull(clone.writableField);
		assertEquals(clone.writableField, cloneableClass.writableField);
	}

	/**
	 * <code>Cloner.clone()</code> method will throw <code>CloningError</code> in this case
	 * because <code>PropertyLevelCloneable</code> class is not cloneable indeed.
	 */
	[Test(expects="dolly.core.errors.CloningError")]
	public function testClonePropertyLevelCloneable():void {
		Cloner.clone(propertyLevelCloneable);
	}

	/**
	 * <code>Cloner.clone()</code> method will throw <code>CloningError</code> in this case
	 * because <code>PropertyLevelCopyableCloneable</code> class is not cloneable indeed.
	 */
	[Test(expects="dolly.core.errors.CloningError")]
	public function testClonePropertyLevelCopyableCloneable():void {
		Cloner.clone(propertyLevelCopyableCloneable);
	}
}
}
