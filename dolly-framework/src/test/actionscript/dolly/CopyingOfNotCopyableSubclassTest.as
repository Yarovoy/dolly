package dolly {

import dolly.core.dolly_internal;
import dolly.data.NotCopyableSubclass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CopyingOfNotCopyableSubclassTest {

	private var notCopyableSubclass:NotCopyableSubclass;
	private var notCopyableSubclassType:Type;

	[Before]
	public function before():void {
		notCopyableSubclass = new NotCopyableSubclass();
		notCopyableSubclass.property1 = "property1 value";
		notCopyableSubclass.property2 = "property2 value";
		notCopyableSubclass.writableField1 = "writableField1 value";
		notCopyableSubclass.writableField2 = "writableField2 value";

		notCopyableSubclassType = Type.forInstance(notCopyableSubclass);
	}

	[After]
	public function after():void {
		notCopyableSubclass = null;
		notCopyableSubclassType = null;
	}

	[Test]
	public function findingAllCopyableFieldsForType():void {
		const copyableFields:Vector.<Field> = Copier.findCopyableFieldsForType(notCopyableSubclassType);
		assertNotNull(copyableFields);
		assertEquals(2, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
	}

	[Test]
	public function copyingByCopier():void {
		const copyInstance:NotCopyableSubclass = Copier.copy(notCopyableSubclass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, notCopyableSubclass.property1);
		assertNotNull(copyInstance.property2);
		assertFalse(copyInstance.property2 == notCopyableSubclass.property2);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, notCopyableSubclass.writableField1);
		assertNotNull(copyInstance.writableField2);
		assertFalse(copyInstance.writableField2 == notCopyableSubclass.writableField2);
	}

	[Test]
	public function copyingByCopyFunction():void {
		const copyInstance:NotCopyableSubclass = copy(notCopyableSubclass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, notCopyableSubclass.property1);
		assertNotNull(copyInstance.property2);
		assertFalse(copyInstance.property2 == notCopyableSubclass.property2);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, notCopyableSubclass.writableField1);
		assertNotNull(copyInstance.writableField2);
		assertFalse(copyInstance.writableField2 == notCopyableSubclass.writableField2);
	}
}
}
