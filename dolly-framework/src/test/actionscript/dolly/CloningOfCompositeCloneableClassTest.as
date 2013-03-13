package dolly {
import dolly.core.dolly_internal;
import dolly.data.CompositeCloneableClass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CloningOfCompositeCloneableClassTest {

	private var compositeCloneableClass:CompositeCloneableClass;
	private var compositeCloneableClassType:Type;

	[Before]
	public function before():void {
		compositeCloneableClass = new CompositeCloneableClass();

		compositeCloneableClassType = Type.forInstance(compositeCloneableClass);
	}

	[After]
	public function after():void {
		compositeCloneableClass = null;
		compositeCloneableClassType = null;
	}

	[Test]
	public function findingAllWritableFieldsForType():void {
		const writableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(compositeCloneableClassType);
		assertNotNull(writableFields);
		assertEquals(4, writableFields.length);
	}
}
}
