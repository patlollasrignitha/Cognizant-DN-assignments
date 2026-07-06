package InventoryManagementSystem;

import java.util.HashMap;

class Product {
    private int productId;
    private String productName;
    private int quantity;
    private double price;

    public Product(int productId, String productName, int quantity, double price) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "ID: " + productId +
                ", Name: " + productName +
                ", Quantity: " + quantity +
                ", Price: ₹" + price;
    }
}

public class InventoryManagementSystem {

    private HashMap<Integer, Product> inventory = new HashMap<>();

    // Add Product
    public void addProduct(Product product) {
        inventory.put(product.getProductId(), product);
        System.out.println("Product added successfully.");
    }

    // Update Product
    public void updateProduct(int productId, String name, int quantity, double price) {
        Product product = inventory.get(productId);

        if (product != null) {
            product.setProductName(name);
            product.setQuantity(quantity);
            product.setPrice(price);
            System.out.println("Product updated successfully.");
        } else {
            System.out.println("Product not found.");
        }
    }

    // Delete Product
    public void deleteProduct(int productId) {
        if (inventory.remove(productId) != null) {
            System.out.println("Product deleted successfully.");
        } else {
            System.out.println("Product not found.");
        }
    }

    // Display Inventory
    public void displayInventory() {
        System.out.println("\nInventory Details:");
        for (Product product : inventory.values()) {
            System.out.println(product);
        }
    }

    public static void main(String[] args) {

        InventoryManagementSystem manager = new InventoryManagementSystem();

        // Adding products
        manager.addProduct(new Product(101, "Laptop", 20, 55000));
        manager.addProduct(new Product(102, "Mouse", 100, 500));
        manager.addProduct(new Product(103, "Keyboard", 50, 1200));

        manager.displayInventory();

        // Updating a product
        manager.updateProduct(102, "Wireless Mouse", 120, 700);

        manager.displayInventory();

        // Deleting a product
        manager.deleteProduct(103);

        manager.displayInventory();
    }
}