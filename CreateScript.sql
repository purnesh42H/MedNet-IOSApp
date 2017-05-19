BEGIN TRANSACTION;
-- Enumeration Strategy: Enumeration Table
create table Status (
	id INTEGER primary key autoincrement,
	status varchar(50) not null
);

insert into Status(status) VALUES('Canceled');
insert into Status(status) VALUES('Pending');
insert into Status(status) VALUES('Denied');
insert into Status(status) VALUES('Completed');

	create table UserType (
		id INTEGER primary key autoincrement,
		userType varchar(50) not null
	);

	insert into UserType(userType) VALUES('Civilian');
	insert into UserType(userType) VALUES('Doctor');
	insert into UserType(userType) VALUES('VolunteerOrganization');
	insert into UserType(userType) VALUES('Hospital');

-- Enumeration Strategy: Enumeration Table
create table RequestType (
	id INTEGER primary key autoincrement,
	requestType varchar(50) not null
);
insert into RequestType(requestType) VALUES('Manual');
insert into RequestType(requestType) VALUES('System');

create table MedicalServiceType (
	id INTEGER primary key autoincrement,
	serviceType varchar(50) not null
);
insert into RequestType(requestType) VALUES('Fund Donation');
insert into RequestType(requestType) VALUES('Organ Donation');
insert into RequestType(requestType) VALUES('Special');

-- Enumeration Strategy: Enumeration Table
create table CUIDType (
	id INTEGER primary key autoincrement,
	cUIDType varchar(100) not null
);

insert into CUIDType(cUIDType) VALUES('State id');
insert into CUIDType(cUIDType) VALUES('Passport');
insert into CUIDType(cUIDType) VALUES('Driving Licence');


-- Enumeration Strategy: Enumeration Table
create table BloodGroup (
	id INTEGER primary key autoincrement,
	bloodType varchar(5) not null
);

insert into BloodGroup(bloodType) VALUES('A+');
insert into BloodGroup(bloodType) VALUES('A-');
insert into BloodGroup(bloodType) VALUES('AB+');
insert into BloodGroup(bloodType) VALUES('AB-');
insert into BloodGroup(bloodType) VALUES('B+');
insert into BloodGroup(bloodType) VALUES('B-');
insert into BloodGroup(bloodType) VALUES('O+');
insert into BloodGroup(bloodType) VALUES('O-');


-- Main table for MedNet Users
create table MedNetUser (
	id INTEGER primary key autoincrement,
	name varchar(200) not null,
	emailId varchar(200),
	phoneNo INTEGER not null unique
);

insert into MedNetUser (name, emailId, phoneNo) Values ('John Travolta', 'johnf.t@gmail.com', 16175866340);
insert into MedNetUser (name, emailId, phoneNo) Values ('Deboire Sachtem', 'deboire.s@gmail.com', 16175866390);
insert into MedNetUser (name, emailId, phoneNo) Values ('Michael Faradey', 'michaelr.f@gmail.com', 16175866380);

insert into MedNetUser (name, emailId, phoneNo) Values ('US Government', 'officalusa.gov.com', 18175866340);
insert into MedNetUser (name, emailId, phoneNo) Values ('Health Authority', 'info@ha.com', 18175866390);

insert into MedNetUser (name, emailId, phoneNo) Values ('Phoenix Hospital', 'info@phoenix.com', 19175866380);
insert into MedNetUser (name, emailId, phoneNo) Values ('LoveCare Organization', 'info@lovecare.com', 19175866370);


-- Table that holds medical requests requested by a registered user
create table MedicalRequest (
	id INTEGER primary key autoincrement,
	status INTEGER not null,
	requestType INTEGER not null,
	reason varchar(200) not null,
	placedBy INTEGER not null,
	foreign key (status)
		references Status(id)
			on update cascade
			on delete no action,
	foreign key (requestType)
		references RequestType(id)
			on update cascade
			on delete no action,
	foreign key (placedBy)
		references MedNetUser(id)
			on update cascade
			on delete no action,
	unique(requestType, reason, placedBy)
);

insert into  MedicalRequest(status, requestType, reason, placedBy) Values(2, 1, 'B+ Blood Requirement', 1);
insert into  MedicalRequest(status, requestType, reason, placedBy) Values(2, 2, 'Profile Approval', 2);
insert into  MedicalRequest(status, requestType, reason, placedBy) Values(2, 1, 'Fund needed for cancer', 3);

-- Separate table to implement the scenario where one user can be
-- requested for multiple medical services and one medical service
-- can be requested to multiple users
create table  MedicalRequest_MedNetUser (
	placedTo INTEGER not null,
	have INTEGER not null,
	foreign key (placedTo)
		references MedNetUser(id)
			on update cascade
			on delete cascade,
	foreign key (have)
		references  MedicalRequest(id)
			on update cascade
			on delete cascade,
	primary key(placedTo, have)
);

insert into  MedicalRequest_MedNetUser(placedTo, have) Values(4, 2);
insert into  MedicalRequest_MedNetUser(placedTo, have) Values(3, 1);
insert into  MedicalRequest_MedNetUser(placedTo, have) Values(4, 3);

-- Hierarchy Strategy: Joined Strategy with User
create table Registered (
	id INTEGER primary key,
	userName varchar(200) not null unique,
	userType INTEGER not null,
	foreign key(userType)
		references userType(id)
			on update cascade
			on delete no action
	foreign key(id)
		references MedNetUser(id)
			on update cascade
			on delete cascade
);

insert into Registered(id, userName, userType) Values (1, 'johnf', 1);
insert into Registered(id, userName, userType) Values (2, 'deboire', 1);
insert into Registered(id, userName, userType) Values (3, 'michaelr', 2);

insert into Registered(id, userName, userType) Values (6, 'phoenix', 4);
insert into Registered(id, userName, userType) Values (7, 'lovecare', 3);

-- Hierarchy Strategy: Joined Strategy with User
create table UnRegistered (
	id INTEGER primary key,
	foreign key(id)
		references MedNetUser(id)
			on update cascade
			on delete cascade
);

insert into UnRegistered(id) Values (4);
insert into UnRegistered(id) Values (5);

-- Hierarchy Strategy: Joined Strategy with unregistered user
create table Government (
	id INTEGER primary key,
	foreign key(id)
		references Unregistered(id)
			on update cascade
			on delete cascade
);

insert into Government(id) Values (4);

-- Hierarchy Strategy: Joined Strategy with unregistered user
create table HealthAccreditationAuthority (
	id INTEGER primary key,
	authorizedBy INTEGER not null,
	foreign key(id)
		references Unregistered(id)
			on update cascade
			on delete cascade,
	foreign key(authorizedBy)
		references Government(id)
			on update cascade
			on delete no action
);

insert into HealthAccreditationAuthority(id, authorizedBy) Values (5, 4);

-- Hierarchy Strategy: Joined Strategy with unregistered user
create table Other (
	id INTEGER primary key,
	foreign key(id)
		references Unregistered(id)
			on update cascade
			on delete cascade
);

-- Table that maintains connection between registered and other registered users
-- one unregistered user can be connected to multiple registered users
-- one registered user can connect to multiple unregistered users
create table Connections_Registered_Other (
	registered INTEGER not null,
	unregistered INTEGER not null,
	foreign key (registered)
		references Registered(id)
			on update cascade
			on delete cascade,
	foreign key (unregistered)
		references Other(id)
			on update cascade
			on delete cascade,
	primary key(registered, unregistered)
);

-- Hierarchy Strategy: Joined Strategy with Registered user
create table Civilian (
	id INTEGER primary key,
	cUID varchar(20) not null unique,
	cUIDType Integer not null,
	foreign key(id)
		references Registered(id)
			on update cascade
			on delete cascade,
	foreign key(cUIDType)
		references CUIDType(id)
			on update cascade
			on delete cascade
);

insert into Civilian(id, cUID, cUIDType) Values (1, 'JXN1234', 1);
insert into Civilian(id, cUID, cUIDType) Values (2, 'JXN4564', 2);

-- Hierarchy Strategy: Joined Strategy with Registered user
create table VolunteerOrganization (
	id INTEGER primary key,
	foreign key(id)
		references Registered(id)
			on update cascade
			on delete cascade
);

insert into VolunteerOrganization(id) Values (7);

-- Hierarchy Strategy: Joined Strategy with Registered user
create table Hospital (
	id INTEGER primary key,
	foreign key(id)
		references Registered(id)
			on update cascade
			on delete cascade
);

-- Services provided by the hospital
create table HospitalServices (
	providedBy INTEGER not null,
	name varchar(100) not null,
	primary key(providedBy, name)
	foreign key(providedBy)
		references Hospital(id)
			on update cascade
			on delete cascade
);

-- hospital must have atleast one service.
-- NOTE: SQLite does not support ALTER attribute feature. Therefore, we are renaming
--       the old table, creating a new table with the old name, and deleting the old table.
ALTER TABLE Hospital RENAME TO Hospital1;

create table Hospital (
	id INTEGER primary key,
	foreign key(id)
		references Registered(id)
			on update cascade
			on delete cascade,
	foreign key(id)
		references HospitalServices(providedBy)
			on update no action
			on delete no action
);

drop table Hospital1;

insert into Hospital(id) Values (6);

insert into HospitalServices(providedBy, name) Values (6, 'XRay');
insert into HospitalServices(providedBy, name) Values (6, 'Cardiology');

-- Hierarchy Strategy: Joined Strategy with Registered user
create table Doctor (
	id INTEGER primary key,
	foreign key(id)
		references Registered(id)
			on update cascade
			on delete cascade
);


-- Specializations by Doctor
create table Specialization (
	of INTEGER not null,
	name varchar(100) not null,
	primary key(of, name),
	foreign key(of)
		references Doctor(id)
			on update cascade
			on delete cascade
);

insert into Specialization(of, name) Values (3, 'Surgeon');

-- Table to maintain doctors who are part of registered hospitals
create table Hospital_Doctors (
	worksIn INTEGER not null,
	has INTEGER not null,
	primary key(worksIn, has),
	foreign key(worksIn)
		references Hospital(id)
			on update cascade
			on delete cascade,
	foreign key(has)
		references Doctor(id)
			on update cascade
			on delete cascade
);

insert into Hospital_Doctors(worksIn, has) Values (6, 3);

-- Degrees of a doctor
create table Degree (
	name varchar(100) not null,
	of INTEGER not null,
	primary key(of, name)
	foreign key(of)
		references Doctor(id)
			on update cascade
			on delete cascade
);

-- NOTE: SQLite does not support ALTER attribute feature. Therefore, we are renaming
--       the old table, creating a new table with the old name, and deleting the old table.
ALTER TABLE Doctor RENAME TO Doctor1;

create table Doctor (
	id INTEGER primary key,
	foreign key(id)
		references Registered(id)
			on update cascade
			on delete cascade,
	foreign key(id)
		references Degree(of)
			on update no action
			on delete no action
);

drop table Doctor1;

insert into Doctor(id) Values (3);

insert into Degree(of, name) Values(3, 'MBBS');

-- Medical Services by Registered Users
create table MedicalService (
	id INTEGER primary key autoincrement,
	userId INTEGER not null,
	serviceType INTEGER not null,
	foreign key (userId)
		references Registered(id)
			on update cascade
			on delete cascade,
	foreign key(id)
		references MedicalServiceType(serviceType)
			on update cascade
			on delete cascade
);

insert into MedicalService(userId, serviceType) Values (3, 2);

-- Donation Service
create table Donation (
	id INTEGER primary key,
	foreign key(id)
		references MedicalService(id)
			on update cascade
			on delete cascade
);

insert into Donation(id) Values(2);

-- Any other special service
create table Special (
	id INTEGER not null,
	name varchar(200) not null,
	primary key(id, name)
	foreign key(id)
		references MedicalService(id)
			on update cascade
			on delete cascade
);

-- Fund type donation service
create table Fund (
	id INTEGER not null,
	fLimit double not null,
	primary key(id, fLimit)
	foreign key(id)
		references Donation(id)
			on update cascade
			on delete cascade
);

-- Organ type donation service
create table Organ (
	id INTEGER not null,
	name varchar(100) not null,
	primary key(id, name)
	foreign key(id)
		references Donation(id)
			on update cascade
			on delete cascade
);

insert into Organ(id, name) Values(1, 'Blood');

-- Authorization for providing medical services
create table MedicalService_Authorization (
	service INTEGER primary key,
	authId varchar(10),
	authorizedBy INTEGER,
	validTo date,
	foreign key (authorizedBy)
		references HealthAccreditationAuthority(id)
			on update cascade
			on delete cascade
);

insert into MedicalService_Authorization(service, authid, authorizedBy, validTo) Values (1, '1234', 5, '2020-03-25');

-- Profile of registered user
create table Profile (
	id INTEGER primary key autoincrement,
	userId INTEGER not null unique,
	approval INTEGER not null,
	bloodType INTEGER,
	dateOfBirth date,
	foreign key (approval)
		references Status(id)
			on update cascade
			on delete no action,
	foreign key (bloodType)
		references BloodGroup(id)
			on update cascade
			on delete no action,
	foreign key (userId)
		references Registered(id)
			on update cascade
			on delete no action
);


insert into Profile(userId, approval, bloodType, dateOfBirth) Values(1, 2, 1, '1991-12-01');
insert into Profile(userId, approval, bloodType, dateOfBirth) Values(3, 4, 3, '1961-02-06');
insert into Profile(userId, approval, bloodType, dateOfBirth) Values(2, 2, 2, '1987-11-01');
insert into Profile(userId, approval) Values(6, 3);
insert into Profile(userId, approval) Values(7, 3);

-- Interests in profile of registered user
create table Interests (
	partOf INTEGER not null,
	name varchar(200) not null,
	foreign key(partOf)
		references Profile(id)
			on update cascade
			on delete cascade,
	primary key(partOf, name)
);

insert into Interests(partOf, name) Values (1, 'Anaemia');
insert into Interests(partOf, name) Values (1, 'Cough');
insert into Interests(partOf, name) Values (1, 'Typhoid');

insert into Interests(partOf, name) Values (2, 'DNA Matching');
insert into Interests(partOf, name) Values (2, 'Ebola');

insert into Interests(partOf, name) Values (3, 'Cardic Arrest');
insert into Interests(partOf, name) Values (3, 'Medicines');

-- Treatments in profile of registered user
create table Treatments (
	partOf INTEGER not null,
	name varchar(200) not null,
	foreign key(partOf)
		references Profile(id)
			on update cascade
			on delete cascade,
	primary key(partOf, name)
);

insert into Treatments(partOf, name) Values (1, 'Anaemia');

-- Certificates in profile of registered user
create table Certificates (
	partOf INTEGER not null,
	name varchar(200) not null,
	foreign key(partOf)
		references Profile(id)
			on update cascade
			on delete cascade,
	primary key(partOf, name)
);

insert into Certificates(partOf, name) Values (1, 'Medical Certificate');
insert into Certificates(partOf, name) Values (1, 'Blood Donation Certificate');

insert into Certificates(partOf, name) Values (3, 'Doctor Certificate');
-- Allergies in profile of registered user
create table Allergies (
	partOf INTEGER not null,
	name varchar(200) not null,
	foreign key(partOf)
		references Profile(id)
			on update cascade
			on delete cascade,
	primary key(partOf, name)
);

insert into Allergies(partOf, name) Values (3, 'Flower');
insert into Allergies(partOf, name) Values (1, 'Dust');
insert into Allergies(partOf, name) Values (1, 'Cloves');

-- Hospital appointments of Registered Users
create table HospitalAppointment (
	id INTEGER primary key autoincrement,
	bookedBy int not null,
	hospital int not null,
	start time not null,
	end time not null,
	apptDate date not null,
	reason varchar(200) not null,
	foreign key(bookedBy)
		references Registered(id)
			on update cascade
			on delete cascade
	foreign key(hospital)
		references Hospital(id)
			on update cascade
			on delete cascade
);

insert into HospitalAppointment(bookedBy, hospital, start, end, apptDate, reason) Values (1, 6, '15:00', '14:30', '2017-04-06', 'Regular Checkup');
COMMIT;
