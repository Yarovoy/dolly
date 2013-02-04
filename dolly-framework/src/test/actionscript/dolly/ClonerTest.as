package dolly {
import dolly.core.dolly_internal;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

use namespace dolly_internal;

public class ClonerTest {

	private var classLevelCloneable:ClassLevelCloneable;
	private var classLevelCloneableType:Type;

	private var propertyLevelCloneable:PropertyLevelCloneable;
	private var propertyLevelCloneableType:Type;

	[Before]
	public function before():void {
		classLevelCloneable = new ClassLevelCloneable();
		classLevelCloneable.property1 = "value 1";
		classLevelCloneable.property2 = "value 2";
		classLevelCloneable.property3 = "value 3";
		classLevelCloneable.writableField = "value 4";

		propertyLevelCloneable = new PropertyLevelCloneable();
		propertyLevelCloneable.property1 = "value 1";
		propertyLevelCloneable.property2 = "value 2";
		propertyLevelCloneable.property3 = "value 3";
		propertyLevelCloneable.writableField = "value 4";

		classLevelCloneableType = Type.forInstance(classLevelCloneable);
		propertyLevelCloneableType = Type.forInstance(propertyLevelCloneable);
	}

	[After]
	public function after():void {
		classLevelCloneable = null;
		propertyLevelCloneable = null;
		classLevelCloneableType = null;
		propertyLevelCloneableType = null;
	}

	[Test]
	public function testGetCloneableFieldsForType():void {
		var cloneableFields:Vector.<Field> = Cloner.getCloneableFieldsForType(classLevelCloneableType);

		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);

		cloneableFields = Cloner.getCloneableFieldsForType(propertyLevelCloneableType);

		assertNotNull(cloneableFields);
		assertEquals(3, cloneableFields.length);
	}

	[Test]
	public function testCloneWithClassLevelMetadata():void {
		const clone:ClassLevelCloneable = Cloner.clone(classLevelCloneable) as ClassLevelCloneable;

		assertNotNull(clone);
		assertNotNull(clone.property1);
		assertEquals(clone.property1, classLevelCloneable.property1);
		assertNotNull(clone.property2);
		assertEquals(clone.property2, classLevelCloneable.property2);
		assertNotNull(clone.property3);
		assertEquals(clone.property3, classLevelCloneable.property3);
		assertNotNull(clone.writableField);
		assertEquals(clone.writableField, classLevelCloneable.writableField);
	}

	[Test]
	public function testCloneWithPropertyLevelMetadata():void {
		const clone:PropertyLevelCloneable = Cloner.clone(
				propertyLevelCloneable
		) as PropertyLevelCloneable;

		assertNotNull(clone);
		assertNull(clone.property1);
		assertNotNull(clone.property2);
		assertEquals(clone.property2, propertyLevelCloneable.property2);
		assertNotNull(clone.property3);
		assertEquals(clone.property3, propertyLevelCloneable.property3);
		assertNotNull(clone.writableField);
		assertEquals(clone.writableField, propertyLevelCloneable.writableField);
	}
}
}