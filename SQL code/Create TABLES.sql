USE GYMDB;
CREATE TABLE GymMember (
    MemberID              INT           PRIMARY KEY IDENTITY(1,1),
    FirstName             VARCHAR(50)   NOT NULL,
    LastName              VARCHAR(50)   NOT NULL,
    PhoneNumber           VARCHAR(15)   NOT NULL,
    Email                 VARCHAR(100)  NULL     UNIQUE,
    DateOfBirth           DATE          NOT NULL,
    Gender                VARCHAR(10)   NOT NULL,
    Height                DECIMAL(5,2)  NOT NULL,
    InsurancePolicyNumber VARCHAR(50)   NOT NULL UNIQUE
);
CREATE TABLE MembershipPlan (
    MembershipPlanID      INT            PRIMARY KEY IDENTITY(1,1),
    MembershipPlanName    VARCHAR(100)   NOT NULL UNIQUE,
    Duration              INT            NOT NULL,
    Price                 BIGINT   NOT NULL
);
CREATE TABLE Staff (
    StaffID                  INT            PRIMARY KEY IDENTITY(1,1),
    FirstName                VARCHAR(50)    NOT NULL,
    LastName                 VARCHAR(50)    NOT NULL,
    PhoneNumber              VARCHAR(15)    NOT NULL,
    Email                    VARCHAR(100)   NOT NULL UNIQUE,
    DateOfBirth              DATE           NOT NULL,
    Gender                   VARCHAR(10)    NOT NULL,
    Position                 VARCHAR(50)    NOT NULL,
    HourlyRate               DECIMAL(8,2)   NOT NULL,
    DateOfHire               DATE           NOT NULL,
    InsurancePolicyNumber    VARCHAR(50)    NOT NULL UNIQUE,
    PersonalPhoto            VARCHAR(255)   NULL,
    PersonalIDCardPhotocopy  VARCHAR(255)   NULL,
    EmploymentContract       VARCHAR(255)   NULL
);
CREATE TABLE Subspace (
    SubspaceID       INT           PRIMARY KEY IDENTITY(1,1),
    SpaceName        VARCHAR(100)  NOT NULL UNIQUE,
    SpaceSize        DECIMAL(8,2)  NOT NULL
);
CREATE TABLE Locker (
    LockerID   INT         PRIMARY KEY IDENTITY(1,1),
    IsDefected BIT         NOT NULL DEFAULT 0,
    KeyNumber  VARCHAR(20) NOT NULL UNIQUE,
    MemberID   INT         NULL UNIQUE,

    CONSTRAINT FK_Locker_Member
        FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);
CREATE TABLE MedicalHistory (
    Condition       VARCHAR(100)  NOT NULL,
    DateOfDiagnosis DATE          NOT NULL,
    MemberID        INT           NOT NULL,
    Notes           VARCHAR(500)  NULL,

    PRIMARY KEY (Condition, DateOfDiagnosis, MemberID),

    CONSTRAINT FK_MedicalHistory_Member
        FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);
CREATE TABLE TrainingHistory (
    TypeofTraining         VARCHAR(100)  NOT NULL,
    StartDate              DATE          NOT NULL,
    MemberID               INT           NOT NULL,
    LengthOfTimeinMonths   INT           NULL,

    PRIMARY KEY (TypeofTraining, StartDate, MemberID),

    CONSTRAINT FK_TrainingHistory_Member
        FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);
CREATE TABLE BodyMeasurement (
    MeasurementDate     DATE          NOT NULL,
    MemberID            INT           NOT NULL,
    MeasuredWeight      DECIMAL(5,2)  NULL,
    BodyFatPercentage   DECIMAL(5,2)  NULL,
    MuscleMass          DECIMAL(5,2)  NULL,

    PRIMARY KEY (MeasurementDate, MemberID),

    CONSTRAINT FK_BodyMeasurement_Member
        FOREIGN KEY (MemberID) REFERENCES GymMember(MemberID)
);
CREATE TABLE MembershipSubscription (
    MembershipSubscriptionID  INT  PRIMARY KEY IDENTITY(1,1),
    StartDate                 DATE          NOT NULL,
    SessionsLeft              INT           NOT NULL,
    SubscriptionStatus        VARCHAR(10)   NOT NULL DEFAULT 'Active',
    MemberID                  INT           NOT NULL,
    MembershipPlanID          INT           NOT NULL,

    CONSTRAINT CHK_MembershipSubscription_Status
        CHECK (SubscriptionStatus IN ('Active', 'Expired', 'Cancelled', 'Frozen')),

    CONSTRAINT FK_MembershipSubscription_Member
        FOREIGN KEY (MemberID) REFERENCES Member(MemberID),

    CONSTRAINT FK_MembershipSubscription_MembershipPlan
        FOREIGN KEY (MembershipPlanID) REFERENCES MembershipPlan(MembershipPlanID)
);
CREATE TABLE StaffAttendance (
    StaffAttendanceID  INT        PRIMARY KEY IDENTITY(1,1),
    CheckInTime        TIME       NOT NULL,
    CheckOutTime       TIME       NULL,
    DateofAttendance   DATE       NOT NULL,
    StaffID            INT        NOT NULL,

    CONSTRAINT CHK_StaffAttendance_Time
        CHECK (CheckOutTime IS NULL OR CheckOutTime > CheckInTime),

    CONSTRAINT FK_StaffAttendance_Staff
        FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
CREATE TABLE SalaryTransaction (
    SalaryTransactionID  INT           PRIMARY KEY IDENTITY(1,1),
    PaymentMethod        VARCHAR(20)   NOT NULL,
    DateofPayment        DATE          NOT NULL,
    TimeofPayment        TIME          NOT NULL,
    StaffID              INT           NOT NULL,

    CONSTRAINT CHK_SalaryTransaction_PaymentMethod
        CHECK (PaymentMethod IN ('Cash', 'Bank Transfer', 'Cheque')),

    CONSTRAINT FK_SalaryTransaction_Staff
        FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
CREATE TABLE WorkSchedule (
    ScheduledWeekday   VARCHAR(10)  NOT NULL,
    StartTime          TIME         NOT NULL,
    StaffID            INT          NOT NULL,
    EndTime            TIME         NOT NULL,

    PRIMARY KEY (ScheduledWeekday, StartTime, StaffID),

    CONSTRAINT CHK_WorkSchedule_Weekday
        CHECK (ScheduledWeekday IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),

    CONSTRAINT CHK_WorkSchedule_Time
        CHECK (EndTime > StartTime),

    CONSTRAINT FK_WorkSchedule_Staff
        FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
CREATE TABLE WorkExperience (
    WorkingRole       VARCHAR(100)  NOT NULL,
    StartDate         DATE          NOT NULL,
    StaffID           INT           NOT NULL,
    EndDate           DATE          NULL,
    OrganizationName  VARCHAR(100)  NOT NULL,

    PRIMARY KEY (WorkingRole, StartDate, StaffID),

    CONSTRAINT FK_WorkExperience_Staff
        FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
CREATE TABLE Coach (
    StaffID          INT  NOT NULL,
    NumberOfTrainees INT  NOT NULL DEFAULT 0,

    PRIMARY KEY (StaffID),

    CONSTRAINT FK_Coach_Staff
        FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
CREATE TABLE Class (
    ClassID              INT           PRIMARY KEY IDENTITY(1,1),
    ClassName            VARCHAR(100)  NOT NULL,
    NumberOfParticipants INT           NOT NULL DEFAULT 0,
    Capacity             INT           NOT NULL,
    StaffID              INT           NOT NULL,
    SubspaceID           INT           NOT NULL,

    CONSTRAINT CHK_Class_Capacity
        CHECK (NumberOfParticipants <= Capacity),

    CONSTRAINT FK_Class_Coach
        FOREIGN KEY (StaffID) REFERENCES Coach(StaffID),

    CONSTRAINT FK_Class_Subspace
        FOREIGN KEY (SubspaceID) REFERENCES Subspace(SubspaceID)
);
CREATE TABLE Equipment (
    EquipmentID       INT           PRIMARY KEY IDENTITY(1,1),
    NameofEquipment   VARCHAR(100)  NOT NULL,
    Category          VARCHAR(100)  NOT NULL,
    Brand             VARCHAR(100)  NOT NULL,
    Condition         VARCHAR(10)   NOT NULL,
    InstallationDate  DATE          NOT NULL,
    LastMaintenance   DATE          NULL,
    Price             DECIMAL(10,2) NOT NULL,
    SubspaceID        INT           NOT NULL,

    CONSTRAINT CHK_Equipment_Condition
        CHECK (Condition IN ('New', 'Good', 'Fair', 'Poor')),

    CONSTRAINT CHK_Equipment_Category
        CHECK (Category IN ('Cardio', 'Strength', 'Flexibility', 'Functional Training', 'Recovery', 'Sports')),

    CONSTRAINT FK_Equipment_Subspace
        FOREIGN KEY (SubspaceID) REFERENCES Subspace(SubspaceID)
);
CREATE TABLE LockerHistory (
    DateofAssignment  DATE  NOT NULL,
    StartTime         TIME  NOT NULL,
    EndTime           TIME  NULL,
    LockerID          INT   NOT NULL,
    MemberID          INT   NOT NULL,

    PRIMARY KEY (DateofAssignment, StartTime, MemberID),

    CONSTRAINT CHK_LockerHistory_Time
        CHECK (EndTime > StartTime),

    CONSTRAINT FK_LockerHistory_Locker
        FOREIGN KEY (LockerID) REFERENCES Locker(LockerID),

    CONSTRAINT FK_LockerHistory_Member
        FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);
CREATE TABLE MemberAttendance (
    MemberAttendanceID        INT  PRIMARY KEY IDENTITY(1,1),
    CheckInTime               TIME  NOT NULL,
    CheckOutTime              TIME  NULL,
    AttendanceDate            DATE  NOT NULL,
    MembershipSubscriptionID  INT   NOT NULL,

    CONSTRAINT CHK_MemberAttendance_Time
        CHECK (CheckOutTime IS NULL OR CheckOutTime > CheckInTime),

    CONSTRAINT FK_MemberAttendance_MembershipSubscription
        FOREIGN KEY (MembershipSubscriptionID) REFERENCES MembershipSubscription(MembershipSubscriptionID)
);
CREATE TABLE ServiceTransaction (
    ServiceTransactionID       INT          PRIMARY KEY IDENTITY(1,1),
    PaymentMethod              VARCHAR(20)  NOT NULL,
    TransactionTime            TIME         NOT NULL,
    TransactionDate            DATE         NOT NULL,
    MembershipSubscriptionID   INT          NOT NULL,

    CONSTRAINT CHK_ServiceTransaction_PaymentMethod
        CHECK (PaymentMethod IN ('Cash', 'Bank Transfer', 'Cheque')),

    CONSTRAINT FK_ServiceTransaction_MembershipSubscription
        FOREIGN KEY (MembershipSubscriptionID) REFERENCES MembershipSubscription(MembershipSubscriptionID)
);
CREATE TABLE ClassRegistration (
    RegistrationID            INT          PRIMARY KEY IDENTITY(1,1),
    RegistrationDate          DATE         NOT NULL,
    RegistryStatus            VARCHAR(10)  NOT NULL DEFAULT 'Active',
    ClassID                   INT          NOT NULL,
    MembershipSubscriptionID  INT          NOT NULL,

    CONSTRAINT CHK_ClassRegistration_Status
        CHECK (RegistryStatus IN ('Active', 'Cancelled', 'Completed')),

    CONSTRAINT FK_ClassRegistration_Class
        FOREIGN KEY (ClassID) REFERENCES Class(ClassID),

    CONSTRAINT FK_ClassRegistration_MembershipSubscription
        FOREIGN KEY (MembershipSubscriptionID) REFERENCES MembershipSubscription(MembershipSubscriptionID)
);
CREATE TABLE PlanAllowedClasses (
    ClassID          INT  NOT NULL,
    MembershipPlanID INT  NOT NULL,

    PRIMARY KEY (ClassID, MembershipPlanID),

    CONSTRAINT FK_PlanAllowedClasses_Class
        FOREIGN KEY (ClassID) REFERENCES Class(ClassID),

    CONSTRAINT FK_PlanAllowedClasses_MembershipPlan
        FOREIGN KEY (MembershipPlanID) REFERENCES MembershipPlan(MembershipPlanID)
);
CREATE TABLE ClassTime (
    ClassDay   VARCHAR(10)  NOT NULL,
    ClassTime  TIME         NOT NULL,
    ClassID    INT          NOT NULL,

    PRIMARY KEY (ClassDay, ClassTime, ClassID),

    CONSTRAINT CHK_ClassTime_Day
        CHECK (ClassDay IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),

    CONSTRAINT FK_ClassTime_Class
        FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
);
CREATE TABLE Profession (
    FieldOfProfession  VARCHAR(100)  NOT NULL,
    StaffID            INT           NOT NULL,
    StartYear          INT           NOT NULL,

    PRIMARY KEY (FieldOfProfession, StaffID),

    CONSTRAINT CHK_Profession_StartYear
        CHECK (StartYear <= YEAR(GETDATE())),

    CONSTRAINT FK_Profession_Coach
        FOREIGN KEY (StaffID) REFERENCES Coach(StaffID)
);
CREATE TABLE CoachCertificate (
    CertificateName     VARCHAR(100)  NOT NULL,
    StaffID             INT           NOT NULL,
    IssueDate           DATE          NOT NULL,
    ExpiryDate          DATE          NULL,
    IssuingInstitution  VARCHAR(100)  NOT NULL,

    PRIMARY KEY (CertificateName, IssueDate, StaffID),

    CONSTRAINT CHK_Certificate_Dates
        CHECK (ExpiryDate IS NULL OR ExpiryDate > IssueDate),

    CONSTRAINT FK_Certificate_Coach
        FOREIGN KEY (StaffID) REFERENCES Coach(StaffID)
);