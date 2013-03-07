package dolly {

import dolly.core.dolly_internal;
import dolly.data.CopyableSubclass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CopyingOfCopyableSubclassTest {

	private var copyableSubclass:CopyableSubclass;
	private var copyableSubclassType:Type;

	[Before]
	public function before():void {
		copyableSubclass = new CopyableSubclass();
		copyableSubclass.property1 = "property1 value";
		copyableSubclass.property2 = "property2 value";
		copyableSubclass.writableField1 = "writableField1 value";
		copyableSubclass.writableField2 = "writableField2 value 7";
		copyableSubclassType = Type.forInstance(copyableSubclass);
	}

	[After]
	public function after():void {
		copyableSubclass = null;
		copyableSubclassType = null;
	}

	[Test]
	public function findingAllCopyableFieldsForType():void {
		const copyableFields:Vector.<Field> = Copier.findCopyableFieldsForType(copyableSubclassType);
		assertNotNull(copyableFields);
		assertEquals(4, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
		assertNotNull(copyableFields[3]);
	}

	[Test]
	public function copyingByCopier():void {
		const copyInstance:CopyableSubclass = Copier.copy(copyableSubclass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, copyableSubclass.property1);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, copyableSubclass.writableField1);
		assertNotNull(copyInstance.writableField2);
		assertEquals(copyInstance.writableField2, copyableSubclass.writableField2);
	}

	[Test]
	public function copyingByCopyFunction():void {
		const copyInstance:CopyableSubclass = copy(copyableSubclass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, copyableSubclass.property1);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, copyableSubclass.writableField1);
		assertNotNull(copyInstance.writableField2);
		assertEquals(copyInstance.writableField2, copyableSubclass.writableField2);
	}

}
}
