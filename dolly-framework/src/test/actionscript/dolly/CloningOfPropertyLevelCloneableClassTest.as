package dolly {

import dolly.core.dolly_internal;
import dolly.data.PropertyLevelCloneableClass;

import org.as3commons.reflect.Type;

use namespace dolly_internal;

public class CloningOfPropertyLevelCloneableClassTest {

	private var propertyLevelCloneable:PropertyLevelCloneableClass;
	private var propertyLevelCloneableType:Type;

	[Before]
	public function before():void {
		propertyLevelCloneable = new PropertyLevelCloneableClass();
		propertyLevelCloneable.property1 = "property1 value";
		propertyLevelCloneable.writableField1 = "writableField1 value";
		propertyLevelCloneableType = Type.forInstance(propertyLevelCloneable);
	}

	[After]
	public function after():void {
		propertyLevelCloneable = null;
		propertyLevelCloneableType = null;
	}

	/**
	 * <code>Cloner.findingAllWritableFieldsForType()</code> method will throw <code>CloningError</code> in this case
	 * because <code>PropertyLevelCloneableClass</code> class is not cloneable indeed.
	 */
	[Test(expects="dolly.core.errors.CloningError")]
	public function findingAllWritableFieldsForType():void {
		Cloner.findAllWritableFieldsForType(propertyLevelCloneableType);
	}

	/**
	 * <code>Cloner.clone()</code> method will throw <code>CloningError</code> in this case
	 * because <code>PropertyLevelCloneableClass</code> class is not cloneable indeed.
	 */
	[Test(expects="dolly.core.errors.CloningError")]
	public function cloningByCloner():void {
		Cloner.clone(propertyLevelCloneable);
	}

	/**
	 * Method <code>clone()</code> will throw <code>CloningError</code> in this case
	 * because <code>PropertyLevelCloneableClass</code> class is not cloneable indeed.
	 */
	[Test(expects="dolly.core.errors.CloningError")]
	public function cloningByCloneFunction():void {
		clone(propertyLevelCloneable);
	}

}
}
