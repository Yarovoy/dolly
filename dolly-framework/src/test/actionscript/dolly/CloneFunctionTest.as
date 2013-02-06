package dolly {
import dolly.data.ClassLevelCloneable;
import dolly.data.PropertyLevelCloneable;

import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

public class CloneFunctionTest {

	private var classLevelCloneable:ClassLevelCloneable;
	private var classLevelCloneableType:Type;

	private var propertyLevelCloneable:PropertyLevelCloneable;
	private var propertyLevelCloneableType:Type;

	[Before]
	public function before():void {
		classLevelCloneable = new ClassLevelCloneable();
		classLevelCloneable.property1 = "value 1";
		classLevelCloneable.property2 = "value 2";
		classLevelCloneable.property3 = "value 3";
		classLevelCloneable.writableField = "value 4";

		propertyLevelCloneable = new PropertyLevelCloneable();
		propertyLevelCloneable.property1 = "value 1";
		propertyLevelCloneable.property2 = "value 2";
		propertyLevelCloneable.property3 = "value 3";
		propertyLevelCloneable.writableField = "value 4";

		classLevelCloneableType = Type.forInstance(classLevelCloneable);
		propertyLevelCloneableType = Type.forInstance(propertyLevelCloneable);
	}

	[After]
	public function after():void {
		classLevelCloneable = null;
		propertyLevelCloneable = null;
		classLevelCloneableType = null;
		propertyLevelCloneableType = null;
	}

	[Test]
	public function testCloneWithClassLevelMetadata():void {
		const classLevelClone:ClassLevelCloneable = clone(classLevelCloneable) as ClassLevelCloneable;

		assertNotNull(classLevelClone);
		assertNotNull(classLevelClone.property1);
		assertEquals(classLevelClone.property1, classLevelCloneable.property1);
		assertNotNull(classLevelClone.property2);
		assertEquals(classLevelClone.property2, classLevelCloneable.property2);
		assertNotNull(classLevelClone.property3);
		assertEquals(classLevelClone.property3, classLevelCloneable.property3);
		assertNotNull(classLevelClone.writableField);
		assertEquals(classLevelClone.writableField, classLevelCloneable.writableField);
	}

	[Test]
	public function testCloneWithPropertyLevelMetadata():void {
		const propertyLevelClone:PropertyLevelCloneable = clone(propertyLevelCloneable) as PropertyLevelCloneable;

		assertNotNull(propertyLevelClone);
		assertNull(propertyLevelClone.property1);
		assertNotNull(propertyLevelClone.property2);
		assertEquals(propertyLevelClone.property2, propertyLevelCloneable.property2);
		assertNotNull(propertyLevelClone.property3);
		assertEquals(propertyLevelClone.property3, propertyLevelCloneable.property3);
		assertNotNull(propertyLevelClone.writableField);
		assertEquals(propertyLevelClone.writableField, propertyLevelCloneable.writableField);
	}
}
}
