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
