public class AdapterPatternTest {

    public static void main(String[] args) {

        PaymentProcessor payment = new PayPalAdapter();
        payment.processPayment(5000);
    }
}