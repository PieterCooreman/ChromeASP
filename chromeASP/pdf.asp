<!-- #include file="asplite/asplite.asp"-->
<!-- #include file="config.asp"-->
<%

dim filetype
select case lcase(aspl.getRequest("filetype"))
	case "pdf" : filetype="pdf"
	case "jpg" : filetype="jpg"
	case "png" : filetype="png"
	case else : filetype="pdf" 'default
end select

dim filewidth, fileheight
if aspl.convertNmbr(aspl.getRequest("height"))<>0 then
	fileheight=aspl.convertNmbr(aspl.getRequest("height"))
else
	fileheight=1080	
end if
if aspl.convertNmbr(aspl.getRequest("width"))<>0 then
	filewidth=aspl.convertNmbr(aspl.getRequest("width"))
else
	filewidth=1920	
end if

dim randomNr : randomNr=round(aspl.randomizer.randomNumber(1,999),0)

dim iFileN : iFileN="output" & randomNr & "." & filetype

dim link,fileN,html

if aspl.getRequest("pw")<>pw then 
	link=getUrl & "/error.asp"
	fileN="error"
else

	if aspl.getRequest("html")<>"" then
		html=aspl.getRequest("html")
		application("appvalue" & randomNr)=html
		link=getUrl & "/appvalue.asp?n=" & randomNr
	else
		link=escapeLink(aspl.getRequest("url"))
	end if
	
	fileN=aspl.getRequest("filename")
	
end if

dim command : command="cmd /k cd " & chromepath

'export as PDF or PNG/JPG
select case filetype
	case "pdf" : command=command & " && chrome.exe --user-data-dir=" & chromeuserdatadir & " --headless --disable-gpu --print-to-pdf=" & server.mappath(iFileN) & " " & link
	case "png","jpg" : command=command & " && chrome.exe --user-data-dir=" & chromeuserdatadir & " --headless --disable-gpu --screenshot=" & server.mappath(iFileN) & " --window-size="&filewidth&","&fileheight&" " & link
end select

command=command & " && exit "

Dim oShell : Set oShell = server.CreateObject ("WSCript.shell")
oShell.run command,,true 'true -> wait for the script to finish completely

Set oShell = Nothing

dumpBinary iFileN,fileN

dim fso : set fso=server.CreateObject("Scripting.FileSystemObject")
fso.deleteFile(server.mappath(iFileN))
set fso=nothing

function dumpBinary (byval path,dumpAs)

	on error resume next

	path=server.mappath(path)

	Dim objStream : Set objStream = server.CreateObject("ADODB.Stream")

	objStream.Open
	objStream.type=1 'adTypeBinary
	objStream.LoadFromFile(path)	

	'get filesize
	dim size : size=objStream.size
	'set chunksize - files will be served by chunks of 500kb each
	dim chunksize : chunksize=500000
	
	'retrieve filename
	dim filename
	select case filetype
		case "pdf" : filename=dumpAs & ".pdf" : response.ContentType="application/pdf"
		case "png" : filename=dumpAs & ".png" : response.ContentType="image/png"
		case "jpg" : filename=dumpAs & ".jpg" : response.ContentType="image/jpeg"
	end select	
		
	response.clear

	Response.AddHeader "Content-Disposition", "attachment; filename=" & server.urlencode(filename)

	if size<chunksize then
		response.AddHeader "Content-Length", size
		response.binarywrite objStream.Read()
		response.flush()	   
	else

		dim i
		for i=0 to size step chunksize
			response.binarywrite objStream.Read(chunksize)
			response.flush()
		next

	end if

	set objStream=nothing

	response.clear

end function


function escapeLink(l)

	escapeLink=replace(l,"^","^^",1,-1,1)
	escapeLink=replace(escapeLink,"&","^&",1,-1,1)
	escapeLink=replace(escapeLink,"?","^?",1,-1,1)
	escapeLink=replace(escapeLink,"<","^<",1,-1,1)
	escapeLink=replace(escapeLink,">","^>",1,-1,1)
	escapeLink=replace(escapeLink,"(","^(",1,-1,1)
	escapeLink=replace(escapeLink,")","^)",1,-1,1)
	escapeLink=replace(escapeLink,"|","^|",1,-1,1)

end function


function geturl

	if lcase(aspl.convertStr(request.servervariables("HTTPS")))="on" then
		geturl="https://"
	else
		geturl="http://"
	end if
	
	geturl=geturl & request.servervariables("HTTP_HOST") & replace(request.servervariables("SCRIPT_NAME"),"/pdf.asp","",1,-1,1)
	
end function
%>
