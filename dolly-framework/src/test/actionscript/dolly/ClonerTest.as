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
}
}