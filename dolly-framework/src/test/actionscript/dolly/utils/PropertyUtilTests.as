package dolly.utils {
import dolly.core.dolly_internal;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

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
}
}
