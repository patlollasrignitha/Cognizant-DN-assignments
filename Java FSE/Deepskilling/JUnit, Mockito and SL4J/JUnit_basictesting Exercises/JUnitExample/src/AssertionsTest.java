import static org.junit.Assert.*;

import org.junit.Test;

import static org.junit.Assert.*;
import org.junit.Test;

public class AssertionsTest {

    @Test
    public void testAssertions() {

        // assertEquals
        assertEquals(5, 2 + 3);

        // assertTrue
        assertTrue(5 > 3);

        // assertFalse
        assertFalse(5 < 3);

        // assertNull
        assertNull(null);

        // assertNotNull
        assertNotNull(new Object());
    }
}