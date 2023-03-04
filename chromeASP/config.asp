<%
'This classic ASP script launches headless Chrome to create PDF files and JPG screenshots of any webpage/html. 
'Requires a folder (C:\inetpub\wwwroot\ChromeUser in this script) for the Chrome user to store logs
'Requires Chrome - set chromepath to your local Chrome.exe-path

'This script takes the following parameters:
'pw=password
'filename=name of the pdf/jpg file
'filetype=pdf/jpg/png
'width=width for screenshot (only for png/jpg)
'height=height for screenshot (only for png/jpg)
'OR parameter url (complete url)
'OR parameter html (full html code)


'#############################################################################
'##### START CONFIG AREA
'#############################################################################

dim pw : pw="XXXXXX" 'replace this!
dim chromepath : chromepath="C:\Program Files (x86)\Google\Chrome\Application"
dim chromeuserdatadir : chromeuserdatadir="C:\inetpub\wwwroot\ChromeUser"

'#############################################################################
'##### END CONFIG AREA
'#############################################################################

%>