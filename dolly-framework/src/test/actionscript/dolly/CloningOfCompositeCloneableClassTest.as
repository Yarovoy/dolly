package dolly {

import dolly.core.dolly_internal;
import dolly.data.CompositeCloneableClass;

import org.as3commons.reflect.Type;

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
}
}
