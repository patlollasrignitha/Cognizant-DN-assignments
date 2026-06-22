public class TypeCastingExample {
    public static void main(String[] args) {

        double d = 25.89;
        int i = (int)d;

        System.out.println("Double Value: " + d);
        System.out.println("Converted to Int: " + i);

        int num = 50;
        double d2 = (double)num;

        System.out.println("Int Value: " + num);
        System.out.println("Converted to Double: " + d2);
    }
}