<!-- #include file="chromeASP/asplite/asplite.asp"-->
<%
dim url : url="http://localhost/chromeASP/pdf.asp" 'url to where your script is located!

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