package EmployeeManagementSystem;

class Employee {
    int employeeId;
    String name;
    String position;
    double salary;

    public Employee(int employeeId, String name, String position, double salary) {
        this.employeeId = employeeId;
        this.name = name;
        this.position = position;
        this.salary = salary;
    }

    @Override
    public String toString() {
        return "ID: " + employeeId +
                ", Name: " + name +
                ", Position: " + position +
                ", Salary: ₹" + salary;
    }
}

public class EmployeeManagementSystem {

    private Employee[] employees;
    private int count;

    public EmployeeManagementSystem(int size) {
        employees = new Employee[size];
        count = 0;
    }

    // Add Employee
    public void addEmployee(Employee employee) {
        if (count < employees.length) {
            employees[count] = employee;
            count++;
            System.out.println("Employee added successfully.");
        } else {
            System.out.println("Employee array is full.");
        }
    }

    // Search Employee
    public Employee searchEmployee(int employeeId) {
        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId == employeeId) {
                return employees[i];
            }
        }
        return null;
    }

    // Traverse Employees
    public void displayEmployees() {
        System.out.println("\nEmployee Records:");
        for (int i = 0; i < count; i++) {
            System.out.println(employees[i]);
        }
    }

    // Delete Employee
    public void deleteEmployee(int employeeId) {
        int index = -1;

        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId == employeeId) {
                index = i;
                break;
            }
        }

        if (index == -1) {
            System.out.println("Employee not found.");
            return;
        }

        for (int i = index; i < count - 1; i++) {
            employees[i] = employees[i + 1];
        }

        employees[count - 1] = null;
        count--;

        System.out.println("Employee deleted successfully.");
    }

    public static void main(String[] args) {

        EmployeeManagementSystem system = new EmployeeManagementSystem(10);

        system.addEmployee(
                new Employee(101, "Rahul", "Manager", 60000));

        system.addEmployee(
                new Employee(102, "Priya", "Developer", 50000));

        system.addEmployee(
                new Employee(103, "Anil", "Tester", 45000));

        system.displayEmployees();

        System.out.println("\nSearching Employee ID 102:");
        Employee emp = system.searchEmployee(102);

        if (emp != null)
            System.out.println(emp);
        else
            System.out.println("Employee not found.");

        system.deleteEmployee(103);

        system.displayEmployees();
    }
}