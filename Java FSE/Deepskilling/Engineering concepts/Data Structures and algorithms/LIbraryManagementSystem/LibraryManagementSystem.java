package LIbraryManagementSystem;

import java.util.Arrays;
import java.util.Comparator;

class Book {
    int bookId;
    String title;
    String author;

    public Book(int bookId, String title, String author) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
    }

    @Override
    public String toString() {
        return "Book ID: " + bookId +
                ", Title: " + title +
                ", Author: " + author;
    }
}

public class LibraryManagementSystem {

    // Linear Search
    public static Book linearSearch(Book[] books, String title) {

        for (Book book : books) {
            if (book.title.equalsIgnoreCase(title)) {
                return book;
            }
        }

        return null;
    }

    // Binary Search
    public static Book binarySearch(Book[] books, String title) {

        int low = 0;
        int high = books.length - 1;

        while (low <= high) {

            int mid = (low + high) / 2;

            int comparison = books[mid].title.compareToIgnoreCase(title);

            if (comparison == 0) {
                return books[mid];
            } else if (comparison < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return null;
    }

    public static void main(String[] args) {

        Book[] books = {
                new Book(101, "Java Programming", "James Gosling"),
                new Book(102, "Python Basics", "Guido Van Rossum"),
                new Book(103, "Data Structures", "Mark Allen"),
                new Book(104, "Algorithms", "Robert Sedgewick"),
                new Book(105, "Operating Systems", "Abraham Silberschatz")
        };

        String searchTitle = "Algorithms";

        // Linear Search
        Book result1 = linearSearch(books, searchTitle);

        System.out.println("Linear Search Result:");

        if (result1 != null)
            System.out.println(result1);
        else
            System.out.println("Book not found");

        // Sort books by title for Binary Search
        Arrays.sort(books,
                Comparator.comparing(book -> book.title.toLowerCase()));

        // Binary Search
        Book result2 = binarySearch(books, searchTitle);

        System.out.println("\nBinary Search Result:");

        if (result2 != null)
            System.out.println(result2);
        else
            System.out.println("Book not found");
    }
}
