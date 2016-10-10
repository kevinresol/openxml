##### Alpha: This is an alpha version. Expect drastic API changes in the future.


# openxml
Write OpenXML (xlsx, docx, pptx) files with Haxe

This is a library I wrote for my own use at work. So it will include only the features I need. In other words, do not expect the whole Open XML spec to be implemented. However, feel free to raise issues or feature requests and I will try to fix/add accordingly. Pull requests are highly appreciated.

#### Spreadsheet

Allows writing a .xlsx file.

Supports worksheets, cells, cell contents (partial), cell styles (partial)

**Supported cell contents:**

- Boolean
- Text
- Number
- Formula

**Supported cell styles (formatting):**

- Font (font family, font name, font size, bold, italic)
- Pattern Fill & Solid Fill

#### Word Processcing

Allows writing a .docx file

Only simple texts are supported at the moment.

### Install
`haxelib git openxml https://github.com/kevinresol/openxml`

### Usage
Check out the code samples in the "test" directory.

### OpenXML Specs

http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-376,%20Fourth%20Edition,%20Part%201%20-%20Fundamentals%20And%20Markup%20Language%20Reference.zip


### Running the tests

Copy `System.Xml.dll` and `System.Xml.Linq.dll` from .NET 4.0 to `<hxcs-path>/netlib/net-40`
Then run the following:
```
haxe validator.hxml
haxelib install travix
haxelib run travix install
haxelib run travix neko
```