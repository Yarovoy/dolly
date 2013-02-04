package dolly {
import dolly.core.dolly_internal;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

use namespace dolly_internal;

public class ClonerTest {

	private var classMarkedAsCloneable:ClassLevelCloneable;
	private var classWithSomeCloneableFields:PropertyLevelCloneable;
	private var classMarkedAsCloneableType:Type;
	private var classWithSomeCloneableFieldsType:Type;

	[Before]
	public function before():void {
		classMarkedAsCloneable = new ClassLevelCloneable();
		classMarkedAsCloneable.property1 = "value 1";
		classMarkedAsCloneable.property2 = "value 2";
		classMarkedAsCloneable.property3 = "value 3";
		classMarkedAsCloneable.writableField = "value 4";

		classWithSomeCloneableFields = new PropertyLevelCloneable();
		classWithSomeCloneableFields.property1 = "value 1";
		classWithSomeCloneableFields.property2 = "value 2";
		classWithSomeCloneableFields.property3 = "value 3";
		classWithSomeCloneableFields.writableField = "value 4";

		classMarkedAsCloneableType = Type.forInstance(classMarkedAsCloneable);
		classWithSomeCloneableFieldsType = Type.forInstance(classWithSomeCloneableFields);
	}

	[After]
	public function after():void {
		classMarkedAsCloneable = null;
		classWithSomeCloneableFields = null;
		classMarkedAsCloneableType = null;
		classWithSomeCloneableFieldsType = null;
	}

	[Test]
	public function testGetCloneableFieldsForType():void {
		var cloneableFields:Vector.<Field> = Cloner.getCloneableFieldsForType(classMarkedAsCloneableType);

		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);

		cloneableFields = Cloner.getCloneableFieldsForType(classWithSomeCloneableFieldsType);

		assertNotNull(cloneableFields);
		assertEquals(3, cloneableFields.length);
	}

	[Test]
	public function testCloneWithClassLevelMetadata():void {
		const clone1:ClassLevelCloneable = Cloner.clone(classMarkedAsCloneable) as ClassLevelCloneable;

		assertNotNull(clone1);
		assertNotNull(clone1.property1);
		assertEquals(clone1.property1, classMarkedAsCloneable.property1);
		assertNotNull(clone1.property2);
		assertEquals(clone1.property2, classMarkedAsCloneable.property2);
		assertNotNull(clone1.property3);
		assertEquals(clone1.property3, classMarkedAsCloneable.property3);
		assertNotNull(clone1.writableField);
		assertEquals(clone1.writableField, classMarkedAsCloneable.writableField);
	}

	[Test]
	public function testCloneWithPropertyLevelMetadata():void {
		const clone2:PropertyLevelCloneable = Cloner.clone(
				classWithSomeCloneableFields
		) as PropertyLevelCloneable;

		assertNotNull(clone2);
		assertNull(clone2.property1);
		assertNotNull(clone2.property2);
		assertEquals(clone2.property2, classWithSomeCloneableFields.property2);
		assertNotNull(clone2.property3);
		assertEquals(clone2.property3, classWithSomeCloneableFields.property3);
		assertNotNull(clone2.writableField);
		assertEquals(clone2.writableField, classWithSomeCloneableFields.writableField);
	}
}
}