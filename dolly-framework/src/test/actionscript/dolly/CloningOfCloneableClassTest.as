package dolly {

import dolly.core.dolly_internal;
import dolly.data.CloneableClass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CloningOfCloneableClassTest {

	private var cloneableClass:CloneableClass;
	private var cloneableClassType:Type;

	[Before]
	public function before():void {
		cloneableClass = new CloneableClass();
		cloneableClass.property1 = "property1 value";
		cloneableClass.writableField1 = "writableField1 value";
		cloneableClassType = Type.forInstance(cloneableClass);
	}

	[After]
	public function after():void {
		cloneableClass = null;
		cloneableClassType = null;
	}

	[Test]
	public function findingAllWritableFieldsForType():void {
		const writableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(cloneableClassType);
		assertNotNull(writableFields);
		assertEquals(2, writableFields.length);
	}

	[Test]
	public function cloningByCloner():void {
		const clone:CloneableClass = Cloner.clone(cloneableClass);

		assertNotNull(clone);
		assertNotNull(clone.property1);
		assertEquals(clone.property1, cloneableClass.property1);
		assertNotNull(clone.writableField1);
		assertEquals(clone.writableField1, cloneableClass.writableField1);
	}

	[Test]
	public function cloningByCloneFunction():void {
		const classLevelClone:CloneableClass = clone(cloneableClass);

		assertNotNull(classLevelClone);
		assertNotNull(classLevelClone.property1);
		assertEquals(classLevelClone.property1, cloneableClass.property1);
		assertNotNull(classLevelClone.writableField1);
		assertEquals(classLevelClone.writableField1, cloneableClass.writableField1);
	}
}
}
