package dolly {
import dolly.core.dolly_internal;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CopierTest {

	private var copyableClass:ClassMarkedAsCopyable;
	private var copyableClassType:Type;

	private var classWithCopyableFields:ClassWithSomeCopyableFields;
	private var classWithCopyableFieldsType:Type;

	[Before]
	public function before():void {
		copyableClass = new ClassMarkedAsCopyable();
		copyableClass.property1 = "value 1";
		copyableClass.property2 = "value 2";
		copyableClass.property3 = "value 3";
		copyableClass.writableField = "value 4";

		classWithCopyableFields = new ClassWithSomeCopyableFields();
		classWithCopyableFields.property1 = "value 1";
		classWithCopyableFields.property2 = "value 2";
		classWithCopyableFields.property3 = "value 3";
		classWithCopyableFields.writableField = "value 4";

		copyableClassType = Type.forInstance(copyableClass);
		classWithCopyableFieldsType = Type.forInstance(classWithCopyableFields);
	}

	[After]
	public function after():void {
		copyableClass = null;
		copyableClassType = null;

		classWithCopyableFields = null;
		classWithCopyableFieldsType = null;
	}

	[Test]
	public function testGetCopyableFieldsForType():void {
		var copyableFields:Vector.<Field> = Copier.getCopyableFieldsForType(copyableClassType);

		assertNotNull(copyableFields);
		assertEquals(4, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
		assertNotNull(copyableFields[3]);

		copyableFields = Copier.getCopyableFieldsForType(classWithCopyableFieldsType);

		assertNotNull(copyableFields);
		assertEquals(3, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
	}
}
}
