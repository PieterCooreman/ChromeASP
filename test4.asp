<!-- #include file="chromeASP/asplite/asplite.asp"-->
<%
dim url
url="http://localhost/chromeASP/pdf.asp"

dim html : html="<html><head><style>@page {margin:0px} body {margin:0px}</style></head><body>"

dim i

html=html & "<div style=""float:left;"">"
for i=0 to 255
html=html & "<div style=""width:256px;height:1px;  background: rgba(0, "&i&", 255, 1);""></div>"
next
html=html & "</div>"
html=html & "<div style=""float:left;"">"
for i=0 to 255
html=html & "<div style=""width:256px;height:1px;  background: rgba(255, 0, "&i&", 1);""></div>"
next
html=html & "</div>"
html=html & "<div style=""float:left;"">"
for i=0 to 255
html=html & "<div style=""width:256px;height:1px;  background: rgba("&i&", 255, 0, 1);""></div>"
next
html=html & "</div>"


html=html & "<div style=""float:left;"">"
for i=0 to 255
html=html & "<div style=""width:256px;height:1px;  background: rgba(0, 255, "&i&", 1);""></div>"
next
html=html & "</div>"
html=html & "<div style=""float:left;"">"
for i=0 to 255
html=html & "<div style=""width:256px;height:1px;  background: rgba("&i&", 0, 255, 1);""></div>"
next
html=html & "</div>"
html=html & "<div style=""float:left;"">"
for i=0 to 255
html=html & "<div style=""width:256px;height:1px;  background: rgba("&i&", "&i&", 255, 1);""></div>"
next
html=html & "</div>"


html=html & "<div style=""float:left;"">"
for i=0 to 255
html=html & "<div style=""width:256px;height:1px;  background: rgba(255, "&i&", 0, 1);""></div>"
next
html=html & "</div>"
html=html & "<div style=""float:left;"">"
for i=0 to 255
html=html & "<div style=""width:256px;height:1px;  background: rgba("&i&", 255, "&i&", 1);""></div>"
next
html=html & "</div>"
html=html & "<div style=""float:left;"">"
for i=0 to 255
html=html & "<div style=""width:256px;height:1px;  background: rgba("&i&", "&i&", 0, 1);""></div>"
next
html=html & "</div>"


html=html & "</body></html>"

dim data : data="pw=XXXXXX"
data=data & "&filename=export"
data=data & "&filetype=jpg"
data=data & "&height=768"
data=data & "&width=768"
data=data & "&html=" & server.urlencode(html) 

dim oXMLHTTP : set oXMLHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP")
oXMLHTTP.open "POST", url
oXMLHTTP.setRequestHeader "Content-type", "application/x-www-form-urlencoded;charset=utf-8"
oXMLHTTP.send data

Response.ContentType = "image/jpeg"
Response.AddHeader "Content-Disposition", "attachment; filename=export.jpg"
response.binarywrite oXMLHTTP.responseBody
set oXMLHTTP=nothing
%>