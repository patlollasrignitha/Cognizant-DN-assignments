package com.example.EmployeeManagementSystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.EmployeeManagementSystem.entity.Employee;
import com.example.EmployeeManagementSystem.repository.EmployeeRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
@RestController
@RequestMapping("/employees")
public class EmployeeController {

    @Autowired
    private EmployeeRepository repository;
    
    @PostMapping
    public Employee saveEmployee(@RequestBody Employee employee) {
        return repository.save(employee);
    }

    @GetMapping
    public List<Employee> getAllEmployees() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    public Employee getEmployee(@PathVariable Long id) {
        return repository.findById(id).orElse(null);
    }

    @GetMapping("/name/{name}")
    public List<Employee> getByName(
            @PathVariable String name){

        return repository.findByName(name);
    }
    @GetMapping("/search/{keyword}")
    public List<Employee> searchEmployee(
            @PathVariable String keyword){

        return repository.searchEmployee(keyword);
    }
    @GetMapping("/page")
    public Page<Employee> getEmployeesPage(
            @RequestParam int page,
            @RequestParam int size) {

        Pageable pageable =
                PageRequest.of(page, size);

        return repository.findAll(pageable);
    }
    @GetMapping("/sort")
    public List<Employee> sortEmployees() {

        return repository.findAll(
                Sort.by("name").ascending());
    }
    @GetMapping("/page-sort")
    public Page<Employee> pageSortEmployees(
            @RequestParam int page,
            @RequestParam int size) {

        Pageable pageable =
                PageRequest.of(
                        page,
                        size,
                        Sort.by("name"));

        return repository.findAll(pageable);
    }
    @PutMapping("/{id}")
    public Employee updateEmployee(@PathVariable Long id,
                                   @RequestBody Employee employee) {
        employee.setId(id);
        return repository.save(employee);
    }

    @DeleteMapping("/{id}")
    public String deleteEmployee(@PathVariable Long id) {
        repository.deleteById(id);
        return "Employee Deleted";
    }
}