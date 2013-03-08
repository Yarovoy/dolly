package dolly {
import dolly.core.dolly_internal;
import dolly.data.PropertyLevelCopyableSubclass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CopyingOfPropertyLevelCopyableSubclassTest {

	private var propertyLevelCopyableSubclass:PropertyLevelCopyableSubclass;
	private var propertyLevelCopyableSubclassType:Type;

	[Before]
	public function before():void {
		propertyLevelCopyableSubclass = new PropertyLevelCopyableSubclass();
		propertyLevelCopyableSubclass.property1 = "property1 value";
		propertyLevelCopyableSubclass.property2 = "property2 value";
		propertyLevelCopyableSubclass.property3 = "property3 value";
		propertyLevelCopyableSubclass.property4 = "property4 value";
		propertyLevelCopyableSubclass.writableField1 = "writableField1 value";
		propertyLevelCopyableSubclass.writableField2 = "writableField2 value";

		propertyLevelCopyableSubclassType = Type.forInstance(propertyLevelCopyableSubclass);
	}

	[After]
	public function after():void {
		propertyLevelCopyableSubclass = null;
		propertyLevelCopyableSubclassType = null;
	}

	[Test]
	public function findingAllCopyableFieldsForType():void {
		const copyableFields:Vector.<Field> = Copier.findCopyableFieldsForType(propertyLevelCopyableSubclassType);
		assertNotNull(copyableFields);
		assertEquals(4, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
		assertNotNull(copyableFields[3]);
	}

	[Test]
	public function copyingByCopier():void {
		const copyInstance:PropertyLevelCopyableSubclass = Copier.copy(propertyLevelCopyableSubclass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, propertyLevelCopyableSubclass.property1);
		assertNotNull(copyInstance.property2);
		assertFalse(copyInstance.property2 == propertyLevelCopyableSubclass.property2);
		assertNotNull(copyInstance.property3);
		assertEquals(copyInstance.property3, propertyLevelCopyableSubclass.property3);
		assertNotNull(copyInstance.property4);
		assertFalse(copyInstance.property4 == propertyLevelCopyableSubclass.property4);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, propertyLevelCopyableSubclass.writableField1);
		assertNotNull(copyInstance.writableField2);
		assertEquals(copyInstance.writableField2, propertyLevelCopyableSubclass.writableField2);
	}

	[Test]
	public function copyingByCopyFunction():void {
		const copyInstance:PropertyLevelCopyableSubclass = copy(propertyLevelCopyableSubclass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, propertyLevelCopyableSubclass.property1);
		assertNotNull(copyInstance.property2);
		assertFalse(copyInstance.property2 == propertyLevelCopyableSubclass.property2);
		assertNotNull(copyInstance.property3);
		assertEquals(copyInstance.property3, propertyLevelCopyableSubclass.property3);
		assertNotNull(copyInstance.property4);
		assertFalse(copyInstance.property4 == propertyLevelCopyableSubclass.property4);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, propertyLevelCopyableSubclass.writableField1);
		assertNotNull(copyInstance.writableField2);
		assertEquals(copyInstance.writableField2, propertyLevelCopyableSubclass.writableField2);
	}
}
}
