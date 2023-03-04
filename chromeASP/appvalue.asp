<!-- #include file="asplite/asplite.asp"-->
<%
if aspl.convertNmbr(request("n"))<>0 then
	response.write application("appvalue" & aspl.convertNmbr(request("n")))
	Application.Contents.Remove("appvalue" & aspl.convertNmbr(request("n")))
end if
%>