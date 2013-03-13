package dolly {

import dolly.core.dolly_internal;
import dolly.data.CompositeCopyableClass;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

use namespace dolly_internal;

public class CopyingOfCompositeCopyableClassTest {

	private var compositeCopyableClass:CompositeCopyableClass;
	private var compositeCopyableClassType:Type;

	[Before]
	public function before():void {
		compositeCopyableClass = new CompositeCopyableClass();
		compositeCopyableClass.array = [1, 2, 3, 4, 5];
		compositeCopyableClass.arrayList = new ArrayList([1, 2, 3, 4, 5]);
		compositeCopyableClass.arrayCollection = new ArrayCollection([1, 2, 3, 4, 5]);

		compositeCopyableClassType = Type.forInstance(compositeCopyableClass);
	}

	[After]
	public function after():void {
		compositeCopyableClass = null;
		compositeCopyableClassType = null;
	}

	[Test]
	public function findingAllWritableFieldsForType():void {
		const writableFields:Vector.<Field> = Copier.findCopyableFieldsForType(compositeCopyableClassType);
		assertNotNull(writableFields);
		assertEquals(4, writableFields.length);
	}
}
}
