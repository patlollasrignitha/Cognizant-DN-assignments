import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class CalculatorTest {

    @Test
    public void testAdd() {
        Calculator calc = new Calculator();
        assertEquals(5, calc.add(2, 3));
    }

    @Test
    public void testSubtract() {
        Calculator calc = new Calculator();
        assertEquals(3, calc.subtract(5, 2));
    }

    @Test
    public void testMultiply() {
        Calculator calc = new Calculator();
        assertEquals(12, calc.multiply(3, 4));
    }

    @Test
    public void testDivide() {
        Calculator calc = new Calculator();
        assertEquals(2, calc.divide(10, 5));
    }
}