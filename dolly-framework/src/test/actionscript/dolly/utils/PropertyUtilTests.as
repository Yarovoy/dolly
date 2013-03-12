package dolly.utils {
import dolly.core.dolly_internal;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

import org.flexunit.assertThat;
import org.flexunit.asserts.assertTrue;
import org.hamcrest.collection.array;
import org.hamcrest.collection.arrayWithSize;
import org.hamcrest.collection.everyItem;
import org.hamcrest.core.isA;
import org.hamcrest.object.equalTo;

use namespace dolly_internal;

public class PropertyUtilTests {

	private var sourceObj:Object;
	private var targetObj:Object;

	[Before]
	public function before():void {
		sourceObj = {};
		sourceObj.array = [0, 1, 2, 3, 4];
		sourceObj.arrayList = new ArrayList([0, 1, 2, 3, 4]);
		sourceObj.arrayCollection = new ArrayCollection([0, 1, 2, 3, 4]);

		targetObj = {};
	}

	[After]
	public function after():void {
		sourceObj = targetObj = null;
	}

	[Test]
	public function copyingOfArray():void {
		PropertyUtil.copyArray(sourceObj, targetObj, "array");

		assertThat(targetObj.array, arrayWithSize(5));
		assertThat(targetObj.array, sourceObj.array);
		assertTrue(targetObj.array != sourceObj.array);
		assertThat(targetObj.array, everyItem(isA(Number)));
		assertThat(targetObj.array, array(equalTo(0), equalTo(1), equalTo(2), equalTo(3), equalTo(4)));
	}
}
}
