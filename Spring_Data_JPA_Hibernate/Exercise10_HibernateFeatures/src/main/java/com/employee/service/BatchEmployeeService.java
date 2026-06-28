package com.employee.service;

import com.employee.model.Employee;
import com.employee.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BatchEmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    public void batchInsert(List<Employee> employees) {
        employeeRepository.saveAll(employees);
    }
}
