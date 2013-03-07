package dolly {
import dolly.core.dolly_internal;
import dolly.data.PropertyLevelCopyableClass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CopyingOfPropertyLevelCopyableClassTest {

	private var propertyLevelCopyableClass:PropertyLevelCopyableClass;
	private var propertyLevelCopyableClassType:Type;

	[Before]
	public function before():void {
		propertyLevelCopyableClass = new PropertyLevelCopyableClass();
		propertyLevelCopyableClass.property1 = "property1 value";
		propertyLevelCopyableClass.property2 = "property2 value";
		propertyLevelCopyableClass.writableField1 = "writableField1 value";

		propertyLevelCopyableClassType = Type.forInstance(propertyLevelCopyableClass);
	}

	[After]
	public function after():void {
		propertyLevelCopyableClass = null;
		propertyLevelCopyableClassType = null;
	}

	[Test]
	public function findingAllCopyableFieldsForType():void {
		const copyableFields:Vector.<Field> = Copier.findCopyableFieldsForType(propertyLevelCopyableClassType);
		assertNotNull(copyableFields);
		assertEquals(2, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
	}

	[Test]
	public function copyingByCopier():void {
		const copyInstance:PropertyLevelCopyableClass = Copier.copy(propertyLevelCopyableClass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, propertyLevelCopyableClass.property1);
		assertNotNull(copyInstance.property2);
		assertFalse(copyInstance.property2 == propertyLevelCopyableClass.property2);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, propertyLevelCopyableClass.writableField1);
	}

	[Test]
	public function copyingByCopyFunction():void {
		const copyInstance:PropertyLevelCopyableClass = copy(propertyLevelCopyableClass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, propertyLevelCopyableClass.property1);
		assertNotNull(copyInstance.property2);
		assertFalse(copyInstance.property2 == propertyLevelCopyableClass.property2);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, propertyLevelCopyableClass.writableField1);
	}
}
}
