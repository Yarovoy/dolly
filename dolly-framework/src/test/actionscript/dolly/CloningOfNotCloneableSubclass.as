package dolly {

import dolly.core.dolly_internal;
import dolly.data.NotCloneableSubclass;

import org.as3commons.reflect.Type;

use namespace dolly_internal;

public class CloningOfNotCloneableSubclass {

	public var notCloneableSubclass:NotCloneableSubclass;
	public var notCloneableSubclassType:Type;

	[Before]
	public function before():void {
		notCloneableSubclass = new NotCloneableSubclass();
		notCloneableSubclass.property1 = "property1 value";
		notCloneableSubclass.property2 = "property2 value";
		notCloneableSubclass.writableField1 = "writableField1 value";
		notCloneableSubclass.writableField2 = "writableField2 value";
		notCloneableSubclassType = Type.forInstance(notCloneableSubclass);
	}

	[After]
	public function after():void {
		notCloneableSubclass = null;
		notCloneableSubclassType = null;
	}

	[Test(expects="dolly.core.errors.CloningError")]
	public function findingAllWritableFieldsForType():void {
		Cloner.findAllWritableFieldsForType(notCloneableSubclassType);
	}

	[Test(expects="dolly.core.errors.CloningError")]
	public function cloningByCloner():void {
		Cloner.clone(notCloneableSubclass);
	}

	[Test(expects="dolly.core.errors.CloningError")]
	public function cloningByCloneFunction():void {
		clone(notCloneableSubclass);
	}
}
}
