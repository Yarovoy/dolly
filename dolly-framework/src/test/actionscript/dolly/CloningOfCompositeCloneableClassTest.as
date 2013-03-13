package dolly {
import dolly.core.dolly_internal;
import dolly.data.CompositeCloneableClass;

import org.as3commons.reflect.Field;
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNotNull;
import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.collection.arrayWithSize;
import org.hamcrest.collection.everyItem;
import org.hamcrest.core.isA;
import org.hamcrest.object.equalTo;

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

	[Test]
	public function cloningOfArray():void {
		const clone:CompositeCloneableClass = Cloner.clone(compositeCloneableClass);

		assertNotNull(clone.array);
		assertThat(clone.array, arrayWithSize(5));
		assertThat(clone.array, compositeCloneableClass.array);
		assertFalse(clone.array == compositeCloneableClass.array);
		assertThat(clone.array, everyItem(isA(Number)));
		assertThat(clone.array, array(equalTo(0), equalTo(1), equalTo(2), equalTo(3), equalTo(4)));
	}
}
}
