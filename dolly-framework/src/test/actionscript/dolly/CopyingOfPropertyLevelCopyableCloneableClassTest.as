package dolly {
import dolly.core.dolly_internal;
import dolly.data.PropertyLevelCopyableCloneableClass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CopyingOfPropertyLevelCopyableCloneableClassTest {

	private var propertyLevelCopyableCloneableClass:PropertyLevelCopyableCloneableClass;
	private var propertyLevelCopyableCloneableClassType:Type;

	[Before]
	public function before():void {
		propertyLevelCopyableCloneableClass = new PropertyLevelCopyableCloneableClass();
		propertyLevelCopyableCloneableClass.property1 = "property1 value";
		propertyLevelCopyableCloneableClass.property2 = "property2 value";
		propertyLevelCopyableCloneableClass.writableField1 = "writableField1 value";

		propertyLevelCopyableCloneableClassType = Type.forInstance(propertyLevelCopyableCloneableClass);
	}

	[After]
	public function after():void {
		propertyLevelCopyableCloneableClass = null;
		propertyLevelCopyableCloneableClassType = null;
	}

	[Test]
	public function findingAllCopyableFieldsForType():void {
		const copyableFields:Vector.<Field> = Copier.findCopyableFieldsForType(propertyLevelCopyableCloneableClassType);
		assertNotNull(copyableFields);
		assertEquals(2, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
	}

	[Test]
	public function copyingByCopier():void {
		const copyInstance:PropertyLevelCopyableCloneableClass = Copier.copy(propertyLevelCopyableCloneableClass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, propertyLevelCopyableCloneableClass.property1);
		assertNotNull(copyInstance.property2);
		assertFalse(copyInstance.property2 == propertyLevelCopyableCloneableClass.property2);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, propertyLevelCopyableCloneableClass.writableField1);
	}

	[Test]
	public function copyingByCopyFunction():void {
		const copyInstance:PropertyLevelCopyableCloneableClass = copy(propertyLevelCopyableCloneableClass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, propertyLevelCopyableCloneableClass.property1);
		assertNotNull(copyInstance.property2);
		assertFalse(copyInstance.property2 == propertyLevelCopyableCloneableClass.property2);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, propertyLevelCopyableCloneableClass.writableField1);
	}
}
}
