<!-- #include file="chromeASP/asplite/asplite.asp"-->
<%
dim url : url="http://localhost/chromeASP/pdf.asp" 'url to where your script is located!

dim html : html=aspl.loadText("test5.txt")

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
