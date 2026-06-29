#!/bin/bash
# Run this with: bash setup_rest_jwt.sh
# Creates the Spring_REST_JWT folder structure with all code filled in.

echo "Creating folders..."

BASE="Spring_REST_JWT"

mkdir -p $BASE/HandsOn1_SpringCoreBasics/src/main/java/com/cognizant/springlearn
mkdir -p $BASE/HandsOn1_SpringCoreBasics/src/main/resources

mkdir -p $BASE/HandsOn2_RESTBasics_MockMVC/src/main/java/com/cognizant/springlearn/controller
mkdir -p $BASE/HandsOn2_RESTBasics_MockMVC/src/main/java/com/cognizant/springlearn/service/exception
mkdir -p $BASE/HandsOn2_RESTBasics_MockMVC/src/test/java/com/cognizant/springlearn

mkdir -p $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/model
mkdir -p $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/dao
mkdir -p $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/service/exception
mkdir -p $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/controller
mkdir -p $BASE/HandsOn3_EmployeeDepartmentREST/src/main/resources

mkdir -p $BASE/HandsOn4_POSTPUTDELETEValidation/src/main/java/com/cognizant/springlearn
mkdir -p $BASE/HandsOn4_POSTPUTDELETEValidation/src/main/java/com/cognizant/springlearn/controller

mkdir -p $BASE/HandsOn5_JWT/src/main/java/com/cognizant/springlearn/security
mkdir -p $BASE/HandsOn5_JWT/src/main/java/com/cognizant/springlearn/controller

echo "Creating HandsOn1 files..."

cat > $BASE/HandsOn1_SpringCoreBasics/pom.xml << 'EOF'
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.cognizant</groupId>
    <artifactId>spring-learn</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>jar</packaging>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.18</version>
    </parent>

    <properties>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
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

cat > $BASE/HandsOn1_SpringCoreBasics/src/main/resources/application.properties << 'EOF'
server.port=8090
logging.level.org.springframework=info
logging.level.com.cognizant.springlearn=debug
logging.pattern.console=%d{yyMMdd}|%d{HH:mm:ss.SSS}|%-20.20thread|%5p|%-25.25logger{25}|%25M|%m%n
EOF

cat > $BASE/HandsOn1_SpringCoreBasics/src/main/resources/date-format.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="dateFormat" class="java.text.SimpleDateFormat">
        <constructor-arg value="dd/MM/yyyy" />
    </bean>

</beans>
EOF

cat > $BASE/HandsOn1_SpringCoreBasics/src/main/resources/country.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="in" class="com.cognizant.springlearn.Country">
        <property name="code" value="IN" />
        <property name="name" value="India" />
    </bean>

    <bean id="us" class="com.cognizant.springlearn.Country">
        <property name="code" value="US" />
        <property name="name" value="United States" />
    </bean>

    <bean id="de" class="com.cognizant.springlearn.Country">
        <property name="code" value="DE" />
        <property name="name" value="Germany" />
    </bean>

    <bean id="jp" class="com.cognizant.springlearn.Country">
        <property name="code" value="JP" />
        <property name="name" value="Japan" />
    </bean>

    <bean id="country" class="com.cognizant.springlearn.Country">
        <property name="code" value="IN" />
        <property name="name" value="India" />
    </bean>

    <bean id="countryList" class="java.util.ArrayList">
        <constructor-arg>
            <list>
                <ref bean="in" />
                <ref bean="us" />
                <ref bean="de" />
                <ref bean="jp" />
            </list>
        </constructor-arg>
    </bean>

</beans>
EOF

cat > $BASE/HandsOn1_SpringCoreBasics/src/main/java/com/cognizant/springlearn/Country.java << 'EOF'
package com.cognizant.springlearn;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Country {

    private static final Logger LOGGER = LoggerFactory.getLogger(Country.class);

    @NotNull
    @Size(min = 2, max = 2, message = "Country code should be 2 characters")
    private String code;

    private String name;

    public Country() {
        LOGGER.debug("Inside Country Constructor.");
    }

    public String getCode() {
        LOGGER.debug("getCode invoked: {}", code);
        return code;
    }

    public void setCode(String code) {
        LOGGER.debug("setCode invoked: {}", code);
        this.code = code;
    }

    public String getName() {
        LOGGER.debug("getName invoked: {}", name);
        return name;
    }

    public void setName(String name) {
        LOGGER.debug("setName invoked: {}", name);
        this.name = name;
    }

    @Override
    public String toString() {
        return "Country [code=" + code + ", name=" + name + "]";
    }
}
EOF

cat > $BASE/HandsOn1_SpringCoreBasics/src/main/java/com/cognizant/springlearn/SpringLearnApplication.java << 'EOF'
package com.cognizant.springlearn;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

@SpringBootApplication
public class SpringLearnApplication {

    private static final Logger LOGGER = LoggerFactory.getLogger(SpringLearnApplication.class);

    public static void main(String[] args) {
        LOGGER.info("START");
        SpringApplication.run(SpringLearnApplication.class, args);

        SpringLearnApplication app = new SpringLearnApplication();
        app.displayDate();
        app.displayCountry();
        app.displayCountries();
        LOGGER.info("END");
    }

    public void displayDate() {
        LOGGER.info("START");
        ApplicationContext context = new ClassPathXmlApplicationContext("date-format.xml");
        SimpleDateFormat format = context.getBean("dateFormat", SimpleDateFormat.class);
        try {
            Date date = format.parse("31/12/2018");
            LOGGER.debug(date.toString());
        } catch (ParseException e) {
            LOGGER.error("Error parsing date", e);
        }
        LOGGER.info("END");
    }

    public void displayCountry() {
        LOGGER.info("START");
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        Country country = context.getBean("country", Country.class);
        Country anotherCountry = context.getBean("country", Country.class);
        LOGGER.debug("Country : {}", country.toString());
        LOGGER.info("END");
    }

    public void displayCountries() {
        LOGGER.info("START");
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        List<Country> countryList = (List<Country>) context.getBean("countryList");
        for (Country country : countryList) {
            LOGGER.debug("Country : {}", country.toString());
        }
        LOGGER.info("END");
    }
}
EOF

echo "Creating HandsOn2 files..."

cat > $BASE/HandsOn2_RESTBasics_MockMVC/src/main/java/com/cognizant/springlearn/controller/HelloController.java << 'EOF'
package com.cognizant.springlearn.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    private static final Logger LOGGER = LoggerFactory.getLogger(HelloController.class);

    @GetMapping("/hello")
    public String sayHello() {
        LOGGER.info("START");
        LOGGER.info("END");
        return "Hello World!!";
    }
}
EOF

cat > $BASE/HandsOn2_RESTBasics_MockMVC/src/main/java/com/cognizant/springlearn/controller/CountryController.java << 'EOF'
package com.cognizant.springlearn.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cognizant.springlearn.Country;
import com.cognizant.springlearn.service.CountryService;
import com.cognizant.springlearn.service.exception.CountryNotFoundException;

@RestController
public class CountryController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CountryController.class);

    @Autowired
    private CountryService countryService;

    public CountryController() {
        LOGGER.info("CountryController created");
    }

    @RequestMapping("/country")
    public Country getCountryIndia() {
        LOGGER.info("START");
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        Country country = context.getBean("country", Country.class);
        LOGGER.info("END");
        return country;
    }

    @GetMapping("/countries")
    public List<Country> getAllCountries() {
        LOGGER.info("START");
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        List<Country> countryList = (List<Country>) context.getBean("countryList");
        LOGGER.info("END");
        return countryList;
    }

    @GetMapping("/countries/{code}")
    public Country getCountry(@PathVariable String code) throws CountryNotFoundException {
        LOGGER.info("START");
        Country country = countryService.getCountry(code);
        LOGGER.info("END");
        return country;
    }
}
EOF

mkdir -p $BASE/HandsOn2_RESTBasics_MockMVC/src/main/java/com/cognizant/springlearn/service

cat > $BASE/HandsOn2_RESTBasics_MockMVC/src/main/java/com/cognizant/springlearn/service/CountryService.java << 'EOF'
package com.cognizant.springlearn.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.cognizant.springlearn.Country;
import com.cognizant.springlearn.service.exception.CountryNotFoundException;

@Service
public class CountryService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CountryService.class);

    public Country getCountry(String code) throws CountryNotFoundException {
        LOGGER.info("START");
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        List<Country> countryList = (List<Country>) context.getBean("countryList");

        Country result = countryList.stream()
                .filter(c -> c.getCode().equalsIgnoreCase(code))
                .findFirst()
                .orElseThrow(CountryNotFoundException::new);

        LOGGER.info("END");
        return result;
    }
}
EOF

cat > $BASE/HandsOn2_RESTBasics_MockMVC/src/main/java/com/cognizant/springlearn/service/exception/CountryNotFoundException.java << 'EOF'
package com.cognizant.springlearn.service.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "Country not found")
public class CountryNotFoundException extends Exception {
    private static final long serialVersionUID = 1L;
}
EOF

cat > $BASE/HandsOn2_RESTBasics_MockMVC/src/test/java/com/cognizant/springlearn/SpringLearnApplicationTests.java << 'EOF'
package com.cognizant.springlearn;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;

import com.cognizant.springlearn.controller.CountryController;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class SpringLearnApplicationTests {

    @Autowired
    private CountryController countryController;

    @Autowired
    private MockMvc mvc;

    @Test
    public void contextLoads() {
        assertNotNull(countryController);
    }

    @Test
    public void testGetCountry() throws Exception {
        ResultActions actions = mvc.perform(get("/country"));
        actions.andExpect(status().isOk());
        actions.andExpect(jsonPath("$.code").exists());
        actions.andExpect(jsonPath("$.code").value("IN"));
        actions.andExpect(jsonPath("$.name").exists());
        actions.andExpect(jsonPath("$.name").value("India"));
    }

    @Test
    public void testGetCountryException() throws Exception {
        ResultActions actions = mvc.perform(get("/countries/zz"));
        actions.andExpect(status().isNotFound());
        actions.andExpect(status().reason("Country not found"));
    }
}
EOF

echo "Creating HandsOn3 files..."

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/resources/employee.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="hr" class="com.cognizant.springlearn.model.Department">
        <property name="id" value="1" />
        <property name="name" value="HR" />
    </bean>

    <bean id="it" class="com.cognizant.springlearn.model.Department">
        <property name="id" value="2" />
        <property name="name" value="IT" />
    </bean>

    <bean id="finance" class="com.cognizant.springlearn.model.Department">
        <property name="id" value="3" />
        <property name="name" value="Finance" />
    </bean>

    <bean id="java" class="com.cognizant.springlearn.model.Skill">
        <property name="id" value="1" />
        <property name="name" value="Java" />
    </bean>

    <bean id="spring" class="com.cognizant.springlearn.model.Skill">
        <property name="id" value="2" />
        <property name="name" value="Spring" />
    </bean>

    <bean id="employee1" class="com.cognizant.springlearn.model.Employee">
        <property name="id" value="1" />
        <property name="name" value="Alice" />
        <property name="salary" value="50000" />
        <property name="permanent" value="true" />
        <property name="department" ref="hr" />
    </bean>

    <bean id="employee2" class="com.cognizant.springlearn.model.Employee">
        <property name="id" value="2" />
        <property name="name" value="Bob" />
        <property name="salary" value="60000" />
        <property name="permanent" value="true" />
        <property name="department" ref="it" />
    </bean>

    <bean id="employee3" class="com.cognizant.springlearn.model.Employee">
        <property name="id" value="3" />
        <property name="name" value="Carol" />
        <property name="salary" value="55000" />
        <property name="permanent" value="false" />
        <property name="department" ref="finance" />
    </bean>

    <bean id="employee4" class="com.cognizant.springlearn.model.Employee">
        <property name="id" value="4" />
        <property name="name" value="David" />
        <property name="salary" value="65000" />
        <property name="permanent" value="true" />
        <property name="department" ref="it" />
    </bean>

    <bean id="employeeList" class="java.util.ArrayList">
        <constructor-arg>
            <list>
                <ref bean="employee1" />
                <ref bean="employee2" />
                <ref bean="employee3" />
                <ref bean="employee4" />
            </list>
        </constructor-arg>
    </bean>

    <bean id="departmentList" class="java.util.ArrayList">
        <constructor-arg>
            <list>
                <ref bean="hr" />
                <ref bean="it" />
                <ref bean="finance" />
            </list>
        </constructor-arg>
    </bean>

</beans>
EOF

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/model/Department.java << 'EOF'
package com.cognizant.springlearn.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Department {

    @NotNull
    private Long id;

    @NotNull
    @NotBlank
    @Size(min = 1, max = 30)
    private String name;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}
EOF

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/model/Skill.java << 'EOF'
package com.cognizant.springlearn.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Skill {

    @NotNull
    private Long id;

    @NotNull
    @NotBlank
    @Size(min = 1, max = 30)
    private String name;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}
EOF

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/model/Employee.java << 'EOF'
package com.cognizant.springlearn.model;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Employee {

    @NotNull
    private Long id;

    @NotNull
    @NotBlank
    @Size(min = 1, max = 30)
    private String name;

    @NotNull
    @Min(0)
    private Double salary;

    @NotNull
    private Boolean permanent;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy")
    private Date dateOfBirth;

    private Department department;
    private List<Skill> skills;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Double getSalary() { return salary; }
    public void setSalary(Double salary) { this.salary = salary; }
    public Boolean getPermanent() { return permanent; }
    public void setPermanent(Boolean permanent) { this.permanent = permanent; }
    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }
    public List<Skill> getSkills() { return skills; }
    public void setSkills(List<Skill> skills) { this.skills = skills; }
}
EOF

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/dao/EmployeeDao.java << 'EOF'
package com.cognizant.springlearn.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Repository;

import com.cognizant.springlearn.model.Employee;
import com.cognizant.springlearn.service.exception.EmployeeNotFoundException;

@Repository
public class EmployeeDao {

    private static final Logger LOGGER = LoggerFactory.getLogger(EmployeeDao.class);
    private static ArrayList<Employee> EMPLOYEE_LIST;

    public EmployeeDao() {
        LOGGER.info("START");
        ApplicationContext context = new ClassPathXmlApplicationContext("employee.xml");
        EMPLOYEE_LIST = (ArrayList<Employee>) context.getBean("employeeList");
        LOGGER.info("END");
    }

    public List<Employee> getAllEmployees() {
        return EMPLOYEE_LIST;
    }

    public void updateEmployee(Employee employee) throws EmployeeNotFoundException {
        for (int i = 0; i < EMPLOYEE_LIST.size(); i++) {
            if (EMPLOYEE_LIST.get(i).getId().equals(employee.getId())) {
                EMPLOYEE_LIST.set(i, employee);
                return;
            }
        }
        throw new EmployeeNotFoundException();
    }

    public void deleteEmployee(Long id) throws EmployeeNotFoundException {
        boolean removed = EMPLOYEE_LIST.removeIf(e -> e.getId().equals(id));
        if (!removed) {
            throw new EmployeeNotFoundException();
        }
    }
}
EOF

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/dao/DepartmentDao.java << 'EOF'
package com.cognizant.springlearn.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Repository;

import com.cognizant.springlearn.model.Department;

@Repository
public class DepartmentDao {

    private static final Logger LOGGER = LoggerFactory.getLogger(DepartmentDao.class);
    private static ArrayList<Department> DEPARTMENT_LIST;

    public DepartmentDao() {
        LOGGER.info("START");
        ApplicationContext context = new ClassPathXmlApplicationContext("employee.xml");
        DEPARTMENT_LIST = (ArrayList<Department>) context.getBean("departmentList");
        LOGGER.info("END");
    }

    public List<Department> getAllDepartments() {
        return DEPARTMENT_LIST;
    }
}
EOF

mkdir -p $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/service

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/service/EmployeeService.java << 'EOF'
package com.cognizant.springlearn.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cognizant.springlearn.dao.EmployeeDao;
import com.cognizant.springlearn.model.Employee;
import com.cognizant.springlearn.service.exception.EmployeeNotFoundException;

@Service
public class EmployeeService {

    private static final Logger LOGGER = LoggerFactory.getLogger(EmployeeService.class);

    @Autowired
    private EmployeeDao employeeDao;

    @Transactional
    public List<Employee> getAllEmployees() {
        LOGGER.info("START");
        List<Employee> result = employeeDao.getAllEmployees();
        LOGGER.info("END");
        return result;
    }

    public void updateEmployee(Employee employee) throws EmployeeNotFoundException {
        LOGGER.info("START");
        employeeDao.updateEmployee(employee);
        LOGGER.info("END");
    }

    public void deleteEmployee(Long id) throws EmployeeNotFoundException {
        LOGGER.info("START");
        employeeDao.deleteEmployee(id);
        LOGGER.info("END");
    }
}
EOF

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/service/DepartmentService.java << 'EOF'
package com.cognizant.springlearn.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cognizant.springlearn.dao.DepartmentDao;
import com.cognizant.springlearn.model.Department;

@Service
public class DepartmentService {

    private static final Logger LOGGER = LoggerFactory.getLogger(DepartmentService.class);

    @Autowired
    private DepartmentDao departmentDao;

    public List<Department> getAllDepartments() {
        LOGGER.info("START");
        List<Department> result = departmentDao.getAllDepartments();
        LOGGER.info("END");
        return result;
    }
}
EOF

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/service/exception/EmployeeNotFoundException.java << 'EOF'
package com.cognizant.springlearn.service.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "Employee not found")
public class EmployeeNotFoundException extends Exception {
    private static final long serialVersionUID = 1L;
}
EOF

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/controller/EmployeeController.java << 'EOF'
package com.cognizant.springlearn.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cognizant.springlearn.model.Employee;
import com.cognizant.springlearn.service.EmployeeService;
import com.cognizant.springlearn.service.exception.EmployeeNotFoundException;

import javax.validation.Valid;

@RestController
@RequestMapping("/employees")
public class EmployeeController {

    private static final Logger LOGGER = LoggerFactory.getLogger(EmployeeController.class);

    @Autowired
    private EmployeeService employeeService;

    @GetMapping
    public List<Employee> getAllEmployees() {
        LOGGER.info("START");
        List<Employee> result = employeeService.getAllEmployees();
        LOGGER.info("END");
        return result;
    }

    @PutMapping
    public void updateEmployee(@RequestBody @Valid Employee employee) throws EmployeeNotFoundException {
        LOGGER.info("START");
        employeeService.updateEmployee(employee);
        LOGGER.info("END");
    }

    @DeleteMapping("/{id}")
    public void deleteEmployee(@PathVariable Long id) throws EmployeeNotFoundException {
        LOGGER.info("START");
        employeeService.deleteEmployee(id);
        LOGGER.info("END");
    }
}
EOF

cat > $BASE/HandsOn3_EmployeeDepartmentREST/src/main/java/com/cognizant/springlearn/controller/DepartmentController.java << 'EOF'
package com.cognizant.springlearn.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cognizant.springlearn.model.Department;
import com.cognizant.springlearn.service.DepartmentService;

@RestController
@RequestMapping("/departments")
public class DepartmentController {

    private static final Logger LOGGER = LoggerFactory.getLogger(DepartmentController.class);

    @Autowired
    private DepartmentService departmentService;

    @GetMapping
    public List<Department> getAllDepartments() {
        LOGGER.info("START");
        List<Department> result = departmentService.getAllDepartments();
        LOGGER.info("END");
        return result;
    }
}
EOF

echo "Creating HandsOn4 files..."

cat > $BASE/HandsOn4_POSTPUTDELETEValidation/src/main/java/com/cognizant/springlearn/GlobalExceptionHandler.java << 'EOF'
package com.cognizant.springlearn;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import com.fasterxml.jackson.databind.exc.InvalidFormatException;

@ControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
            HttpHeaders headers, HttpStatus status, WebRequest request) {
        LOGGER.info("Start");

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("timestamp", new Date());
        body.put("status", status.value());

        List<String> errors = ex.getBindingResult().getFieldErrors().stream()
                .map(x -> x.getDefaultMessage())
                .collect(Collectors.toList());

        body.put("errors", errors);

        LOGGER.info("End");
        return new ResponseEntity<>(body, headers, status);
    }

    @Override
    protected ResponseEntity<Object> handleHttpMessageNotReadable(
            org.springframework.http.converter.HttpMessageNotReadableException ex, HttpHeaders headers,
            HttpStatus status, WebRequest request) {

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("timestamp", new Date());
        body.put("status", status.value());
        body.put("error", "Bad Request");

        List<String> errors = new ArrayList<>();
        if (ex.getCause() instanceof InvalidFormatException) {
            final Throwable cause = ex.getCause() == null ? ex : ex.getCause();
            for (InvalidFormatException.Reference reference : ((InvalidFormatException) cause).getPath()) {
                body.put("message", "Incorrect format for field '" + reference.getFieldName() + "'");
            }
        }

        return new ResponseEntity<>(body, headers, status);
    }
}
EOF

cat > $BASE/HandsOn4_POSTPUTDELETEValidation/src/main/java/com/cognizant/springlearn/controller/CountryController_AddMethod.txt << 'EOF'
// Add this method inside the existing CountryController class:

import javax.validation.Valid;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@PostMapping("/countries")
public Country addCountry(@RequestBody @Valid Country country) {
    LOGGER.info("Start");
    LOGGER.debug("Country received: {}", country.toString());
    LOGGER.info("End");
    return country;
}
EOF

echo "Creating HandsOn5 files..."

cat > $BASE/HandsOn5_JWT/pom_additions.xml << 'EOF'
<!-- Add these dependencies to pom.xml -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
<dependency>
    <groupId>io.jsonwebtoken</groupId>
    <artifactId>jjwt</artifactId>
    <version>0.9.0</version>
</dependency>
EOF

cat > $BASE/HandsOn5_JWT/src/main/java/com/cognizant/springlearn/security/SecurityConfig.java << 'EOF'
package com.cognizant.springlearn.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private static final Logger LOGGER = LoggerFactory.getLogger(SecurityConfig.class);

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.inMemoryAuthentication()
            .withUser("admin").password(passwordEncoder().encode("pwd")).roles("ADMIN")
            .and()
            .withUser("user").password(passwordEncoder().encode("pwd")).roles("USER");
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        LOGGER.info("Start");
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity.csrf().disable().httpBasic().and()
            .authorizeRequests()
            .antMatchers("/authenticate").hasAnyRole("USER", "ADMIN")
            .anyRequest().authenticated()
            .and()
            .addFilter(new JwtAuthorizationFilter(authenticationManager()));
    }

    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}
EOF

cat > $BASE/HandsOn5_JWT/src/main/java/com/cognizant/springlearn/security/JwtAuthorizationFilter.java << 'EOF'
package com.cognizant.springlearn.security;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;

public class JwtAuthorizationFilter extends BasicAuthenticationFilter {

    private static final Logger LOGGER = LoggerFactory.getLogger(JwtAuthorizationFilter.class);

    public JwtAuthorizationFilter(AuthenticationManager authenticationManager) {
        super(authenticationManager);
        LOGGER.info("Start");
        LOGGER.debug("{}: ", authenticationManager);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res,
            FilterChain chain) throws IOException, ServletException {
        LOGGER.info("Start");
        String header = req.getHeader("Authorization");
        LOGGER.debug(header);

        if (header == null || !header.startsWith("Bearer ")) {
            chain.doFilter(req, res);
            return;
        }

        UsernamePasswordAuthenticationToken authentication = getAuthentication(req);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        chain.doFilter(req, res);
        LOGGER.info("End");
    }

    private UsernamePasswordAuthenticationToken getAuthentication(HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if (token != null) {
            Jws<Claims> jws;
            try {
                jws = Jwts.parser()
                        .setSigningKey("secretkey")
                        .parseClaimsJws(token.replace("Bearer ", ""));
                String user = jws.getBody().getSubject();
                LOGGER.debug(user);
                if (user != null) {
                    return new UsernamePasswordAuthenticationToken(user, null, new ArrayList<>());
                }
            } catch (JwtException ex) {
                return null;
            }
            return null;
        }
        return null;
    }
}
EOF

cat > $BASE/HandsOn5_JWT/src/main/java/com/cognizant/springlearn/controller/AuthenticationController.java << 'EOF'
package com.cognizant.springlearn.controller;

import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@RestController
public class AuthenticationController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AuthenticationController.class);

    @GetMapping("/authenticate")
    public Map<String, String> authenticate(@RequestHeader("Authorization") String authHeader) {
        LOGGER.info("Start");
        LOGGER.debug(authHeader);

        Map<String, String> map = new HashMap<>();
        String user = getUser(authHeader);
        String token = generateJwt(user);
        map.put("token", token);

        LOGGER.info("End");
        return map;
    }

    private String getUser(String authHeader) {
        LOGGER.debug(authHeader);
        String encodedCredentials = authHeader.replace("Basic ", "");
        byte[] decodedBytes = Base64.getDecoder().decode(encodedCredentials);
        String decodedString = new String(decodedBytes);
        String user = decodedString.substring(0, decodedString.indexOf(":"));
        LOGGER.debug(user);
        return user;
    }

    private String generateJwt(String user) {
        JwtBuilder builder = Jwts.builder();
        builder.setSubject(user);
        builder.setIssuedAt(new Date());
        builder.setExpiration(new Date((new Date()).getTime() + 1200000));
        builder.signWith(SignatureAlgorithm.HS256, "secretkey");

        String token = builder.compact();
        return token;
    }
}
EOF

echo "Creating README..."

cat > $BASE/README.md << 'EOF'
# Spring REST and JWT Hands-On Exercises

| HandsOn | Topic |
|---|---|
| 1 | Spring Core Basics (XML config, beans, scopes, logging) |
| 2 | REST Basics + MockMVC testing |
| 3 | Employee/Department REST services |
| 4 | POST/PUT/DELETE with validation + global exception handling |
| 5 | JWT Authentication with Spring Security |

Note: This is one progressive project (`spring-learn`). Each HandsOn folder contains the files relevant to that stage — later folders assume earlier files are also present in the real project. Some files (like `CountryController_AddMethod.txt` and `pom_additions.xml`) are snippets to merge into existing files rather than standalone files.
EOF

echo "All done! Folders and files created successfully."
echo "Now run: git add . && git commit -m 'Add Spring REST and JWT handson exercises' && git push origin main"
