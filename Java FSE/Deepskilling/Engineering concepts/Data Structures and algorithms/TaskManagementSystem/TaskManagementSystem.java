package TaskManagementSystem;

class Task {
    int taskId;
    String taskName;
    String status;

    Task next;

    public Task(int taskId, String taskName, String status) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
        this.next = null;
    }
}

public class TaskManagementSystem {

    private Task head;

    // Add Task
    public void addTask(int taskId, String taskName, String status) {

        Task newTask = new Task(taskId, taskName, status);

        if (head == null) {
            head = newTask;
        } else {
            Task current = head;

            while (current.next != null) {
                current = current.next;
            }

            current.next = newTask;
        }

        System.out.println("Task added successfully.");
    }

    // Search Task
    public void searchTask(int taskId) {

        Task current = head;

        while (current != null) {

            if (current.taskId == taskId) {
                System.out.println("Task Found:");
                System.out.println("ID: " + current.taskId +
                        ", Name: " + current.taskName +
                        ", Status: " + current.status);
                return;
            }

            current = current.next;
        }

        System.out.println("Task not found.");
    }

    // Traverse Tasks
    public void displayTasks() {

        if (head == null) {
            System.out.println("No tasks available.");
            return;
        }

        System.out.println("\nTask List:");

        Task current = head;

        while (current != null) {
            System.out.println("ID: " + current.taskId +
                    ", Name: " + current.taskName +
                    ", Status: " + current.status);

            current = current.next;
        }
    }

    // Delete Task
    public void deleteTask(int taskId) {

        if (head == null) {
            System.out.println("Task list is empty.");
            return;
        }

        if (head.taskId == taskId) {
            head = head.next;
            System.out.println("Task deleted successfully.");
            return;
        }

        Task current = head;

        while (current.next != null &&
                current.next.taskId != taskId) {

            current = current.next;
        }

        if (current.next == null) {
            System.out.println("Task not found.");
        } else {
            current.next = current.next.next;
            System.out.println("Task deleted successfully.");
        }
    }

    public static void main(String[] args) {

        TaskManagementSystem taskList = new TaskManagementSystem();

        taskList.addTask(101, "Design UI", "Pending");
        taskList.addTask(102, "Develop Backend", "In Progress");
        taskList.addTask(103, "Testing", "Pending");

        taskList.displayTasks();

        System.out.println("\nSearching for Task ID 102:");
        taskList.searchTask(102);

        System.out.println("\nDeleting Task ID 103:");
        taskList.deleteTask(103);

        taskList.displayTasks();
    }
}