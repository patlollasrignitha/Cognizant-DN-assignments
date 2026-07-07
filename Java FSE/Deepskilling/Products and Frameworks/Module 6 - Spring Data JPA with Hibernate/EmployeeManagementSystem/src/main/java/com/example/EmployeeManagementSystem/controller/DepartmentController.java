package com.example.EmployeeManagementSystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.EmployeeManagementSystem.entity.Department;
import com.example.EmployeeManagementSystem.repository.DepartmentRepository;

@RestController
@RequestMapping("/departments")
public class DepartmentController {

    @Autowired
    private DepartmentRepository repository;

    @PostMapping
    public Department saveDepartment(@RequestBody Department department) {
        return repository.save(department);
    }

    @GetMapping
    public List<Department> getAllDepartments() {
        return repository.findAll();
    }
}