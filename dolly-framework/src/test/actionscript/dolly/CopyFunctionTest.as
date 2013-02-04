package dolly {
import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;

public class CopyFunctionTest {
	private var classLevelCopyable:ClassLevelCopyable;
	private var classLevelCopyableType:Type;

	private var propertyLevelCopyable:PropertyLevelCopyable;
	private var propertyLevelCopyableType:Type;

	[Before]
	public function before():void {
		classLevelCopyable = new ClassLevelCopyable();
		classLevelCopyable.property1 = "value 1";
		classLevelCopyable.property2 = "value 2";
		classLevelCopyable.property3 = "value 3";
		classLevelCopyable.writableField = "value 4";

		propertyLevelCopyable = new PropertyLevelCopyable();
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
		const classLevelCopy:ClassLevelCopyable = copy(classLevelCopyable) as ClassLevelCopyable;

		assertNotNull(classLevelCopy);
		assertNotNull(classLevelCopy.property1);
		assertEquals(classLevelCopy.property1, classLevelCopyable.property1);
		assertNotNull(classLevelCopy.property2);
		assertEquals(classLevelCopy.property2, classLevelCopyable.property2);
		assertNotNull(classLevelCopy.property3);
		assertEquals(classLevelCopy.property3, classLevelCopyable.property3);
		assertNotNull(classLevelCopy.writableField);
		assertEquals(classLevelCopy.writableField, classLevelCopyable.writableField);
	}

	[Test]
	public function testCopyWithPropertyLevelMetadata():void {
		const propertyLevelCopy:PropertyLevelCopyable = copy(propertyLevelCopyable) as PropertyLevelCopyable;

		assertNotNull(propertyLevelCopy);
		assertNull(propertyLevelCopy.property1);
		assertNotNull(propertyLevelCopy.property2);
		assertEquals(propertyLevelCopy.property2, classLevelCopyable.property2);
		assertNotNull(propertyLevelCopy.property3);
		assertEquals(propertyLevelCopy.property3, classLevelCopyable.property3);
		assertNotNull(propertyLevelCopy.writableField);
		assertEquals(propertyLevelCopy.writableField, classLevelCopyable.writableField);
	}
}
}
