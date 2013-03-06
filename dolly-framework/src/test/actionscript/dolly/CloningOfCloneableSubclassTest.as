package dolly {

import dolly.core.dolly_internal;
import dolly.data.CloneableSubclass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CloningOfCloneableSubclassTest {

	private var cloneableSubclass:CloneableSubclass;
	private var cloneableSubclassType:Type;

	[Before]
	public function before():void {
		cloneableSubclass = new CloneableSubclass();
		cloneableSubclass.property1 = "property1 value";
		cloneableSubclass.property2 = "property2 value";
		cloneableSubclass.writableField1 = "writableField1 value";
		cloneableSubclass.writableField2 = "writableField2 value";
		cloneableSubclassType = Type.forInstance(cloneableSubclass);
	}

	[After]
	public function after():void {
		cloneableSubclass = null;
		cloneableSubclassType = null;
	}

	[Test]
	public function findingAllWritableFieldsForType():void {
		const cloneableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(cloneableSubclassType);
		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);
	}

	[Test]
	public function cloningByCloner():void {
		const clone:CloneableSubclass = Cloner.clone(cloneableSubclass);
		assertNotNull(clone);
		assertNotNull(clone.property1);
		assertEquals(clone.property1, cloneableSubclass.property1);
		assertNotNull(clone.property2);
		assertEquals(clone.property2, cloneableSubclass.property2);
		assertNotNull(clone.writableField1);
		assertEquals(clone.writableField1, cloneableSubclass.writableField1);
		assertNotNull(clone.writableField2);
		assertEquals(clone.writableField2, cloneableSubclass.writableField2);
	}

	[Test]
	public function cloningByCloneFunction():void {
		const cloneInstance:CloneableSubclass = clone(cloneableSubclass);
		assertNotNull(cloneInstance);
		assertNotNull(cloneInstance.property1);
		assertEquals(cloneInstance.property1, cloneableSubclass.property1);
		assertNotNull(cloneInstance.property2);
		assertEquals(cloneInstance.property2, cloneableSubclass.property2);
		assertNotNull(cloneInstance.writableField1);
		assertEquals(cloneInstance.writableField1, cloneableSubclass.writableField1);
		assertNotNull(cloneInstance.writableField2);
		assertEquals(cloneInstance.writableField2, cloneableSubclass.writableField2);
	}
}
}
