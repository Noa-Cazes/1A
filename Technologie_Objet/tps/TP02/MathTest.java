import junit.framework.TestCase;


public class MathTest extends TestCase {
	public static final double EPSILON = 1e-6;

	public void testSqrt() {
		double a = 4;
		assertEquals(Math.sqrt(a),2,EPSILON);
	}

}
