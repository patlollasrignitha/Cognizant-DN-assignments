public class BuilderPatternTest {

    public static void main(String[] args) {
        Computer computer1 = new Computer.Builder()
                .setCPU("Intel i5")
                .setRAM("8GB")
                .setStorage("256GB SSD")
                .build();
        computer1.display();
    }
}