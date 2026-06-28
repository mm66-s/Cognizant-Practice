package com.employee.repository;

import com.employee.model.Employee;
import com.employee.projection.EmployeeNameProjection;
import com.employee.projection.EmployeeSummary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    List<EmployeeNameProjection> findByDepartmentId(Long departmentId);

    @Query("SELECT new com.employee.projection.EmployeeSummary(e.name, e.department.name) FROM Employee e")
    List<EmployeeSummary> findEmployeeSummaries();
}
