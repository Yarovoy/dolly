package dolly {
import dolly.core.dolly_internal;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class ClonerTest {

	private var classMarkedAsCloneable:ClassMarkedAsCloneable;
	private var classWithSomeCloneableFields:ClassWithSomeCloneableFields;
	private var classMarkedAsCloneableType:Type;
	private var classWithSomeCloneableFieldsType:Type;

	[Before]
	public function before():void {
		classMarkedAsCloneable = new ClassMarkedAsCloneable();
		classMarkedAsCloneable.property1 = "value 1";
		classMarkedAsCloneable.property2 = "value 2";
		classMarkedAsCloneable.property3 = "value 3";

		classMarkedAsCloneableType = Type.forInstance(classMarkedAsCloneable);

		classWithSomeCloneableFields = new ClassWithSomeCloneableFields();
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
	public function testGetCloneableFields():void {
		var cloneableFields:Vector.<Field> = Cloner.getCloneableFieldsForType(classMarkedAsCloneableType);

		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);

		cloneableFields = Cloner.getCloneableFieldsForType(classWithSomeCloneableFieldsType);

		assertNotNull(cloneableFields);
		assertEquals(3, cloneableFields.length);
	}

	[Test]
	public function testClone():void {
		const clone1:ClassMarkedAsCloneable = Cloner.clone(classMarkedAsCloneable) as ClassMarkedAsCloneable;

		assertNotNull(clone1);
		assertNotNull(clone1.property1);
		assertEquals(clone1.property1, classMarkedAsCloneable.property1);
		assertNotNull(clone1.property2);
		assertEquals(clone1.property2, classMarkedAsCloneable.property2);
		assertNotNull(clone1.property3);
		assertEquals(clone1.property3, classMarkedAsCloneable.property3);
	}
}
}