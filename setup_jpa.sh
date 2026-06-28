#!/bin/bash
# Run this with: bash setup_jpa.sh
# Creates the Spring_Data_JPA_Hibernate folder structure with all code filled in.

echo "Creating folders..."

BASE="Spring_Data_JPA_Hibernate"

mkdir -p $BASE/Exercise1_OverviewAndSetup/src/main/java/com/employee
mkdir -p $BASE/Exercise1_OverviewAndSetup/src/main/resources

mkdir -p $BASE/Exercise2_CreatingEntities/src/main/java/com/employee/model

mkdir -p $BASE/Exercise3_CreatingRepositories/src/main/java/com/employee/repository

mkdir -p $BASE/Exercise4_CRUDOperations/src/main/java/com/employee/controller

mkdir -p $BASE/Exercise5_QueryMethods/src/main/java/com/employee/repository
mkdir -p $BASE/Exercise5_QueryMethods/src/main/java/com/employee/model

mkdir -p $BASE/Exercise6_PaginationSorting/src/main/java/com/employee/repository
mkdir -p $BASE/Exercise6_PaginationSorting/src/main/java/com/employee/controller

mkdir -p $BASE/Exercise7_EntityAuditing/src/main/java/com/employee/config
mkdir -p $BASE/Exercise7_EntityAuditing/src/main/java/com/employee/model

mkdir -p $BASE/Exercise8_Projections/src/main/java/com/employee/projection
mkdir -p $BASE/Exercise8_Projections/src/main/java/com/employee/repository

mkdir -p $BASE/Exercise9_DataSourceConfig/src/main/java/com/employee/config
mkdir -p $BASE/Exercise9_DataSourceConfig/src/main/resources

mkdir -p $BASE/Exercise10_HibernateFeatures/src/main/java/com/employee/model
mkdir -p $BASE/Exercise10_HibernateFeatures/src/main/java/com/employee/service
mkdir -p $BASE/Exercise10_HibernateFeatures/src/main/resources

echo "Creating Exercise 1 files..."

cat > $BASE/Exercise1_OverviewAndSetup/pom.xml << 'EOF'
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.18</version>
    </parent>

    <groupId>com.employee</groupId>
    <artifactId>EmployeeManagementSystem</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <properties>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
EOF

cat > $BASE/Exercise1_OverviewAndSetup/src/main/resources/application.properties << 'EOF'
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.h2.console.enabled=true
spring.jpa.hibernate.ddl-auto=update
EOF

cat > $BASE/Exercise1_OverviewAndSetup/src/main/java/com/employee/EmployeeManagementSystemApplication.java << 'EOF'
package com.employee;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class EmployeeManagementSystemApplication {
    public static void main(String[] args) {
        SpringApplication.run(EmployeeManagementSystemApplication.class, args);
    }
}
EOF

echo "Creating Exercise 2 files..."

cat > $BASE/Exercise2_CreatingEntities/src/main/java/com/employee/model/Department.java << 'EOF'
package com.employee.model;

import jakarta.persistence.*;
import lombok.Data;
import java.util.List;

@Entity
@Table(name = "departments")
@Data
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL)
    private List<Employee> employees;
}
EOF

cat > $BASE/Exercise2_CreatingEntities/src/main/java/com/employee/model/Employee.java << 'EOF'
package com.employee.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "employees")
@Data
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;
}
EOF

echo "Creating Exercise 3 files..."

cat > $BASE/Exercise3_CreatingRepositories/src/main/java/com/employee/repository/EmployeeRepository.java << 'EOF'
package com.employee.repository;

import com.employee.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    List<Employee> findByName(String name);
    List<Employee> findByDepartmentId(Long departmentId);
}
EOF

cat > $BASE/Exercise3_CreatingRepositories/src/main/java/com/employee/repository/DepartmentRepository.java << 'EOF'
package com.employee.repository;

import com.employee.model.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface DepartmentRepository extends JpaRepository<Department, Long> {
    Optional<Department> findByName(String name);
}
EOF

echo "Creating Exercise 4 files..."

cat > $BASE/Exercise4_CRUDOperations/src/main/java/com/employee/controller/EmployeeController.java << 'EOF'
package com.employee.controller;

import com.employee.model.Employee;
import com.employee.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/employees")
public class EmployeeController {

    @Autowired
    private EmployeeRepository employeeRepository;

    @GetMapping
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    @GetMapping("/{id}")
    public Employee getEmployeeById(@PathVariable Long id) {
        return employeeRepository.findById(id).orElse(null);
    }

    @PostMapping
    public Employee createEmployee(@RequestBody Employee employee) {
        return employeeRepository.save(employee);
    }

    @PutMapping("/{id}")
    public Employee updateEmployee(@PathVariable Long id, @RequestBody Employee updated) {
        Employee employee = employeeRepository.findById(id).orElseThrow();
        employee.setName(updated.getName());
        employee.setEmail(updated.getEmail());
        employee.setDepartment(updated.getDepartment());
        return employeeRepository.save(employee);
    }

    @DeleteMapping("/{id}")
    public void deleteEmployee(@PathVariable Long id) {
        employeeRepository.deleteById(id);
    }
}
EOF

cat > $BASE/Exercise4_CRUDOperations/src/main/java/com/employee/controller/DepartmentController.java << 'EOF'
package com.employee.controller;

import com.employee.model.Department;
import com.employee.repository.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/departments")
public class DepartmentController {

    @Autowired
    private DepartmentRepository departmentRepository;

    @GetMapping
    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }

    @GetMapping("/{id}")
    public Department getDepartmentById(@PathVariable Long id) {
        return departmentRepository.findById(id).orElse(null);
    }

    @PostMapping
    public Department createDepartment(@RequestBody Department department) {
        return departmentRepository.save(department);
    }

    @PutMapping("/{id}")
    public Department updateDepartment(@PathVariable Long id, @RequestBody Department updated) {
        Department department = departmentRepository.findById(id).orElseThrow();
        department.setName(updated.getName());
        return departmentRepository.save(department);
    }

    @DeleteMapping("/{id}")
    public void deleteDepartment(@PathVariable Long id) {
        departmentRepository.deleteById(id);
    }
}
EOF

echo "Creating Exercise 5 files..."

cat > $BASE/Exercise5_QueryMethods/src/main/java/com/employee/repository/EmployeeRepository.java << 'EOF'
package com.employee.repository;

import com.employee.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    List<Employee> findByNameContaining(String keyword);

    @Query("SELECT e FROM Employee e WHERE e.department.name = :deptName")
    List<Employee> findEmployeesByDepartmentName(@Param("deptName") String deptName);

    List<Employee> findByEmail(String email);
}
EOF

cat > $BASE/Exercise5_QueryMethods/src/main/java/com/employee/model/Employee.java << 'EOF'
package com.employee.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "employees")
@NamedQueries({
    @NamedQuery(
        name = "Employee.findByName",
        query = "SELECT e FROM Employee e WHERE e.name = :name"
    )
})
@Data
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;
}
EOF

echo "Creating Exercise 6 files..."

cat > $BASE/Exercise6_PaginationSorting/src/main/java/com/employee/repository/EmployeeRepository.java << 'EOF'
package com.employee.repository;

import com.employee.model.Employee;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    Page<Employee> findAll(Pageable pageable);
    List<Employee> findByNameContaining(String keyword);
}
EOF

cat > $BASE/Exercise6_PaginationSorting/src/main/java/com/employee/controller/EmployeeController.java << 'EOF'
package com.employee.controller;

import com.employee.model.Employee;
import com.employee.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/employees")
public class EmployeeController {

    @Autowired
    private EmployeeRepository employeeRepository;

    @GetMapping("/search")
    public Page<Employee> searchEmployees(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size,
            @RequestParam(defaultValue = "name") String sortBy) {

        PageRequest pageRequest = PageRequest.of(page, size, Sort.by(sortBy));
        return employeeRepository.findAll(pageRequest);
    }
}
EOF

echo "Creating Exercise 7 files..."

cat > $BASE/Exercise7_EntityAuditing/src/main/java/com/employee/config/JpaAuditingConfig.java << 'EOF'
package com.employee.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@Configuration
@EnableJpaAuditing
public class JpaAuditingConfig {
}
EOF

cat > $BASE/Exercise7_EntityAuditing/src/main/java/com/employee/model/Employee.java << 'EOF'
package com.employee.model;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import java.time.LocalDateTime;

@Entity
@Table(name = "employees")
@EntityListeners(AuditingEntityListener.class)
@Data
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

    @CreatedDate
    @Column(updatable = false)
    private LocalDateTime createdDate;

    @LastModifiedDate
    private LocalDateTime lastModifiedDate;
}
EOF

echo "Creating Exercise 8 files..."

cat > $BASE/Exercise8_Projections/src/main/java/com/employee/projection/EmployeeNameProjection.java << 'EOF'
package com.employee.projection;

public interface EmployeeNameProjection {
    String getName();
    String getEmail();
}
EOF

cat > $BASE/Exercise8_Projections/src/main/java/com/employee/projection/EmployeeSummary.java << 'EOF'
package com.employee.projection;

public class EmployeeSummary {

    private final String name;
    private final String departmentName;

    public EmployeeSummary(String name, String departmentName) {
        this.name = name;
        this.departmentName = departmentName;
    }

    public String getName() { return name; }
    public String getDepartmentName() { return departmentName; }
}
EOF

cat > $BASE/Exercise8_Projections/src/main/java/com/employee/repository/EmployeeRepository.java << 'EOF'
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
EOF

echo "Creating Exercise 9 files..."

cat > $BASE/Exercise9_DataSourceConfig/src/main/resources/application.properties << 'EOF'
# Primary datasource
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=update

# Secondary datasource (example for managing multiple data sources)
secondary.datasource.url=jdbc:h2:mem:secondarydb
secondary.datasource.driverClassName=org.h2.Driver
secondary.datasource.username=sa
secondary.datasource.password=password
EOF

cat > $BASE/Exercise9_DataSourceConfig/src/main/java/com/employee/config/SecondaryDataSourceConfig.java << 'EOF'
package com.employee.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import javax.sql.DataSource;

@Configuration
public class SecondaryDataSourceConfig {

    @Bean
    @ConfigurationProperties(prefix = "secondary.datasource")
    public DataSource secondaryDataSource() {
        return DataSourceBuilder.create().build();
    }
}
EOF

echo "Creating Exercise 10 files..."

cat > $BASE/Exercise10_HibernateFeatures/src/main/resources/application.properties << 'EOF'
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.H2Dialect
spring.jpa.properties.hibernate.jdbc.batch_size=20
spring.jpa.properties.hibernate.order_inserts=true
spring.jpa.properties.hibernate.order_updates=true
spring.jpa.properties.hibernate.generate_statistics=false
EOF

cat > $BASE/Exercise10_HibernateFeatures/src/main/java/com/employee/model/Employee.java << 'EOF'
package com.employee.model;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name = "employees")
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Data
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;
}
EOF

cat > $BASE/Exercise10_HibernateFeatures/src/main/java/com/employee/service/BatchEmployeeService.java << 'EOF'
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
EOF

echo "Creating README..."

cat > $BASE/README.md << 'EOF'
# Spring Data JPA and Hibernate Exercises

Solutions for the Employee Management System exercises.

| Exercise | Topic |
|---|---|
| 1 | Overview and Setup |
| 2 | Creating Entities |
| 3 | Creating Repositories |
| 4 | Implementing CRUD Operations |
| 5 | Defining Query Methods |
| 6 | Implementing Pagination and Sorting |
| 7 | Enabling Entity Auditing |
| 8 | Creating Projections |
| 9 | Customizing Data Source Configuration |
| 10 | Hibernate-Specific Features |

Note: entities use `jakarta.persistence` imports (Spring Boot 3+). If using Spring Boot 2.7 with Java EE, change these to `javax.persistence` in each model file.
EOF

echo "All done! Folders and files created successfully."
echo "Now run: git add . && git commit -m 'Add Spring Data JPA and Hibernate exercises' && git push origin main"
