package dolly {

import dolly.core.dolly_internal;
import dolly.data.CopyableCloneableClass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CloningOfCopyableCloneableClass {

	private var copyableCloneableClass:CopyableCloneableClass;
	private var copyableCloneableClassType:Type;

	[Before]
	public function before():void {
		copyableCloneableClass = new CopyableCloneableClass();
		copyableCloneableClass.property1 = "property1 value";
		copyableCloneableClass.writableField1 = "writableField1 value";
		copyableCloneableClassType = Type.forInstance(copyableCloneableClass);
	}

	[After]
	public function after():void {
		copyableCloneableClass = null;
		copyableCloneableClassType = null;
	}

	[Test]
	public function findingAllWritableFieldsForType():void {
		const writableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(copyableCloneableClassType);
		assertNotNull(writableFields);
		assertEquals(2, writableFields.length);
	}

	[Test]
	public function cloningByCloner():void {
		const clone:CopyableCloneableClass = Cloner.clone(copyableCloneableClass);

		assertNotNull(clone);
		assertNotNull(clone.property1);
		assertEquals(clone.property1, copyableCloneableClass.property1);
		assertNotNull(clone.writableField1);
		assertEquals(clone.writableField1, copyableCloneableClass.writableField1);
	}

	[Test]
	public function cloningByCloneFunction():void {
		const cloneInstance:CopyableCloneableClass = clone(copyableCloneableClass);

		assertNotNull(cloneInstance);
		assertNotNull(cloneInstance.property1);
		assertEquals(cloneInstance.property1, copyableCloneableClass.property1);
		assertNotNull(cloneInstance.writableField1);
		assertEquals(cloneInstance.writableField1, copyableCloneableClass.writableField1);
	}

}
}
