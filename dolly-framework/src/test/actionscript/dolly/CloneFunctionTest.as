package dolly {

import dolly.data.CloneableClass;
import dolly.data.PropertyLevelCloneable;

import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;

public class CloneFunctionTest {

	private var cloneableClass:CloneableClass;
	private var cloneableClassType:Type;

	private var propertyLevelCloneable:PropertyLevelCloneable;
	private var propertyLevelCloneableType:Type;

	[Before]
	public function before():void {
		cloneableClass = new CloneableClass();
		cloneableClass.property1 = "value 1";
		cloneableClass.property2 = "value 2";
		cloneableClass.property3 = "value 3";

		cloneableClassType = Type.forInstance(cloneableClass);

		cloneableClass.writableField = "value 4";
		propertyLevelCloneable = new PropertyLevelCloneable();
		propertyLevelCloneable.property1 = "value 1";
		propertyLevelCloneable.property2 = "value 2";
		propertyLevelCloneable.property3 = "value 3";
		propertyLevelCloneable.writableField = "value 4";

		propertyLevelCloneableType = Type.forInstance(propertyLevelCloneable);
	}

	[After]
	public function after():void {
		cloneableClass = null;
		cloneableClassType = null;

		propertyLevelCloneable = null;
		propertyLevelCloneableType = null;
	}

	[Test]
	public function testCloneWithClassLevelMetadata():void {
		const classLevelClone:CloneableClass = clone(cloneableClass);

		assertNotNull(classLevelClone);
		assertNotNull(classLevelClone.property1);
		assertEquals(classLevelClone.property1, cloneableClass.property1);
		assertNotNull(classLevelClone.property2);
		assertEquals(classLevelClone.property2, cloneableClass.property2);
		assertNotNull(classLevelClone.property3);
		assertEquals(classLevelClone.property3, cloneableClass.property3);
		assertNotNull(classLevelClone.writableField);
		assertEquals(classLevelClone.writableField, cloneableClass.writableField);
	}

	/**
	 * Method <code>clone()</code> will throw <code>CloningError</code> in this case
	 * because <code>PropertyLevelCloneable</code> class is not cloneable indeed.
	 */
	[Test(expects="dolly.core.errors.CloningError")]
	public function testCloneWithPropertyLevelMetadata():void {
		clone(propertyLevelCloneable);
	}
}
}
