package dolly {
import dolly.core.dolly_internal;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

use namespace dolly_internal;

public class CopierTest {

	private var classLevelCopyable:ClassLevelCopyable;
	private var classLevelCopyableType:Type;

	private var propertyLevelCopyable:PropertyLevelCopyable;
	private var propertyLevelCopyableType:Type;

	[Before]
	public function before():void {
		classLevelCopyable = new ClassLevelCopyable();
		classLevelCopyable.property1 = "value 1";
		classLevelCopyable.property2 = "value 2";
		classLevelCopyable.property3 = "value 3";
		classLevelCopyable.writableField = "value 4";

		propertyLevelCopyable = new PropertyLevelCopyable();
		propertyLevelCopyable.property1 = "value 1";
		propertyLevelCopyable.property2 = "value 2";
		propertyLevelCopyable.property3 = "value 3";
		propertyLevelCopyable.writableField = "value 4";

		classLevelCopyableType = Type.forInstance(classLevelCopyable);
		propertyLevelCopyableType = Type.forInstance(propertyLevelCopyable);
	}

	[After]
	public function after():void {
		classLevelCopyable = null;
		classLevelCopyableType = null;

		propertyLevelCopyable = null;
		propertyLevelCopyableType = null;
	}

	[Test]
	public function testGetCopyableFieldsForType():void {
		var copyableFields:Vector.<Field> = Copier.getCopyableFieldsForType(classLevelCopyableType);

		assertNotNull(copyableFields);
		assertEquals(4, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
		assertNotNull(copyableFields[3]);

		copyableFields = Copier.getCopyableFieldsForType(propertyLevelCopyableType);

		assertNotNull(copyableFields);
		assertEquals(3, copyableFields.length);
		assertNotNull(copyableFields[0]);
		assertNotNull(copyableFields[1]);
		assertNotNull(copyableFields[2]);
	}

	[Test]
	public function testCopyWithClassLevelMetadata():void {
		const copy:ClassLevelCopyable = Copier.copy(classLevelCopyable) as ClassLevelCopyable;

		assertNotNull(copy);
		assertNotNull(copy.property1);
		assertEquals(copy.property1, classLevelCopyable.property1);
		assertNotNull(copy.property2);
		assertEquals(copy.property2, classLevelCopyable.property2);
		assertNotNull(copy.property3);
		assertEquals(copy.property3, classLevelCopyable.property3);
		assertNotNull(copy.writableField);
		assertEquals(copy.writableField, classLevelCopyable.writableField);
	}

	[Test]
	public function testCopyWithPropertyLevelMetadata():void {
		const copy:PropertyLevelCopyable = Copier.copy(propertyLevelCopyable) as PropertyLevelCopyable;

		assertNotNull(copy);
		assertNull(copy.property1);
		assertNotNull(copy.property2);
		assertEquals(copy.property2, classLevelCopyable.property2);
		assertNotNull(copy.property3);
		assertEquals(copy.property3, classLevelCopyable.property3);
		assertNotNull(copy.writableField);
		assertEquals(copy.writableField, classLevelCopyable.writableField);
	}
}
}
