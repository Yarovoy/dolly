package dolly {
import dolly.core.dolly_internal;
import dolly.data.CloneableClass;
import dolly.data.CompositeCloneableClass;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

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
import org.hamcrest.core.not;
import org.hamcrest.object.equalTo;

use namespace dolly_internal;

public class CloningOfCompositeCloneableClassTest {

	private var compositeCloneableClass:CompositeCloneableClass;
	private var compositeCloneableClassType:Type;

	[Before]
	public function before():void {
		compositeCloneableClass = new CompositeCloneableClass();

		const nestedCloneable:CloneableClass = new CloneableClass();
		nestedCloneable.property1 = "property1 value";
		nestedCloneable.writableField1 = "writableField1 value";

		const nestedCompositeCloneable:CompositeCloneableClass = new CompositeCloneableClass();
		nestedCompositeCloneable.compositeCloneable = compositeCloneableClass;
		nestedCompositeCloneable.array = [1, 2, 3];
		nestedCompositeCloneable.arrayList = new ArrayList([1, 2, 3]);
		nestedCompositeCloneable.arrayCollection = new ArrayCollection([1, 2, 3]);

		compositeCloneableClass.cloneable = nestedCloneable;
		compositeCloneableClass.compositeCloneable = nestedCompositeCloneable;
		compositeCloneableClass.array = [1, 2, 3, 4, 5];
		compositeCloneableClass.arrayList = new ArrayList([1, 2, 3, 4, 5]);
		compositeCloneableClass.arrayCollection = new ArrayCollection([1, 2, 3, 4, 5]);

		compositeCloneableClassType = Type.forInstance(compositeCloneableClass);
	}

	[After]
	public function after():void {
		compositeCloneableClass.compositeCloneable =
				compositeCloneableClass.compositeCloneable.compositeCloneable = null;
		compositeCloneableClass.cloneable = null;
		compositeCloneableClass = null;
		compositeCloneableClassType = null;
	}

	[Test]
	public function findingAllWritableFieldsForType():void {
		const writableFields:Vector.<Field> = Cloner.findAllWritableFieldsForType(compositeCloneableClassType);
		assertNotNull(writableFields);
		assertEquals(5, writableFields.length);
	}

	[Test]
	public function cloningOfArray():void {
		const clone:CompositeCloneableClass = Cloner.clone(compositeCloneableClass);

		assertNotNull(clone.array);
		assertThat(clone.array, arrayWithSize(5));
		assertThat(clone.array, compositeCloneableClass.array);
		assertFalse(clone.array == compositeCloneableClass.array);
		assertThat(clone.array, everyItem(isA(Number)));
		assertThat(clone.array, array(equalTo(1), equalTo(2), equalTo(3), equalTo(4), equalTo(5)));
	}

	[Test]
	public function cloningOfArrayList():void {
		const clone:CompositeCloneableClass = Cloner.clone(compositeCloneableClass);

		const arrayList:ArrayList = clone.arrayList;

		assertNotNull(arrayList);
		assertFalse(clone.arrayList == compositeCloneableClass.arrayList);
		assertEquals(arrayList.length, 5);
		assertEquals(arrayList.getItemAt(0), 1);
		assertEquals(arrayList.getItemAt(1), 2);
		assertEquals(arrayList.getItemAt(2), 3);
		assertEquals(arrayList.getItemAt(3), 4);
		assertEquals(arrayList.getItemAt(4), 5);
	}

	[Test]
	public function cloningOfArrayCollection():void {
		const clone:CompositeCloneableClass = Cloner.clone(compositeCloneableClass);

		const arrayCollection:ArrayCollection = clone.arrayCollection;

		assertNotNull(arrayCollection);
		assertFalse(clone.arrayCollection == compositeCloneableClass.arrayCollection);
		assertEquals(arrayCollection.length, 5);
		assertEquals(arrayCollection.getItemAt(0), 1);
		assertEquals(arrayCollection.getItemAt(1), 2);
		assertEquals(arrayCollection.getItemAt(2), 3);
		assertEquals(arrayCollection.getItemAt(3), 4);
		assertEquals(arrayCollection.getItemAt(4), 5);
	}

	[Test]
	public function cloningOfCloneableProperty():void {
		const clone:CompositeCloneableClass = Cloner.clone(compositeCloneableClass);

		const cloneable:CloneableClass = clone.cloneable;

		assertNotNull(cloneable);
		assertThat(cloneable, isA(CloneableClass));
		assertEquals(cloneable.property1, "property1 value");
		assertEquals(cloneable.writableField1, "writableField1 value");
		assertThat(cloneable, not(compositeCloneableClass.cloneable));
	}

	[Test]
	public function cloningOfCompositeCloneableClass():void {
		const clone:CompositeCloneableClass = Cloner.clone(compositeCloneableClass);

		const compositeCloneable:CompositeCloneableClass = clone.compositeCloneable;

		assertNotNull(compositeCloneable);
		assertThat(compositeCloneable, isA(CompositeCloneableClass));

		assertNotNull(compositeCloneable.array);
		assertThat(compositeCloneable.array, arrayWithSize(3));
		assertThat(compositeCloneable.array, everyItem(isA(Number)));
		assertThat(compositeCloneable.array, array(equalTo(1), equalTo(2), equalTo(3)));

		assertNotNull(compositeCloneable.arrayList);
		assertThat(compositeCloneable.arrayList, isA(ArrayList));
		assertEquals(compositeCloneable.arrayList.length, 3);
		assertEquals(compositeCloneable.arrayList.getItemAt(0), 1);
		assertEquals(compositeCloneable.arrayList.getItemAt(1), 2);
		assertEquals(compositeCloneable.arrayList.getItemAt(2), 3);

		assertNotNull(compositeCloneable.arrayCollection);
		assertThat(compositeCloneable.arrayCollection, isA(ArrayCollection));
		assertEquals(compositeCloneable.arrayCollection.length, 3);
		assertEquals(compositeCloneable.arrayCollection.getItemAt(0), 1);
		assertEquals(compositeCloneable.arrayCollection.getItemAt(1), 2);
		assertEquals(compositeCloneable.arrayCollection.getItemAt(2), 3);

		assertNotNull(compositeCloneable.compositeCloneable);
		assertThat(compositeCloneable.compositeCloneable, isA(CompositeCloneableClass));
		assertEquals(clone, compositeCloneable.compositeCloneable);
		assertEquals(clone.array, compositeCloneable.compositeCloneable.array);
		assertEquals(clone.arrayList, compositeCloneable.compositeCloneable.arrayList);
		assertEquals(clone.arrayCollection, compositeCloneable.compositeCloneable.arrayCollection);
		assertEquals(clone.cloneable, compositeCloneable.compositeCloneable.cloneable);
	}
}
}
