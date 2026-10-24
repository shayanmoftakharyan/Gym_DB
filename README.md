# Gym Management System, Database Design and Implementation

A relational database project developed as part of the **Database course at the Faculty of Computer Science, University of Tehran, Spring 2026**.

This academic team project focuses on conceptual database modeling, relational schema design, normalization, and SQL Server implementation for a gym management system.

## Academic Information

| Item | Details |
|---|---|
| Project | Gym Management System |
| Course | Database |
| Faculty | Faculty of Computer Science |
| University | University of Tehran |
| Semester | Spring 2026 |
| Project Type | Academic team project |
| Database Management System | Microsoft SQL Server |

## Team Members

- [Nima Ansaripour](https://www.linkedin.com/in/nima-ansaripour/)
- [Fatemeh Beheshtipour](https://www.linkedin.com/in/fatemeh-beheshtipour-ba2306246/)
- [Shayan Moftakharyan](https://www.linkedin.com/in/shayanmoftakharyan/)

## Project Overview

Managing a gym involves coordinating membership plans, subscriptions, staff, coaches, training classes, attendance, facilities, and equipment. A relational database provides a structured way to represent these entities, maintain their relationships, enforce data integrity, and retrieve relevant information.

The goal of this project was to design and implement a database for a gym management system, translating the domain's requirements into an Entity–Relationship (ER) model and a relational schema.

The project follows a database development workflow covering conceptual modeling, normalized ER design, SQL table creation, and query development. It also uses sample data to support database testing and query execution.

## Project Objectives

The main objectives were to:

- Model the gym management domain using ER diagrams.
- Translate the conceptual model into a relational database schema.
- Apply database normalization principles.
- Implement tables, primary keys, foreign keys, and integrity constraints using SQL Server.
- Represent relationships among members, subscriptions, staff, coaches, classes, and gym facilities.
- Prepare sample data and develop SQL queries for retrieving information from the database.

## Database Design

### 1. Conceptual ER Model

The initial ER model identifies the principal entities, their attributes, and the relationships between them.

The model covers several aspects of gym operations, including membership management, employee administration, coaching, attendance tracking, class registration, locker assignments, and equipment management.

The original ER diagram is included in the `ER Design/` directory.

### 2. Normalized ER Model

A normalized version of the ER design is also included in the repository. It refines the representation of the domain and provides the basis for the relational schema.

The model includes entities for member and staff records, membership subscriptions, financial transactions, attendance, training histories, body measurements, classes, facilities, and equipment.

Both the original and normalized ER diagrams are provided to document the database design process.

### 3. Relational Schema and SQL Implementation

The database schema is implemented in SQL Server using `CREATE TABLE` statements.

The SQL implementation defines primary keys, foreign-key relationships, uniqueness requirements, default values, and check constraints to support referential integrity and enforce selected business rules.

The schema includes the following main groups of tables.

#### Member and membership management

- `GymMember` — member personal information and contact details.
- `MembershipPlan` — membership plan names, durations, and prices.
- `MembershipSubscription` — subscription start dates, remaining sessions, statuses, and associated plans.
- `MemberAttendance` — member check-in and check-out records.
- `ServiceTransaction` — payment method and transaction date and time.

#### Staff and coach management

- `Staff` — staff details, positions, compensation rates, employment dates, and document references.
- `Coach` — coach-specific information and trainee counts.
- `WorkSchedule` — staff working days and hours.
- `WorkExperience` — previous employment roles and organizations.
- `StaffAttendance` — staff attendance records.
- `SalaryTransaction` — staff salary payment records.
- `Profession` — professional fields and specialization start years.
- `CoachCertificate` — coaching certificates, issuing institutions, and validity dates.

#### Classes and registration

- `Class` — class names, participant counts, capacities, assigned coaches, and locations.
- `ClassRegistration` — member subscription registrations for classes and their statuses.
- `ClassTime` — scheduled class days and times.
- `PlanAllowedClasses` — associations between membership plans and classes available under those plans.

#### Facilities and equipment

- `Subspace` — gym areas or spaces and their sizes.
- `Locker` — locker identifiers, key numbers, and defect status.
- `LockerHistory` — locker assignment records.
- `Equipment` — equipment names, categories, brands, conditions, installation dates, maintenance dates, prices, and locations.

#### Member health and training records

- `MedicalHistory` — medical conditions, diagnosis dates, and notes.
- `TrainingHistory` — training types, start dates, and training durations.
- `BodyMeasurement` — dated records of member weight, body-fat percentage, and muscle mass.

## Integrity Constraints

The SQL implementation uses several database constraints to enforce data validity.

**Primary keys and foreign keys:** Identify records and establish relationships between related tables.

**Unique constraints:** Prevent duplicate values in selected fields, including member and staff email addresses, insurance policy numbers, membership plan names, and locker key numbers.

**Check constraints:** Restrict values and enforce selected business rules, including:

- Valid subscription statuses: `Active`, `Expired`, `Cancelled`, and `Frozen`.
- Valid staff workdays and class days.
- Check-out times later than check-in times.
- Valid equipment conditions and categories.
- Class participant counts not exceeding class capacity.
- Valid payment methods for salary and service transactions.
- Certificate expiry dates later than issue dates, when an expiry date is specified.

**Default values:** Provide predefined values for selected fields, such as active subscription status, default attendance-independent participant counts, and locker defect status.

## Technologies and Tools

- **Microsoft SQL Server:** Relational database management system.
- **SQL:** Database definition, integrity constraints, and query development.
- **Entity–Relationship modeling:** Conceptual representation of entities and their relationships.
- **Database normalization:** Refinement of the relational design.
- **AI-assisted data generation:** Preparation of synthetic data for database development and testing.

## Repository Structure

```text
Gym_DB/
├── Basic Queries/
│   └── Basic SQL query scripts
├── DATA/
│   └── Sample data files
├── ER Design/
│   └── Original and normalized ER diagrams
├── SQL code/
│   └── Database implementation scripts
├── LICENSE
└── README.md
```

## Getting Started

### Prerequisites

- Microsoft SQL Server.
- SQL Server Management Studio (SSMS) or a compatible SQL client.
- The SQL scripts and data files included in this repository.

### 1. Clone the repository

```bash
git clone https://github.com/shayanmoftakharyan/Gym_DB.git
cd Gym_DB
```

### 2. Review the database design

Examine the ER diagrams in `ER Design/` to understand the entities, attributes, and relationships before reviewing the SQL implementation.

### 3. Create the database schema

Open the relevant scripts from `SQL code/` in SQL Server Management Studio. Create the `GYMDB` database if it does not already exist, and execute the table-creation scripts in the order required by their foreign-key dependencies.

### 4. Load sample data

Review the files in `DATA/` and load the sample data after the required tables have been created.

### 5. Execute the queries

Run the SQL scripts in `Basic Queries/` against the populated database to explore the implemented data model.

*Note: The exact execution order depends on the dependencies among the SQL scripts and the formats of the data files.*

## Learning Outcomes

This project provided practical experience with:

- Conceptual data modeling using ER diagrams.
- Relational schema design and normalization.
- SQL Server table creation and constraint definition.
- Modeling one-to-one, one-to-many, and many-to-many relationships.
- Enforcing referential integrity and selected domain constraints.
- Organizing member, staff, financial, attendance, and facility data in a relational database.
- Preparing sample data and testing database queries.
- Collaborative database development within an academic team.

## Project Scope

This repository documents the database design and SQL implementation developed for a university course. Its primary focus is the relational database layer, rather than a complete application with a graphical interface, authentication, or production deployment.

The diagrams and SQL scripts are intended to demonstrate the application of database design and implementation concepts to a practical gym management scenario.

## License

See the [`LICENSE`](./LICENSE) file for the applicable license terms.
