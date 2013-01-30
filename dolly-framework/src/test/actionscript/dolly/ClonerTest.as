package dolly {
import dolly.core.dolly_internal;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class ClonerTest {

	private var classMarkedAsCloneable:ClassMarkedAsCloneable;
	private var classWithSomeCloneableFields:ClassWithSomeCloneableFields;

	[Before]
	public function before():void {
		classMarkedAsCloneable = new ClassMarkedAsCloneable();
		classWithSomeCloneableFields = new ClassWithSomeCloneableFields();
	}

	[After]
	public function after():void {
		classMarkedAsCloneable = null;
		classWithSomeCloneableFields = null;
	}

	[Test]
	public function testGetCloneableFields():void {
		var cloneableFields:Array = Cloner.getCloneableFields(classMarkedAsCloneable);

		assertNotNull(cloneableFields);
		assertEquals(4, cloneableFields.length);

		cloneableFields = Cloner.getCloneableFields(classWithSomeCloneableFields);

		assertNotNull(cloneableFields);
		assertEquals(3, cloneableFields.length);
	}
}
}