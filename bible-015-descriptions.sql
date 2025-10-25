/* *************************************************************************
Bible Database: Firebird, by Don Jewett
https://github.com/donjewett/bible-sql-firebird

bible-015-descriptions.sql 
Version: 2025.10.24

MIT License

Copyright (c) 2025 by Don Jewett

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

************************************************************************* */

----------------------------------------------------------------------------
-- Languages
----------------------------------------------------------------------------
COMMENT ON COLUMN Languages.Id IS 			'Three character ISO 693-1 code';
COMMENT ON COLUMN Languages.Name IS 		'Name of the Language in English';
COMMENT ON COLUMN Languages.HtmlCode IS 	'Two character html code for Language';
COMMENT ON COLUMN Languages.IsAncient IS 	'This language or dialect has been extinct since ancient times';


----------------------------------------------------------------------------
-- Canons
----------------------------------------------------------------------------
COMMENT ON COLUMN Canons.Id IS 			'Canon Id following bible-sql numbering scheme';
COMMENT ON COLUMN Canons.Code IS 		'Short code following Protestant tradition';
COMMENT ON COLUMN Canons.Name IS 		'Name following Protestant tradition';
COMMENT ON COLUMN Canons.LanguageId IS 	'Primary Language of the Canon';


----------------------------------------------------------------------------
-- Sections
----------------------------------------------------------------------------
COMMENT ON COLUMN Sections.Id IS 		'Section Id following bible-sql numbering scheme';
COMMENT ON COLUMN Sections.Name IS 		'Name of the Section following Protestant tradition';
COMMENT ON COLUMN Sections.CanonId IS 	'Canon of the Bible Section';


----------------------------------------------------------------------------
-- Books
----------------------------------------------------------------------------
COMMENT ON COLUMN Books.Id IS 				'Book Id following bible-sql numbering scheme';
COMMENT ON COLUMN Books.Code IS 			'Short url-friendly lowercase Code for Book';
COMMENT ON COLUMN Books.Abbrev IS 			'Short Proper case abbreviation for Book';
COMMENT ON COLUMN Books.Name IS 			'Name of Book following Protestant tradition';
COMMENT ON COLUMN Books.Book IS 			'Index of Book following Protestant order';
COMMENT ON COLUMN Books.CanonId IS 			'Canon of Book following Protestant tradition';
COMMENT ON COLUMN Books.SectionId IS 		'Section of Book following Protestant tradition';
COMMENT ON COLUMN Books.IsSectionEnd IS 	'Is the final Book in the Section';
COMMENT ON COLUMN Books.ChapterCount IS 	'Count of chapters in this book following Protestant tradition';
COMMENT ON COLUMN Books.OsisCode IS 		'Osis code for the Book';
COMMENT ON COLUMN Books.Paratext IS 		'Paratext code for the Book';


----------------------------------------------------------------------------
-- BookNames
----------------------------------------------------------------------------
COMMENT ON COLUMN BookNames.Name IS 		'Altername name or code for Book';
COMMENT ON COLUMN BookNames.BookId IS 		'Book Id following bible-sql numbering scheme';


----------------------------------------------------------------------------
-- Chapters
----------------------------------------------------------------------------
COMMENT ON COLUMN Chapters.Id IS 			'Chapter Id following bible-sql numbering scheme';
COMMENT ON COLUMN Chapters.Code IS 			'Short, url-friendly lowercase Code for chapter';
COMMENT ON COLUMN Chapters.Reference IS 	'Human readable reference using Book Abbrev and Chapter number';
COMMENT ON COLUMN Chapters.Chapter IS 		'Chapter number';
COMMENT ON COLUMN Chapters.BookId IS 		'Book of the Chapter';
COMMENT ON COLUMN Chapters.IsBookEnd IS 	'Is the final Chapter in the Book';
COMMENT ON COLUMN Chapters.VerseCount IS 	'Count of verses in the Chapter';


----------------------------------------------------------------------------
-- Verses
----------------------------------------------------------------------------
COMMENT ON COLUMN Verses.Id IS 				'Verse Id following bible-sql numbering scheme';
COMMENT ON COLUMN Verses.Code IS 			'Short, url-friendly lowercase Code for verse';
COMMENT ON COLUMN Verses.OsisCode IS 		'Osis code for the Verse';
COMMENT ON COLUMN Verses.Reference IS 		'Human readable reference using Book Abbrev Chapter:Verse';
COMMENT ON COLUMN Verses.CanonId IS 		'Canon of the Verse'; --denormalized
COMMENT ON COLUMN Verses.SectionId IS 		'Section of the Verse'; --denormalized
COMMENT ON COLUMN Verses.BookId IS 			'Book of the Verse'; --denormalized
COMMENT ON COLUMN Verses.ChapterId IS 		'Chapter of the Verse';
COMMENT ON COLUMN Verses.IsChapterEnd IS 	'Is the final Verse in the Chapter';
COMMENT ON COLUMN Verses.Book IS 			'Book number'; --denormalized
COMMENT ON COLUMN Verses.Chapter IS 		'Chapter number'; --denormalized
COMMENT ON COLUMN Verses.Verse IS 			'Verse number';


----------------------------------------------------------------------------
-- GreekTextForms
----------------------------------------------------------------------------
COMMENT ON COLUMN GreekTextForms.Id IS 			'One to three character code for Greek form';
COMMENT ON COLUMN GreekTextForms.Name IS 		'Name of the Greek form';
COMMENT ON COLUMN GreekTextForms.ParentId IS 	'The Greek form this one derives from';


----------------------------------------------------------------------------
-- HebrewTextForms
----------------------------------------------------------------------------
COMMENT ON COLUMN HebrewTextForms.Id IS 		'One to three character code for Hebrew text';
COMMENT ON COLUMN HebrewTextForms.Name IS 		'Name of the Hebrew form';
COMMENT ON COLUMN HebrewTextForms.ParentId IS 	'The Hebrew form this one derives from';


----------------------------------------------------------------------------
-- LicensePermissions
----------------------------------------------------------------------------
COMMENT ON COLUMN LicensePermissions.Id IS 				'Auto-incrementing Id';
COMMENT ON COLUMN LicensePermissions.Name IS 			'Name of the Permission';
COMMENT ON COLUMN LicensePermissions.Permissiveness IS 	'Permissiveness of license on a scale of 0 to 100';


----------------------------------------------------------------------------
-- LicenseTypes
----------------------------------------------------------------------------
COMMENT ON COLUMN LicenseTypes.Id IS 			'Auto-incrementing Id';
COMMENT ON COLUMN LicenseTypes.Name IS 			'Name of the License Type';
COMMENT ON COLUMN LicenseTypes.IsFree IS 		'True for licences allowing free quotation -- false for commercial restricting use';
COMMENT ON COLUMN LicenseTypes.PermissionId IS 	'Permissiveness for License Type';


----------------------------------------------------------------------------
-- Versions
----------------------------------------------------------------------------
COMMENT ON COLUMN Versions.Id IS 				'Auto-incrementing Id';
COMMENT ON COLUMN Versions.Code IS 				'Version Code used for lookups. Must be unique';
COMMENT ON COLUMN Versions.Name IS 				'Name of the Version';
COMMENT ON COLUMN Versions.Subtitle IS 			'Optional Subtitle for the version';
COMMENT ON COLUMN Versions.LanguageId IS 		'Language of the Version';
COMMENT ON COLUMN Versions.YearPublished IS 	'Year first published in entirety';
COMMENT ON COLUMN Versions.HebrewFormId IS 		'Textual basis for the Old Testament';
COMMENT ON COLUMN Versions.GreekFormId IS 		'Textual basis for the New Testament';
COMMENT ON COLUMN Versions.ParentId IS 			'Optional Version this is derived from';
COMMENT ON COLUMN Versions.LicenseTypeId IS 	'Optional License Type';
COMMENT ON COLUMN Versions.ReadingLevel IS 		'Reading Level using U.S. school grades (8.0 = Eighth Grade)';


----------------------------------------------------------------------------
-- Revisions
----------------------------------------------------------------------------
COMMENT ON COLUMN Revisions.Id IS 				'Auto-incrementing Id';
COMMENT ON COLUMN Revisions.Code IS 			'Revision Code used for lookups. Must be unique';
COMMENT ON COLUMN Revisions.VersionId IS 		'Version of the Revision';
COMMENT ON COLUMN Revisions.YearPublished IS	'Year the Revision was first published in its entirety';
COMMENT ON COLUMN Revisions.Subtitle IS 		'Subtitle for the Revision, esp. if different than Version (i.e. Second Edition)';


----------------------------------------------------------------------------
-- Sites
----------------------------------------------------------------------------
COMMENT ON COLUMN Sites.Id IS 	'Auto-incrementing Id';
COMMENT ON COLUMN Sites.Name IS 'Site Name';
COMMENT ON COLUMN Sites.Url IS 	'Site Url';


----------------------------------------------------------------------------
-- ResourceTypes
----------------------------------------------------------------------------
COMMENT ON COLUMN ResourceTypes.Id IS 	'Eight character code';
COMMENT ON COLUMN ResourceTypes.Name IS 'Name of the Resource Type';


----------------------------------------------------------------------------
-- Resources
----------------------------------------------------------------------------
COMMENT ON COLUMN Resources.Id IS 				'Auto-incrementing Id';
COMMENT ON COLUMN Resources.ResourceTypeId IS 	'Eight character code for Resource Type';
COMMENT ON COLUMN Resources.VersionId IS 		'Version of the Resource';
COMMENT ON COLUMN Resources.RevisionId IS 		'Optional Revision of the Resource';
COMMENT ON COLUMN Resources.Url IS 				'Source Url for the Resource';
COMMENT ON COLUMN Resources.IsOfficial IS 		'True if the Resource is the official one (i.e. provided by the publisher)';
COMMENT ON COLUMN Resources.SiteId IS 			'Site associated with the Resource';


----------------------------------------------------------------------------
-- Bibles
----------------------------------------------------------------------------
COMMENT ON COLUMN Bibles.Id IS 				'Auto-incrementing Id';
COMMENT ON COLUMN Bibles.Code IS 			'Code for lookups. Must be unique';
COMMENT ON COLUMN Bibles.Name IS 			'Name of this specific Bible';
COMMENT ON COLUMN Bibles.Subtitle IS 		'Subtitle for this specific Bible';
COMMENT ON COLUMN Bibles.VersionId IS 		'Version of this Bible';
COMMENT ON COLUMN Bibles.RevisionId IS 		'Optional Revision of this Bible';
COMMENT ON COLUMN Bibles.YearPublished IS 	'Year this Bible (or Revision) was published';
COMMENT ON COLUMN Bibles.TextFormat IS 		'Code for the format of the Content';
COMMENT ON COLUMN Bibles.SourceId IS 		'Optional source Resource of this Bible';


----------------------------------------------------------------------------
-- BibleVerses
----------------------------------------------------------------------------
COMMENT ON COLUMN BibleVerses.Id IS 		'Auto-incrementing Id';
COMMENT ON COLUMN BibleVerses.BibleId IS 	'The Bible for this Content';
COMMENT ON COLUMN BibleVerses.VerseId IS 	'The Verse for this Content';
COMMENT ON COLUMN BibleVerses.Markup IS 	'The Content of the Bible Verse';
COMMENT ON COLUMN BibleVerses.PreMarkup IS 	'Optional Markup, especially for scribal notes in the manuscripts.';
COMMENT ON COLUMN BibleVerses.PostMarkup IS 'Optional Markup, especially for scribal notes in the manuscripts.';
COMMENT ON COLUMN BibleVerses.Notes IS 		'Optional Notes for the Bible Verse';


----------------------------------------------------------------------------
-- VersionNotes
----------------------------------------------------------------------------
COMMENT ON COLUMN VersionNotes.Id IS 		 'Auto-incrementing Id';
COMMENT ON COLUMN VersionNotes.VersionId IS  'Version for this Note';
COMMENT ON COLUMN VersionNotes.RevisionId IS 'Optional Revision for this Note -- for notes specific to an Revision';
COMMENT ON COLUMN VersionNotes.BibleId IS 	 'Optional Bible for this Note -- for notes specific to a Bible';
COMMENT ON COLUMN VersionNotes.CanonId IS 	 'Optional Canon for this Note -- for notes that apply to the Canon as a whole';
COMMENT ON COLUMN VersionNotes.BookId IS 	 'Optional Book for this Note -- for notes that apply to the Book as a whole';
COMMENT ON COLUMN VersionNotes.ChapterId IS  'Optional Chapter for this Note -- for notes that apply to the Chapter as a whole';
COMMENT ON COLUMN VersionNotes.VerseId IS 	 'Optional Verse for this Note -- for notes that apply to the Verse. Use BibleVerses.Notes for short notes';
COMMENT ON COLUMN VersionNotes.Note IS 		 'Content of the Note';
COMMENT ON COLUMN VersionNotes.Label IS 	 'Optional Label for the Note';
COMMENT ON COLUMN VersionNotes.Ranking IS 	 'Weight (Descending Sort Order) of the Note';
