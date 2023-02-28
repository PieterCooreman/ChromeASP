# ChromeASP
Headless Chrome.exe used as a PDF generator in classic ASP/VBScript
## Intro
Classic ASP/VBScript developers never had an easy (and free) way to generate PDF files. This ASP script uses headless Chrome to get the job done.
## System requirements
- You need Chrome installed on your PC/Server
- IUSR (or Everyone) needs full permissions on Chrome.exe file
- You have to create a folder on your system where Chrome stores logs/debugs - make sure to give IUSR permissions too
- Requires aspLite, a light-weight framework for ASP/VBScript developers.
The script was tested on Windows 2019 (Amazon AWS) & 2022 (Azure) Server and on a local IIS8 (Windows 10). 

The default page is "default.asp". 

## Configuration
Default.asp holds 3 configurational settings:
- pw : use this to "secure" your pdf-creation service. you don't want everyone to be able to use your server as a PDF-creator.
- chromepath : the full path to your chrome.exe installation (without the "chrome.exe")
- chromeuserdatadir : the full path to a directory (you have to create it yourself) where headless Chrome needs to store specific logs and debug

## Usage
This script takes 3 parameters (both request.querystring and request.form are supported):

- pw (password - needs to correspond to the password you set in the configuration area in default.asp)
- filename (name of the pdffile that will be exported)
- url (website to convert to pdf) OR html (html code to convert to PDF)

## Example
In this first example a PDF of www.google.com will be generated:
```VBSCRIPT
<!-- #include file="asplite/asplite.asp"-->
<%
dim url : url="https://url-to-your-installation"

dim data : data="pw=XXXXXX"
data=data & "&filename=export.pdf"
data=data & "&url=" & server.urlencode("https://www.google.com") 

dim oXMLHTTP : set oXMLHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP")
oXMLHTTP.open "POST", url
oXMLHTTP.setRequestHeader "Content-type", "application/x-www-form-urlencoded;charset=utf-8"
oXMLHTTP.send data

Response.ContentType = "application/pdf"
Response.AddHeader "Content-Disposition", "attachment; filename=export.pdf"
response.binarywrite oXMLHTTP.responseBody
set oXMLHTTP=nothing
%>
```
