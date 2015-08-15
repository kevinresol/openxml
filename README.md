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


