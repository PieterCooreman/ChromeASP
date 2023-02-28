# ChromeASP
Headless Chrome.exe used as a PDF/JPG generator in classic ASP/VBScript
## Intro
Classic ASP/VBScript developers never had an easy (and free) way to generate PDF and/or JPG/PNG files. This ASP script uses headless Chrome to get the job done. Chrome converts both websites (urls) and html-snippets to pdf and/or jpg (screenshot). 
## System requirements

This script will most likely not work on any shared hosting environment. It will only be useful in case you run your own Windows OS (server or localhost).

- You need Chrome installed on your PC/Server
- IUSR (or Everyone) needs full permissions on Chrome.exe file
- You have to create a folder on your system where Chrome stores logs/debugs - make sure to give IUSR permissions too
- Requires aspLite, a light-weight framework for ASP/VBScript developers.
- The default page is "default.asp" (see web.config). 

The script was tested on Windows 2019 (Amazon AWS) & 2022 (Azure) Server and on a local IIS8 (Windows 10). 



## Configuration
Default.asp holds 3 configurational settings:
- pw : use this to "secure" your pdf-creation service. you don't want everyone to be able to use your server as a PDF-creator.
- chromepath : the full path to your chrome.exe installation (without the "chrome.exe")
- chromeuserdatadir : the full path to a directory (you have to create it yourself) where headless Chrome needs to store specific logs and debug

## Usage
This script takes 4 parameters (both request.querystring and request.form are supported):

- pw (password - needs to correspond to the password you set in the configuration area in default.asp)
- filename (name of the pdffile that will be exported)
- filetype ("pdf","jpg" or "png")
- url (website to convert to pdf/jpg/png) OR html (html code to convert to pdf/jpg/png)

## Examples
In this first example a PDF of www.google.com will be generated:
```ASP
<!-- #include file="asplite/asplite.asp"-->
<%
dim url : url="http://localhost" 'url to where your script is located!

dim data : data="pw=XXXXXX"
data=data & "&filename=export"
data=data & "&filetype=pdf"
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
In this second example a PDF of a HTML-snippet will be generated:

```ASP
<!-- #include file="asplite/asplite.asp"-->
<%
dim url : url="http://localhost" 'url to where your script is located!

dim html : html="<strong>Just testing</strong>. Is this <i>working</i>?"

dim data : data="pw=XXXXXX"
data=data & "&filename=export"
data=data & "&filetype=pdf"
data=data & "&html=" & server.urlencode(html)

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
In this third example a JPG-screenshot of www.google.com will be created:

```ASP
<!-- #include file="asplite/asplite.asp"-->
<%
dim url : url="http://localhost" 'url to where your script is located!

dim data : data="pw=XXXXXX"
data=data & "&filename=export"
data=data & "&filetype=jpg"
data=data & "&width=1024"
data=data & "&height=768"
data=data & "&url=" & server.urlencode("https://www.google.com")

dim oXMLHTTP : set oXMLHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP")
oXMLHTTP.open "POST", url
oXMLHTTP.setRequestHeader "Content-type", "application/x-www-form-urlencoded;charset=utf-8"
oXMLHTTP.send data

Response.ContentType = "image/jpeg"
Response.AddHeader "Content-Disposition", "attachment; filename=export.jpg"
response.binarywrite oXMLHTTP.responseBody
set oXMLHTTP=nothing
%>
```
