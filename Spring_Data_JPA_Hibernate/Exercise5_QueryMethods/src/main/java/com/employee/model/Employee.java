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
