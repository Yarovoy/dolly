package dolly {

import dolly.core.dolly_internal;
import dolly.data.CopyableClass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CopyingOfCopyableClassTest {

	private var copyableClass:CopyableClass;
	private var copyableClassType:Type;

	[Before]
	public function before():void {
		copyableClass = new CopyableClass();
		copyableClass.property1 = "property1 value";
		copyableClass.writableField1 = "writableField1 value";
		copyableClassType = Type.forInstance(copyableClass);
	}

	[After]
	public function after():void {
		copyableClass = null;
		copyableClassType = null;
	}

	[Test]
	public function findingAllCopyableFieldsForType():void {
		const copyableFields:Vector.<Field> = Copier.findCopyableFieldsForType(copyableClassType);
		assertNotNull(copyableFields);
		assertEquals(2, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
	}

	[Test]
	public function copyingByCopier():void {
		const copyInstance:CopyableClass = Copier.copy(copyableClass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, copyableClass.property1);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, copyableClass.writableField1);
	}

	[Test]
	public function copyingByCopyFunction():void {
		const copyInstance:CopyableClass = copy(copyableClass);
		assertNotNull(copyInstance);
		assertNotNull(copyInstance.property1);
		assertEquals(copyInstance.property1, copyableClass.property1);
		assertNotNull(copyInstance.writableField1);
		assertEquals(copyInstance.writableField1, copyableClass.writableField1);
	}
}
}
