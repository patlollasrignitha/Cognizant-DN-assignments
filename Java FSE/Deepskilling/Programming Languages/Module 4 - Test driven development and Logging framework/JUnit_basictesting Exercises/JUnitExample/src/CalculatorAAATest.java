import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class CalculatorAAATest {

    private Calculator calc;

    @Before
    public void setUp() {
        System.out.println("Setting up...");
        calc = new Calculator();
    }

    @After
    public void tearDown() {
        System.out.println("Cleaning up...");
    }

    @Test
    public void testAdd() {

        // Arrange
        int a = 10;
        int b = 5;

        // Act
        int result = calc.add(a, b);

        // Assert
        assertEquals(15, result);
    }

    @Test
    public void testSubtract() {

        // Arrange
        int a = 10;
        int b = 5;

        // Act
        int result = calc.subtract(a, b);

        // Assert
        assertEquals(5, result);
    }
}