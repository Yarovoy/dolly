package dolly {
import dolly.data.CopyableClass;
import dolly.data.PropertyLevelCopyableClass;

import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

public class CopyFunctionTest {
	private var classLevelCopyable:CopyableClass;
	private var classLevelCopyableType:Type;

	private var propertyLevelCopyable:PropertyLevelCopyableClass;
	private var propertyLevelCopyableType:Type;

	[Before]
	public function before():void {
		classLevelCopyable = new CopyableClass();
		classLevelCopyable.property1 = "value 1";
		classLevelCopyable.writableField1 = "value 4";

		propertyLevelCopyable = new PropertyLevelCopyableClass();
		propertyLevelCopyable.property1 = "value 1";
		propertyLevelCopyable.property2 = "value 2";
		propertyLevelCopyable.property3 = "value 3";
		propertyLevelCopyable.writableField = "value 4";

		classLevelCopyableType = Type.forInstance(classLevelCopyable);
		propertyLevelCopyableType = Type.forInstance(propertyLevelCopyable);
	}

	[After]
	public function after():void {
		classLevelCopyable = null;
		classLevelCopyableType = null;

		propertyLevelCopyable = null;
		propertyLevelCopyableType = null;
	}

	[Test]
	public function testCopyWithClassLevelMetadata():void {
		const classLevelCopy:CopyableClass = copy(classLevelCopyable);

		assertNotNull(classLevelCopy);
		assertNotNull(classLevelCopy.property1);
		assertEquals(classLevelCopy.property1, classLevelCopyable.property1);
		assertNotNull(classLevelCopy.writableField1);
		assertEquals(classLevelCopy.writableField1, classLevelCopyable.writableField1);
	}

	[Test]
	public function testCopyWithPropertyLevelMetadata():void {
		const propertyLevelCopy:PropertyLevelCopyableClass = copy(propertyLevelCopyable);

		assertNotNull(propertyLevelCopy);
		assertNull(propertyLevelCopy.property1);
		assertNotNull(propertyLevelCopy.writableField);
		assertEquals(propertyLevelCopy.writableField, classLevelCopyable.writableField1);
	}
}
}
