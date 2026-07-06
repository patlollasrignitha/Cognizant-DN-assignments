public class SingletonTest {
    public static void main(String[] args) {

        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        logger1.logMessage("First Message");
        logger2.logMessage("Second Message");

        System.out.println(logger1 == logger2);
    }
}