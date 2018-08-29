CREATE TABLE `Employees` (
  `Employee_ID` int auto_increment ,
  `FirstName` varchar(30),
  `LastName` varchar(30),
  `gender` varchar(20),
  `salary` int,
  `SSN` varchar(11),
  `email` varchar(50),
  `street` varchar(50),
  `apt` varchar(50),
  `city` varchar(30),
  `zip` int,
  `state` varchar(30),
  `telephone` varchar(12),
  `Company` varchar(50),
  `role` varchar(30),
  PRIMARY KEY(Employee_ID)
);
CREATE TABLE `University` (
  `University_ID` int auto_increment,
  `name` varchar(50),
  `Employee_ID` int,
  PRIMARY KEY (University_ID),
  FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
  );
  CREATE TABLE `Department` (
  `Department_ID` int auto_increment,
  `University_ID` int,
  `name` varchar(100),
  PRIMARY KEY (Department_ID),
  FOREIGN KEY (University_ID) REFERENCES University(University_ID)
);
CREATE TABLE `Books` (
  `ISBN` bigint,
  `bookTitle` varchar(200),
  `type` varchar(5) check (type IN ('new','used')),
  `purchasetype` varchar(20)check (purchasetype IN ('buy','rent')),
  `price` DECIMAL(8,2),
  `quantity` int,
  `language` varchar(40),
  `published` int,
  `ISBN-13` varchar(40),
  `publisher` varchar(40),
  `editionNumber` int,
  `format` varchar(40) check (format IN ('hardcover','paperback' , 'electronic')),
  `weight` DECIMAL(20,20),
  `avgRating` DECIMAL(6,2),
  `category` varchar(100),
  PRIMARY KEY (ISBN)
);

CREATE TABLE `Cart` (
  `Cart_ID` int auto_increment,
  `date_created` varchar(10),
  `date_updated` varchar(10),
  PRIMARY KEY (Cart_ID)
);
CREATE TABLE `Student` (
  `Student_ID` int auto_increment,
  `FirstName` varchar(50),
  `LastName` varchar(50),
  `email` varchar(60),
  `street` varchar(50),
  `city` varchar(50),
  `state` varchar(60),
  `telephone` varchar(50),
  `BirthDate` varchar(12),
  `University_Id` int,
  `major` varchar(50),
  `studentStatus` varchar(50) check (studentstatus IN ('graduate','undergraduate')),
  `year` int,
  `Cart_ID` int,
  PRIMARY KEY (Student_ID),
  FOREIGN KEY (University_ID) REFERENCES university(University_ID),
  FOREIGN KEY (Cart_ID) REFERENCES cart(Cart_ID)
  );
CREATE TABLE `Orders` (
  `Order_ID` int auto_increment, 
  `Student_ID` int,
  `dateCreated` varchar(12),
  `date_fulfilled` varchar(12),
  `credit_number` varchar(50),
  `credit_name` varchar(50),
  `credit_expiration` varchar(12),
  `credit_type` varchar(40),
  `status` varchar(40)  check (status IN('new','processed','awaiting shipping','shipped','canceled')),
  `shipping_type` varchar(30) check (shipping_type IN ('standard','2-day','1-day')),
  PRIMARY KEY (Order_ID),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

CREATE TABLE `cartItems` (
  `cart_Item_ID` int auto_increment,
  `cart_ID` int,
  `ISBN` bigint,
  `type` varchar(30),
  `quantity` int,
  PRIMARY KEY (cart_Item_ID),
  FOREIGN KEY (cart_ID) REFERENCES cart(cart_ID),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);


CREATE TABLE `OrderItems` (
  `order_Item_ID` int auto_increment,
  `Order_ID` int,
  `ISBN` bigint,
  `type` varchar(20),
  `quantity` int,

  PRIMARY KEY (order_Item_ID),
  FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN)

);
CREATE TABLE `Instructor` (
  `Instructor_ID` int auto_increment,
  `FirstName` varchar(30),
  `LastName` varchar(30),
  `email` varchar(50),
  `University_ID` int,
  `department_ID` int,
  PRIMARY KEY (Instructor_ID),
  FOREIGN KEY (University_ID) REFERENCES university(University_ID),
  FOREIGN KEY (department_ID) REFERENCES department(department_ID)
);
CREATE TABLE `Course` (
  `Course_ID` int auto_increment,
  `year` int,
  `semester` varchar(30)check (semester IN ('fall','spring','summer')),
  `name` varchar(100),
  `University_ID` int,
  `Department_ID` int,
  PRIMARY KEY (Course_ID),
  FOREIGN KEY (University_ID) REFERENCES University(University_ID),
  FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE `teaches` (
  `Instructor_ID` int,
  `Course_ID` int,
  FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE `CustomerService` (
  `Service_ID` int auto_increment,
  `Employee_ID` int,
  PRIMARY KEY (Service_ID),
  FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);
CREATE TABLE `Administrator` (
  `admin_ID` int auto_increment,
  `Employee_ID` int,
  PRIMARY KEY (admin_ID),
  FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);
CREATE TABLE `createUni` (
  `university_ID` int,
  `admin_ID` int,
  FOREIGN KEY (University_ID) REFERENCES university(University_ID),
  FOREIGN KEY (admin_ID) REFERENCES administrator(admin_ID)
);




CREATE TABLE `createCourse` (
  `admin_ID` int,
  `Course_ID` int,
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
  FOREIGN KEY (admin_ID) REFERENCES administrator(admin_ID)
);

CREATE TABLE `SuperAdmin` (
  `Super_ID` int auto_increment,
  `employee_ID` int,
  PRIMARY KEY (Super_ID),
  FOREIGN KEY (employee_ID) REFERENCES employees(employee_ID)
  
);
CREATE TABLE `tickets` (
  `Ticket_ID` int auto_increment,
  `Student_ID` int,
  `Category` varchar(40),
  `title` varchar(200),
  `descriptionOfFixed` varchar(200),

  PRIMARY KEY (Ticket_ID),
  FOREIGN KEY (Student_ID) REFERENCES student(Student_ID)
);
CREATE TABLE `handleTicket` (
  `Service_ID` int,
  `Ticket_ID` int,
  FOREIGN KEY (Service_ID) REFERENCES CustomerService(Service_ID),
  FOREIGN KEY (Ticket_ID) REFERENCES Tickets(Ticket_ID)
);
CREATE TABLE `HandlesAfterNew` (
  `Ticket_ID` int,
  `Admin_ID` int,
  FOREIGN KEY (Ticket_ID) REFERENCES Tickets(Ticket_ID),
  FOREIGN KEY (Admin_ID) REFERENCES Administrator(Admin_ID)
);


CREATE TABLE `createBooks` (
  `admin_ID` int,
  `ISBN` bigint,
  FOREIGN KEY (admin_ID) REFERENCES administrator(admin_ID),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);


CREATE TABLE `subcategories` (
  `ISBN` bigint,
  `subcategory` varchar(100),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);

CREATE TABLE `History` (
  `History_ID` int auto_increment,
  `Ticket_ID` int,
  `date_Logged` varchar(12),
  `descriptionOfProblem` varchar(200),
  `Status` varchar(40) check (status IN ('new','in-process','assigned','completed','closed')),
  `admin_ID` int,
  `Service_ID` int,
  PRIMARY KEY (History_ID),
  FOREIGN KEY (Ticket_ID) REFERENCES Tickets(Ticket_ID),
  FOREIGN KEY (admin_ID) REFERENCES handlesafternew(admin_ID),
  FOREIGN KEY (Service_ID) REFERENCES handleticket(Service_ID)
);

CREATE TABLE `Recomendations` (
  `Rec_ID` int auto_increment,
  `Order_ID` int,
  `student_ID` int,
  `ISBN` bigint,
  PRIMARY KEY (Rec_ID),
  FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);

CREATE TABLE `updateOrder` (
  `Service_ID` int,
  `Order_ID` int,
  FOREIGN KEY (Service_ID) REFERENCES CustomerService(Service_ID),
  FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

CREATE TABLE `createDept` (
  `department_ID` int,
  `admin_ID` int,
  FOREIGN KEY (department_ID) REFERENCES department(department_ID),
  FOREIGN KEY (admin_ID) REFERENCES administrator(admin_ID)
);

CREATE TABLE `words` (
  `ISBN` bigint,
  `keyword` varchar(200),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);


CREATE TABLE `authorList` (
  `ISBN` bigint,
  `firstname` varchar(30),
  `middle` varchar(30),
  `last` varchar(40),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);

CREATE TABLE `review` (
  `review_ID` int auto_increment,
  `student_ID` int,
  `ISBN` bigint,
  `review` DECIMAL(3,2),
  PRIMARY KEY (review_ID),
  FOREIGN KEY (student_ID) REFERENCES student(student_ID),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);

CREATE TABLE `takes` (
  `student_ID` int,
  `Course_ID` int,
  FOREIGN KEY (student_ID) REFERENCES student(student_ID),
  FOREIGN KEY (Course_ID) REFERENCES course(Course_ID)
);


CREATE TABLE `courseBooks` (
  `course_ID` int,
  `ISBN` bigint,
  FOREIGN KEY (course_ID) REFERENCES course(course_ID),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN)

);
