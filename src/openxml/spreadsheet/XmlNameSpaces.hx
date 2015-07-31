package openxml.spreadsheet;

/**
 * ...
 * @author Kevin
 */
class XmlNameSpaces
{
	public static var spreadsheetml = SpreadsheetML;
	public static var officeDocument = OfficeDocument;
	public static var pack = Package;
}

private class SpreadsheetML
{
	public static inline var MAIN = "http://schemas.openxmlformats.org/spreadsheetml/2006/main";
}

private class OfficeDocument
{
	public static inline var RELATIONSHIPS = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
}

private class Package
{
	public static inline var RELATIONSHIPS = 'http://schemas.openxmlformats.org/package/2006/relationships';
}