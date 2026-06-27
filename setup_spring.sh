#!/bin/bash
# Run this with: bash setup_spring.sh
# Creates the Spring_Core_Maven folder structure with all code filled in.

echo "Creating folders..."

BASE="Spring_Core_Maven"

mkdir -p $BASE/Exercise1_BasicSpringApp/src/main/java/com/library/service
mkdir -p $BASE/Exercise1_BasicSpringApp/src/main/java/com/library/repository
mkdir -p $BASE/Exercise1_BasicSpringApp/src/main/java/com/library
mkdir -p $BASE/Exercise1_BasicSpringApp/src/main/resources

mkdir -p $BASE/Exercise2_DependencyInjection/src/main/java/com/library/service
mkdir -p $BASE/Exercise2_DependencyInjection/src/main/java/com/library/repository
mkdir -p $BASE/Exercise2_DependencyInjection/src/main/resources

mkdir -p $BASE/Exercise3_LoggingWithAOP/src/main/java/com/library/aspect
mkdir -p $BASE/Exercise3_LoggingWithAOP/src/main/resources

mkdir -p $BASE/Exercise4_MavenProjectSetup

mkdir -p $BASE/Exercise5_IoCContainer/src/main/resources

mkdir -p $BASE/Exercise6_AnnotationConfig/src/main/java/com/library/service
mkdir -p $BASE/Exercise6_AnnotationConfig/src/main/java/com/library/repository
mkdir -p $BASE/Exercise6_AnnotationConfig/src/main/resources

mkdir -p $BASE/Exercise7_ConstructorSetterInjection/src/main/java/com/library/service
mkdir -p $BASE/Exercise7_ConstructorSetterInjection/src/main/resources

mkdir -p $BASE/Exercise8_BasicAOP/src/main/java/com/library/aspect
mkdir -p $BASE/Exercise8_BasicAOP/src/main/resources

mkdir -p $BASE/Exercise9_SpringBootApp/src/main/java/com/library/model
mkdir -p $BASE/Exercise9_SpringBootApp/src/main/java/com/library/repository
mkdir -p $BASE/Exercise9_SpringBootApp/src/main/java/com/library/controller
mkdir -p $BASE/Exercise9_SpringBootApp/src/main/resources

echo "Creating Exercise 1 files..."

cat > $BASE/Exercise1_BasicSpringApp/pom.xml << 'EOF'
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.library</groupId>
    <artifactId>LibraryManagement</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <properties>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>5.3.30</version>
        </dependency>
    </dependencies>
</project>
EOF

cat > $BASE/Exercise1_BasicSpringApp/src/main/resources/applicationContext.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="bookRepository" class="com.library.repository.BookRepository" />

    <bean id="bookService" class="com.library.service.BookService" />

</beans>
EOF

cat > $BASE/Exercise1_BasicSpringApp/src/main/java/com/library/repository/BookRepository.java << 'EOF'
package com.library.repository;

public class BookRepository {

    public String getBookDetails() {
        return "Book: Effective Java, Author: Joshua Bloch";
    }
}
EOF

cat > $BASE/Exercise1_BasicSpringApp/src/main/java/com/library/service/BookService.java << 'EOF'
package com.library.service;

public class BookService {

    public void showBookInfo() {
        System.out.println("BookService is up and running.");
    }
}
EOF

cat > $BASE/Exercise1_BasicSpringApp/src/main/java/com/library/MainApp.java << 'EOF'
package com.library;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.library.service.BookService;

public class MainApp {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService bookService = (BookService) context.getBean("bookService");
        bookService.showBookInfo();
    }
}
EOF

echo "Creating Exercise 2 files..."

cat > $BASE/Exercise2_DependencyInjection/src/main/resources/applicationContext.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="bookRepository" class="com.library.repository.BookRepository" />

    <bean id="bookService" class="com.library.service.BookService">
        <property name="bookRepository" ref="bookRepository" />
    </bean>

</beans>
EOF

cat > $BASE/Exercise2_DependencyInjection/src/main/java/com/library/repository/BookRepository.java << 'EOF'
package com.library.repository;

public class BookRepository {

    public String getBookDetails() {
        return "Book: Effective Java, Author: Joshua Bloch";
    }
}
EOF

cat > $BASE/Exercise2_DependencyInjection/src/main/java/com/library/service/BookService.java << 'EOF'
package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void showBookInfo() {
        System.out.println(bookRepository.getBookDetails());
    }
}
EOF

echo "Creating Exercise 3 files..."

cat > $BASE/Exercise3_LoggingWithAOP/pom.xml << 'EOF'
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.library</groupId>
    <artifactId>LibraryManagement</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <properties>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>5.3.30</version>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-aop</artifactId>
            <version>5.3.30</version>
        </dependency>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
            <version>1.9.20</version>
        </dependency>
    </dependencies>
</project>
EOF

cat > $BASE/Exercise3_LoggingWithAOP/src/main/java/com/library/aspect/LoggingAspect.java << 'EOF'
package com.library.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class LoggingAspect {

    @Around("execution(* com.library.service.*.*(..))")
    public Object logExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable {
        long start = System.currentTimeMillis();
        Object result = joinPoint.proceed();
        long end = System.currentTimeMillis();
        System.out.println(joinPoint.getSignature() + " executed in " + (end - start) + "ms");
        return result;
    }
}
EOF

cat > $BASE/Exercise3_LoggingWithAOP/src/main/resources/applicationContext.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/aop
       http://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean id="bookRepository" class="com.library.repository.BookRepository" />

    <bean id="bookService" class="com.library.service.BookService">
        <property name="bookRepository" ref="bookRepository" />
    </bean>

    <bean id="loggingAspect" class="com.library.aspect.LoggingAspect" />

    <aop:aspectj-autoproxy />

</beans>
EOF

echo "Creating Exercise 4 files..."

cat > $BASE/Exercise4_MavenProjectSetup/pom.xml << 'EOF'
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.library</groupId>
    <artifactId>LibraryManagement</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <properties>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>5.3.30</version>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-aop</artifactId>
            <version>5.3.30</version>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>5.3.30</version>
        </dependency>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
            <version>1.9.20</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
EOF

echo "Creating Exercise 5 files..."

cat > $BASE/Exercise5_IoCContainer/src/main/resources/applicationContext.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="bookRepository" class="com.library.repository.BookRepository" />

    <bean id="bookService" class="com.library.service.BookService">
        <property name="bookRepository" ref="bookRepository" />
    </bean>

</beans>
EOF

echo "Creating Exercise 6 files..."

cat > $BASE/Exercise6_AnnotationConfig/src/main/resources/applicationContext.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context
       http://www.springframework.org/schema/context/spring-context.xsd
       http://www.springframework.org/schema/aop
       http://www.springframework.org/schema/aop/spring-aop.xsd">

    <context:component-scan base-package="com.library" />

    <bean id="loggingAspect" class="com.library.aspect.LoggingAspect" />
    <aop:aspectj-autoproxy />

</beans>
EOF

cat > $BASE/Exercise6_AnnotationConfig/src/main/java/com/library/repository/BookRepository.java << 'EOF'
package com.library.repository;

import org.springframework.stereotype.Repository;

@Repository
public class BookRepository {

    public String getBookDetails() {
        return "Book: Effective Java, Author: Joshua Bloch";
    }
}
EOF

cat > $BASE/Exercise6_AnnotationConfig/src/main/java/com/library/service/BookService.java << 'EOF'
package com.library.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.library.repository.BookRepository;

@Service
public class BookService {

    private BookRepository bookRepository;

    @Autowired
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void showBookInfo() {
        System.out.println(bookRepository.getBookDetails());
    }
}
EOF

echo "Creating Exercise 7 files..."

cat > $BASE/Exercise7_ConstructorSetterInjection/src/main/java/com/library/service/BookService.java << 'EOF'
package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository bookRepository;

    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void showBookInfo() {
        System.out.println(bookRepository.getBookDetails());
    }
}
EOF

cat > $BASE/Exercise7_ConstructorSetterInjection/src/main/resources/applicationContext.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="bookRepository" class="com.library.repository.BookRepository" />

    <bean id="bookService" class="com.library.service.BookService">
        <constructor-arg ref="bookRepository" />
        <property name="bookRepository" ref="bookRepository" />
    </bean>

</beans>
EOF

echo "Creating Exercise 8 files..."

cat > $BASE/Exercise8_BasicAOP/src/main/java/com/library/aspect/LoggingAspect.java << 'EOF'
package com.library.aspect;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

@Aspect
public class LoggingAspect {

    @Before("execution(* com.library.service.*.*(..))")
    public void logBefore() {
        System.out.println("LOG: Method execution started.");
    }

    @After("execution(* com.library.service.*.*(..))")
    public void logAfter() {
        System.out.println("LOG: Method execution finished.");
    }
}
EOF

cat > $BASE/Exercise8_BasicAOP/src/main/resources/applicationContext.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/aop
       http://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean id="bookRepository" class="com.library.repository.BookRepository" />

    <bean id="bookService" class="com.library.service.BookService">
        <property name="bookRepository" ref="bookRepository" />
    </bean>

    <bean id="loggingAspect" class="com.library.aspect.LoggingAspect" />

    <aop:aspectj-autoproxy />

</beans>
EOF

echo "Creating Exercise 9 files..."

cat > $BASE/Exercise9_SpringBootApp/pom.xml << 'EOF'
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.18</version>
    </parent>

    <groupId>com.library</groupId>
    <artifactId>LibraryManagement</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>

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
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
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

cat > $BASE/Exercise9_SpringBootApp/src/main/resources/application.properties << 'EOF'
spring.datasource.url=jdbc:h2:mem:librarydb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.h2.console.enabled=true
spring.jpa.hibernate.ddl-auto=update
EOF

cat > $BASE/Exercise9_SpringBootApp/src/main/java/com/library/model/Book.java << 'EOF'
package com.library.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String title;
    private String author;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
}
EOF

cat > $BASE/Exercise9_SpringBootApp/src/main/java/com/library/repository/BookRepository.java << 'EOF'
package com.library.repository;

import com.library.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookRepository extends JpaRepository<Book, Long> {
}
EOF

cat > $BASE/Exercise9_SpringBootApp/src/main/java/com/library/controller/BookController.java << 'EOF'
package com.library.controller;

import com.library.model.Book;
import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookRepository bookRepository;

    @GetMapping
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    @PostMapping
    public Book addBook(@RequestBody Book book) {
        return bookRepository.save(book);
    }

    @GetMapping("/{id}")
    public Book getBookById(@PathVariable Long id) {
        return bookRepository.findById(id).orElse(null);
    }

    @DeleteMapping("/{id}")
    public void deleteBook(@PathVariable Long id) {
        bookRepository.deleteById(id);
    }
}
EOF

cat > $BASE/Exercise9_SpringBootApp/src/main/java/com/library/LibraryManagementApplication.java << 'EOF'
package com.library;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class LibraryManagementApplication {
    public static void main(String[] args) {
        SpringApplication.run(LibraryManagementApplication.class, args);
    }
}
EOF

echo "Creating README..."

cat > $BASE/README.md << 'EOF'
# Spring Core and Maven Exercises

Solutions for the library management Spring exercises.

| Exercise | Topic |
|---|---|
| 1 | Configuring a Basic Spring Application |
| 2 | Implementing Dependency Injection |
| 3 | Implementing Logging with Spring AOP |
| 4 | Creating and Configuring a Maven Project |
| 5 | Configuring the Spring IoC Container |
| 6 | Configuring Beans with Annotations |
| 7 | Implementing Constructor and Setter Injection |
| 8 | Implementing Basic AOP with Spring |
| 9 | Creating a Spring Boot Application |
EOF

echo "All done! Folders and files created successfully."
echo "Now run: git add . && git commit -m 'Add Spring Core and Maven exercises' && git push origin main"
