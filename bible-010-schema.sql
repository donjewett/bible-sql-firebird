/* *************************************************************************
Bible Database: Firebird, by Don Jewett
https://github.com/donjewett/bible-sql-firebird

bible-010-schema.sql 
Version: 2025.10.31

************************************************************************* */

-- -------------------------------------------------------------------------
-- Languages
-- -------------------------------------------------------------------------
CREATE TABLE Languages (
	Id char(3) CHARACTER SET ascii NOT NULL,
	Name varchar(16) CHARACTER SET ascii NOT NULL,
	HtmlCode char(2) CHARACTER SET ascii NOT NULL,
	IsAncient boolean DEFAULT false NOT NULL,
	CONSTRAINT PK_Languages PRIMARY KEY (Id)
);

-- -------------------------------------------------------------------------
-- Canons
-- -------------------------------------------------------------------------
CREATE TABLE Canons (
	Id int NOT NULL,
	Code char(2) CHARACTER SET ascii NOT NULL,
	Name varchar(24) CHARACTER SET ascii NOT NULL,
	LanguageId char(3) NOT NULL,
	CONSTRAINT PK_Canons PRIMARY KEY (Id),
	CONSTRAINT FK_Canons_Languages FOREIGN KEY (LanguageId) REFERENCES Languages (Id)
);

-- -------------------------------------------------------------------------
-- Sections
-- -------------------------------------------------------------------------
CREATE TABLE Sections (
	Id int NOT NULL,
	Name varchar(16) CHARACTER SET ascii NOT NULL,
	CanonId int NOT NULL,
	CONSTRAINT PK_Sections PRIMARY KEY (Id),
	CONSTRAINT FK_Sections_Canons FOREIGN KEY (CanonId) REFERENCES Canons (Id)
);

-- -------------------------------------------------------------------------
-- Books
-- -------------------------------------------------------------------------
CREATE TABLE Books (
	Id int NOT NULL,
	Code varchar(5) CHARACTER SET ascii NOT NULL,
	Abbrev varchar(5) CHARACTER SET ascii NOT NULL,
	Name varchar(16) CHARACTER SET ascii NOT NULL,
	Book smallint NOT NULL,
	CanonId int NOT NULL, -- denormalized
	SectionId int NOT NULL,
	IsSectionEnd boolean NOT NULL,
	ChapterCount smallint NOT NULL,
	OsisCode varchar(6) CHARACTER SET ascii NOT NULL,
	Paratext char(3) CHARACTER SET ascii NOT NULL,
	CONSTRAINT PK_Books PRIMARY KEY (Id),
	CONSTRAINT FK_Books_Canons FOREIGN KEY (CanonId) REFERENCES Canons (Id),
	CONSTRAINT FK_Books_Sections FOREIGN KEY (SectionId) REFERENCES Sections (Id)
);

-- -------------------------------------------------------------------------
-- BookNames
-- -------------------------------------------------------------------------
CREATE TABLE BookNames (
	Name varchar(64) CHARACTER SET utf8 NOT NULL,
	BookId int NOT NULL,
	CONSTRAINT PK_BookNames PRIMARY KEY (Name),
	CONSTRAINT FK_BookNames_Books FOREIGN KEY (BookId) REFERENCES Books (Id)
);

-- -------------------------------------------------------------------------
-- Chapters
-- -------------------------------------------------------------------------
CREATE TABLE Chapters (
	Id int NOT NULL,
	Code varchar(7) CHARACTER SET ascii NOT NULL,
	Reference varchar(8) CHARACTER SET ascii NOT NULL,
	Chapter smallint NOT NULL,
	BookId int NOT NULL,
	IsBookEnd boolean NOT NULL,
	VerseCount int NOT NULL,
	CONSTRAINT PK_Chapters PRIMARY KEY (Id),
	CONSTRAINT FK_Chapters_Books FOREIGN KEY (BookId) REFERENCES Books (Id)
);

-- -------------------------------------------------------------------------
-- Verses
-- -------------------------------------------------------------------------
CREATE TABLE Verses (
	Id int NOT NULL,
	Code varchar(16) CHARACTER SET ascii NOT NULL,
	OsisCode varchar(12) CHARACTER SET ascii NOT NULL,
	Reference varchar(10) CHARACTER SET ascii NOT NULL,
	CanonId int NOT NULL, --denormalized
	SectionId int NOT NULL, --denormalized
	BookId int NOT NULL, --denormalized
	ChapterId int NOT NULL,
	IsChapterEnd boolean NOT NULL,
	Book smallint NOT NULL, --denormalized
	Chapter smallint NOT NULL, --denormalized
	Verse smallint NOT NULL,
	CONSTRAINT PK_Verses PRIMARY KEY (Id),
	CONSTRAINT FK_Verses_Books FOREIGN KEY (BookId) REFERENCES Books (Id),
	CONSTRAINT FK_Verses_Chapters FOREIGN KEY (ChapterId) REFERENCES Chapters (Id),
	CONSTRAINT FK_Verses_Canons FOREIGN KEY (CanonId) REFERENCES Canons (Id),
	CONSTRAINT FK_Verses_Sections FOREIGN KEY (SectionId) REFERENCES Sections (Id)
);


-- -------------------------------------------------------------------------
-- GreekTextForms
-- -------------------------------------------------------------------------
CREATE TABLE GreekTextForms (
	Id char(3) CHARACTER SET ascii NOT NULL,
	Name varchar(48) CHARACTER SET ascii NOT NULL,
	ParentId char(3) CHARACTER SET ascii,
	CONSTRAINT PK_GreekTextForms PRIMARY KEY (Id),
	CONSTRAINT FK_GreekTextForms_GreekTextForms FOREIGN KEY (ParentId) REFERENCES GreekTextForms (Id)
);


-- -------------------------------------------------------------------------
-- HebrewTextForms
-- -------------------------------------------------------------------------
CREATE TABLE HebrewTextForms (
	Id char(3) CHARACTER SET ascii NOT NULL,
	Name varchar(48) CHARACTER SET ascii NOT NULL,
	ParentId char(3) CHARACTER SET ascii,
	CONSTRAINT PK_HebrewTextForms PRIMARY KEY (Id),
	CONSTRAINT FK_HebrewTextForms_HebrewTextForms FOREIGN KEY (ParentId) REFERENCES HebrewTextForms (Id)
);


-- -------------------------------------------------------------------------
-- LicensePermissions
-- -------------------------------------------------------------------------
CREATE TABLE LicensePermissions (
	Id int GENERATED BY DEFAULT AS IDENTITY,
	Name varchar(48) CHARACTER SET ascii NOT NULL,
	Permissiveness int NOT NULL,
	CONSTRAINT PK_LicensePermissions PRIMARY KEY (Id)
);


-- -------------------------------------------------------------------------
-- LicenseTypes
-- -------------------------------------------------------------------------
CREATE TABLE LicenseTypes (
	Id int GENERATED BY DEFAULT AS IDENTITY,
	Name varchar(64) CHARACTER SET ascii NOT NULL,
	IsFree boolean NOT NULL,
	PermissionId int,
	CONSTRAINT PK_LicenseType PRIMARY KEY (Id),
	CONSTRAINT FK_LicenseTypes_LicensePermissions FOREIGN KEY (PermissionId) REFERENCES LicensePermissions (Id)
);


-- -------------------------------------------------------------------------
-- Versions
-- -------------------------------------------------------------------------
CREATE TABLE Versions (
	Id int GENERATED BY DEFAULT AS IDENTITY,
	Code varchar(16) CHARACTER SET ascii NOT NULL,
	Name varchar(64) CHARACTER SET utf8 NOT NULL,
	Subtitle varchar(128) CHARACTER SET utf8,
	LanguageId char(3) CHARACTER SET ascii NOT NULL,
	YearPublished smallint NOT NULL,
	HebrewFormId char(3) CHARACTER SET ascii,
	GreekFormId char(3) CHARACTER SET ascii,
	ParentId int,
	LicenseTypeId int,
	ReadingLevel decimal(4,2),
	CONSTRAINT PK_Versions PRIMARY KEY (Id),
	CONSTRAINT FK_Versions_Languages FOREIGN KEY (LanguageId) REFERENCES Languages (Id),
	CONSTRAINT FK_Versions_Versions FOREIGN KEY (ParentId) REFERENCES Versions (Id),
	CONSTRAINT FK_Version_TextForm_Greek FOREIGN KEY (GreekFormId) REFERENCES GreekTextForms (Id),
	CONSTRAINT FK_Version_TextForm_Hebrew FOREIGN KEY (HebrewFormId) REFERENCES HebrewTextForms (Id),
	CONSTRAINT FK_Versions_LicenseTypes FOREIGN KEY (LicenseTypeId) REFERENCES LicenseTypes (Id)
);


-- -------------------------------------------------------------------------
-- Editions
-- -------------------------------------------------------------------------
CREATE TABLE Editions (
	Id int GENERATED BY DEFAULT AS IDENTITY,
	Code varchar(16) CHARACTER SET ascii NOT NULL,
	VersionId int NOT NULL,
	YearPublished smallint NOT NULL,
	Subtitle varchar(128) CHARACTER SET utf8,
	CONSTRAINT PK_Editions PRIMARY KEY (Id),
	CONSTRAINT FK_Editions_Versions FOREIGN KEY (VersionId) REFERENCES Versions (Id)
);


-- -------------------------------------------------------------------------
-- Sites
-- -------------------------------------------------------------------------
CREATE TABLE Sites (
	Id int GENERATED BY DEFAULT AS IDENTITY,
	Name varchar(64) CHARACTER SET utf8 NOT NULL, 
	Url varchar(255) CHARACTER SET ascii NOT NULL,
	CONSTRAINT PK_Sites PRIMARY KEY (Id)
);


-- -------------------------------------------------------------------------
-- ResourceTypes
-- -------------------------------------------------------------------------
CREATE TABLE ResourceTypes (
	Id varchar(8) CHARACTER SET ascii NOT NULL,
	Name varchar(64) CHARACTER SET ascii NOT NULL,
	CONSTRAINT PK_ResourceTypes PRIMARY KEY (Id)
);


-- -------------------------------------------------------------------------
-- Resources
-- -------------------------------------------------------------------------
CREATE TABLE Resources (
	Id int GENERATED BY DEFAULT AS IDENTITY,
	ResourceTypeId varchar(8) CHARACTER SET ascii NOT NULL,
	VersionId int NOT NULL,
	EditionId int,
	Url varchar(255) CHARACTER SET ascii, -- TODO: why is this nullable?
	IsOfficial boolean DEFAULT false NOT NULL,
	SiteId int,
	CONSTRAINT PK_Resources PRIMARY KEY (Id),
	CONSTRAINT FK_Resources_ResourceTypes FOREIGN KEY (ResourceTypeId) REFERENCES ResourceTypes (Id),
	CONSTRAINT FK_Resources_Editions FOREIGN KEY (EditionId) REFERENCES Editions (Id),
	CONSTRAINT FK_Resources_Versions FOREIGN KEY (VersionId) REFERENCES Versions (Id),
	CONSTRAINT FK_Resources_Sites FOREIGN KEY (SiteId) REFERENCES Sites (Id)
);


-- -------------------------------------------------------------------------
-- Bibles
-- -------------------------------------------------------------------------
CREATE TABLE Bibles (
	Id int GENERATED BY DEFAULT AS IDENTITY,
	Code varchar(16) CHARACTER SET ascii NOT NULL,
	Name varchar(64) CHARACTER SET utf8 NOT NULL,
	Subtitle varchar(128) CHARACTER SET utf8,
	VersionId int NOT NULL,
	EditionId int,
	YearPublished smallint,
	TextFormat varchar(6) CHARACTER SET ascii DEFAULT 'txt' NOT NULL,
	SourceId int,
	CONSTRAINT PK_Bibles PRIMARY KEY (Id),
	CONSTRAINT FK_Bibles_Versions FOREIGN KEY (VersionId) REFERENCES Versions (Id),
	CONSTRAINT FK_Bibles_Editions FOREIGN KEY (EditionId) REFERENCES Editions (Id),
	CONSTRAINT FK_Bibles_Resources FOREIGN KEY (SourceId) REFERENCES Resources (Id)
);


-- -------------------------------------------------------------------------
-- BibleVerses
-- -------------------------------------------------------------------------
CREATE TABLE BibleVerses (
	Id int GENERATED BY DEFAULT AS IDENTITY,
	BibleId int NOT NULL,
	VerseId int NOT NULL,
	Markup blob SUB_TYPE text NOT NULL,
	PreMarkup varchar(255) CHARACTER SET utf8,
	PostMarkup varchar(255) CHARACTER SET utf8,
	Notes varchar(255) CHARACTER SET utf8,
	CONSTRAINT PK_BibleVerses PRIMARY KEY (Id),
	CONSTRAINT FK_BibleVerses_Bibles FOREIGN KEY (BibleId) REFERENCES Bibles (Id),
	CONSTRAINT FK_BibleVerses_Verses FOREIGN KEY (VerseId) REFERENCES Verses (Id)
);


CREATE UNIQUE INDEX UQ_BibleVerses_Version_Verse ON BibleVerses
(
	BibleId,
	VerseId
);


-- -------------------------------------------------------------------------
-- VersionNotes
-- -------------------------------------------------------------------------
CREATE TABLE VersionNotes (
	Id int GENERATED BY DEFAULT AS IDENTITY,
	VersionId int NOT NULL,
	EditionId int,
	BibleId int,
	CanonId int,
	BookId int,
	ChapterId int,
	VerseId int,
	Note blob SUB_TYPE text NOT NULL,
	Label varchar(64) CHARACTER SET ascii,
	Ranking int DEFAULT 0 NOT NULL,
	CONSTRAINT PK_VersionNotes PRIMARY KEY (Id),
	CONSTRAINT FK_VersionNotes_Versions FOREIGN KEY (VersionId) REFERENCES Versions (Id),
	CONSTRAINT FK_VersionNotes_Canons FOREIGN KEY (CanonId) REFERENCES Canons (Id),
	CONSTRAINT FK_VersionNotes_Books FOREIGN KEY (BookId) REFERENCES Books (Id),
	CONSTRAINT FK_VersionNotes_Chapters FOREIGN KEY (ChapterId) REFERENCES Chapters (Id),
	CONSTRAINT FK_VersionNotes_Verses FOREIGN KEY (VerseId) REFERENCES Verses (Id),
	CONSTRAINT FK_VersionNotes_Bibles FOREIGN KEY (BibleId) REFERENCES Bibles (Id),
	CONSTRAINT FK_VersionNotes_Editions FOREIGN KEY (EditionId) REFERENCES Editions (Id)
);

