CREATE TABLE department (
                            dname        VARCHAR(15) NOT NULL,
                            dnumber      INT,
                            mgrssn       CHAR(9) NOT NULL,
                            mgrstartdate DATE,
                            PRIMARY KEY (dnumber),
                            UNIQUE (dname)
);

CREATE TABLE employee (
                          fname    VARCHAR(15) NOT NULL,
                          minit    VARCHAR(1),
                          lname    VARCHAR(15) NOT NULL,
                          ssn      CHAR(9),
                          bdate    DATE,
                          address  VARCHAR(30),
                          sex      CHAR,
                          salary   DECIMAL(10,2),
                          superssn CHAR(9),
                          dno      INT,
                          PRIMARY KEY (ssn)
);

CREATE TABLE dept_locations (
                                dnumber   INT,
                                dlocation VARCHAR(15),
                                PRIMARY KEY (dnumber, dlocation),
                                FOREIGN KEY (dnumber) REFERENCES department(dnumber)
);

CREATE TABLE project (
                         pname      VARCHAR(15) NOT NULL,
                         pnumber    INT,
                         plocation  VARCHAR(15),
                         dnum       INT NOT NULL,
                         PRIMARY KEY (pnumber),
                         UNIQUE (pname),
                         FOREIGN KEY (dnum) REFERENCES department(dnumber)
);

CREATE TABLE works_on (
                          essn   CHAR(9),
                          pno    INT,
                          hours  DECIMAL(4,1),
                          PRIMARY KEY (essn, pno),
                          FOREIGN KEY (essn) REFERENCES employee(ssn),
                          FOREIGN KEY (pno) REFERENCES project(pnumber)
);

CREATE TABLE dependent (
                           essn           CHAR(9),
                           dependent_name VARCHAR(15),
                           sex            CHAR,
                           bdate          DATE,
                           relationship   VARCHAR(8),
                           PRIMARY KEY (essn, dependent_name),
                           FOREIGN KEY (essn) REFERENCES employee(ssn)
);

-- Thêm khóa ngoại vào bảng Department
ALTER TABLE Department
    ADD CONSTRAINT FK_Department_MgrSSN FOREIGN KEY (MgrSSN) REFERENCES Employee(SSN);

-- Thêm khóa ngoại vào bảng Employee
ALTER TABLE Employee
    ADD CONSTRAINT FK_Employee_SuperSSN FOREIGN KEY (SuperSSN) REFERENCES Employee(SSN);


SET FOREIGN_KEY_CHECKS = 0;
# DELETE FROM works_on;
# DELETE FROM dependent;
# DELETE FROM project;
# DELETE FROM dept_locations;
# DELETE FROM employee;
# DELETE FROM department;

INSERT INTO department VALUES
                           ('Research', 5, '333445555', '1978-05-22'),
                           ('Administration', 4, '987654321', '1985-01-01'),
                           ('Headquarters', 1, '888665555', '1971-06-19');

INSERT INTO employee VALUES
                         ('James', 'E', 'Borg', '888665555', '1927-11-10', 'Houston,TX', 'M', 55000, null, null),
                         ('Frank', 'T', 'Wong', '333445555', '1945-12-08', 'Houston,TX', 'M', 40000, '888665555', null),
                         ('Jennifer', 'S', 'Wallace', '987654321', '1931-06-20', 'Bellaire,TX', 'F', 43000, '888665555', null),
                         ('John', 'B', 'Smith', '123456789', '1955-01-09', 'Houston,TX', 'M', 30000, '333445555', 5),
                         ('Alicia', 'J', 'Zelaya', '999887777', '1958-07-19', 'Spring,TX', 'F', 25000, '987654321', 4),
                         ('Ramesh', 'K', 'Narayan', '666884444', '1952-09-15', 'Humble,TX', 'M', 38000, '333445555', 5),
                         ('Joyce', 'A', 'English', '453453453', '1962-07-31', 'Houston,TX', 'F', 25000, '333445555', 5),
                         ('Ahmad', 'V', 'Jabbar', '987987987', '1959-03-29', 'Houston,TX', 'M', 25000, '987654321', 4);

INSERT INTO dept_locations VALUES (1, 'Houston');
INSERT INTO dept_locations VALUES (4, 'Stafford');
INSERT INTO dept_locations VALUES (5, 'Bellaire');
INSERT INTO dept_locations VALUES (5, 'Sugarland');
INSERT INTO dept_locations VALUES (5, 'Houston');

INSERT INTO dependent VALUES
                          ('333445555', 'Alice', 'F', '1976-04-05', 'Daughter'),
                          ('333445555', 'Theodore', 'M', '1973-10-25', 'Son'),
                          ('333445555', 'Joy', 'F', '1948-05-03', 'Spouse'),
                          ('987654321', 'Abner', 'M', '1932-02-29', 'Spouse'),
                          ('123456789', 'Michael', 'M', '1978-01-01', 'Son'),
                          ('123456789', 'Alice', 'F', '1978-12-31', 'Daughter'),
                          ('123456789', 'Elizabeth', 'F', '1957-05-05', 'Spouse');

INSERT INTO project VALUES ('ProductX', 1, 'Bellaire',  5);
INSERT INTO project VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO project VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO project VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO project VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO project VALUES ('Newbenefits', 30,  'Stafford', 4);

INSERT INTO works_on VALUES
                         ('123456789', 1, 32.5),
                         ('123456789', 2, 7.5),
                         ('666884444', 3, 40.0),
                         ('453453453', 1, 20.0),
                         ('453453453', 2, 20.0),
                         ('333445555', 2, 10.0),
                         ('333445555', 3, 10.0),
                         ('333445555', 10, 10.0),
                         ('333445555', 20, 10.0),
                         ('999887777', 30, 30.0),
                         ('999887777', 10, 10.0),
                         ('987987987', 10, 35.0),
                         ('987987987', 30, 5.0),
                         ('987654321', 30, 20.0),
                         ('987654321', 20, 15.0),
                         ('888665555', 20, null);

# INSERT INTO department VALUES
#                            ('Research', 5, '333445555', STR_TO_DATE('22-MAY-78', '%d-%b-%y')),
#                            ('Administration', 4, '987654321', STR_TO_DATE('01-JAN-85', '%d-%b-%y')),
#                            ('Headquarters', 1, '888665555', STR_TO_DATE('19-JUN-71', '%d-%b-%y'));
#
# INSERT INTO employee VALUES
#                          ('James', 'E', 'Borg', '888665555', STR_TO_DATE('10-NOV-27', '%d-%b-%y'), 'Houston,TX', 'M', 55000, null, null),
#                          ('Frank', 'T', 'Wong', '333445555', STR_TO_DATE('08-DEC-45', '%d-%b-%y'), 'Houston,TX', 'M', 40000, '888665555', null),
#                          ('Jennifer', 'S', 'Wallace', '987654321', STR_TO_DATE('20-JUN-31', '%d-%b-%y'), 'Bellaire,TX', 'F', 43000, '888665555', null);

SET FOREIGN_KEY_CHECKS = 1;

# Write a trigger for ensuring that the employee’s ages must be between 18 and 60
CREATE TRIGGER CheckEmployeeAge
    BEFORE INSERT ON employee
    FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.bdate, CURDATE()) < 18 OR TIMESTAMPDIFF(YEAR, NEW.bdate, CURDATE()) > 60 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Employee age must be between 18 and 60.';
    END IF;
END;

# Write a trigger to enforce that when an employee has a
# new project, his or her salary will be increased by 10% *
# number of hours per week working on that project

CREATE TRIGGER IncreaseSalaryOnNewProject
    AFTER INSERT ON works_on
    FOR EACH ROW
BEGIN
    DECLARE increase_amount DECIMAL(10, 2);

    -- Calculate the salary increase: 10% * number of hours per week (assuming 40 hours is full-time)
    SET increase_amount = NEW.hours * 0.1;

    -- Update the employee's salary
    UPDATE employee
    SET salary = salary + increase_amount
    WHERE ssn = NEW.essn;
END;


# Write a store procedure to read an employee’s id and
# print the names of his/her dependents
CREATE PROCEDURE GetDependents(IN emp_id CHAR(9))
BEGIN
    SELECT dependent_name
    FROM dependent
    WHERE essn = emp_id;
END;

# Write a function to read a project’s id and return the total
# number of employees who work for that project
SET GLOBAL log_bin_trust_function_creators = 1;
CREATE FUNCTION TotalEmployeesOnProject (project_id INT)
    RETURNS INT
BEGIN
    DECLARE total_employees INT;

    SELECT COUNT(DISTINCT essn) INTO total_employees
    FROM works_on
    WHERE pno = project_id;

    RETURN IFNULL(total_employees, 0);
END;

SELECT TotalEmployeesOnProject(10);