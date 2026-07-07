package com.example.EmployeeManagementSystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.EmployeeManagementSystem.entity.Employee;

public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

    // Derived Query Methods

    List<Employee> findByName(String name);

    List<Employee> findByEmailContaining(String email);

    List<Employee> findByNameContaining(String keyword);

    // Custom Query

    @Query("SELECT e FROM Employee e WHERE e.name LIKE %:keyword%")
    List<Employee> searchEmployee(
            @Param("keyword") String keyword);

    // Department Query

    List<Employee> findByDepartmentId(Long departmentId);
}