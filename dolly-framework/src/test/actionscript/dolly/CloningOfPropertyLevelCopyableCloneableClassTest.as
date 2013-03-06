package dolly {

import dolly.core.dolly_internal;
import dolly.data.PropertyLevelCopyableCloneableClass;

import org.as3commons.reflect.Type;

use namespace dolly_internal;

public class CloningOfPropertyLevelCopyableCloneableClassTest {

	private var propertyLevelCopyableCloneable:PropertyLevelCopyableCloneableClass;
	private var propertyLevelCopyableCloneableType:Type;

	[Before]
	public function before():void {
		propertyLevelCopyableCloneable = new PropertyLevelCopyableCloneableClass();
		propertyLevelCopyableCloneable.property1 = "property1 value";
		propertyLevelCopyableCloneable.writableField1 = "writableField1 value";
		propertyLevelCopyableCloneableType = Type.forInstance(propertyLevelCopyableCloneable);
	}

	[After]
	public function after():void {
		propertyLevelCopyableCloneable = null;
		propertyLevelCopyableCloneableType = null;
	}

	/**
	 * <code>Cloner.findingAllWritableFieldsForType()</code> method will throw <code>CloningError</code> in this case
	 * because <code>PropertyLevelCopyableCloneableClass</code> class is not cloneable indeed.
	 */
	[Test(expects="dolly.core.errors.CloningError")]
	public function findingAllWritableFieldsForType():void {
		Cloner.findAllWritableFieldsForType(propertyLevelCopyableCloneableType);
	}

	/**
	 * <code>Cloner.clone()</code> method will throw <code>CloningError</code> in this case
	 * because <code>PropertyLevelCopyableCloneableClass</code> class is not cloneable indeed.
	 */
	[Test(expects="dolly.core.errors.CloningError")]
	public function cloningByCloner():void {
		Cloner.clone(propertyLevelCopyableCloneable);
	}

	/**
	 * Method <code>clone()</code> will throw <code>CloningError</code> in this case
	 * because <code>PropertyLevelCopyableCloneableClass</code> class is not cloneable indeed.
	 */
	[Test(expects="dolly.core.errors.CloningError")]
	public function cloningByCloneFunction():void {
		clone(propertyLevelCopyableCloneable);
	}
}
}
