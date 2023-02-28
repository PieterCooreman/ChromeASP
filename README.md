# ChromeASP
Headless Chrome.exe used as a PDF generator in classic ASP/VBScript
## Intro
Classic ASP/VBScript developers never had an easy (and free) way to generate PDF files. This ASP script uses headless Chrome to get the job done.
Some things to keep in mind:

- You need Chrome installed on your PC/Server
- IUSR (or Everyone) needs full permissions on Chrome.exe file
- You have to create a folder on your system where Chrome stores logs/debugs - make sure to give IUSR permissions too

The script was tested on Windows 2019 (Amazon AWS) & 2022 (Azure) Server and on a local IIS8 (Windows 10). 

The default page is "default.asp". 

This script takes 3 parameters (both request.querystring and request.form are supported):

- pw (password)
- filename (name of the pdffile)
- url (website to convert to pdf) OR html (html code to convert to PDF)

## Configuration
Default.asp holds 3 configurational settings:
- pw : use this to "secure" your pdf-creation service. you don't want everyone to be able to use your server as a PDF-creator.
- chromepath : the full path to your chrome.exe installation (without the "chrome.exe")
- chromeuserdatadir : the full path to a directory (you have to create it yourself) where headless Chrome needs to store specific logs and debug
