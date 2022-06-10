#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


CSVHeader := "Name,Email,Social Media Names,Testimonial`n"
master := "master.csv"
export := "Testimonials-Grid view.csv"
exportDir := "attachments/"
CSVRegex = O)(?:^|,)(?=[^"]|(")?)"?((?(1)[^"]*|[^,"]*))"?(?=,|$)


Gui, Add, Text, x12 y9 w450 h20 vtotalStatus, Status: Doing nothing...
Gui, Add, Progress, x12 y39 w450 h20 vtotalProgress, 0
Gui, Add, Text, x12 y69 w450 h20 vstepStatus, Downloading: Nothing...
Gui, Add, Progress, x12 y99 w450 h20 vstepProgress, 0
Gui, Add, Button, x362 y129 w100 h20 gdoDownload, Download
; Generated using SmartGUI Creator for SciTE
Gui, Show, w479 h163, ErikaLegacy Attachment Downloader
if(!FileExist(master)){
	FileAppend, %CSVHeader%, %master%
}
if(!FileExist(exportDir)){
	FileCreateDir, %exportDir%
}
return

doDownload:
exportCount = 0
tStatus("Counting records to import...")
Loop, Read, %export% 
{
	exportCount++
}
msgbox,, Exporting..., Exporting %exportCount%
if(FileExist(export)){
	Loop, Read, %export%
	{
		if(A_Index == 1) {
			continue
		}
		tProg((A_Index / exportCount)*100)
		tStatus("Downloading attachments... [" . A_Index . "/" . exportCount . "]")
		attachments := StrSplit(getAttachments(A_LoopReadLine), ",")
		name := getName(A_LoopReadLine)
		if(!FileExist(exportDir . name)){
			FileCreateDir, %exportDir%%name%
		}
		stepTotal := attachments.Length()
		stepNow := 0
		for key, value in attachments
		{
			stepNow++
			attachInfo := StrSplit(value, " ", ")(")
			if(!FileExist(exportDir . name . "/" . attachInfo[1])){
				url := attachInfo[2]
				fileName := exportDir . name . "/" . attachInfo[1]
				sStatus(filename . " [" . stepNow . "/" . stepTotal . "]")
				sProg((stepNow / stepTotal) * 100)
				URLDownloadToFile, %url%, %fileName%
			}
		}
		newLine := getIndex(A_LoopReadLine, 1) . "," . getIndex(A_LoopReadLine, 2) . "," . getIndex(A_LoopReadLine, 3) . "," . getIndex(A_LoopReadLine, 4) . "`n"
		FileAppend, %newLine%, %master%
	}
} else {
	MsgBox,, No export file, No export file [%export%] was found in the local directory.`nPlease move it there.
}
tStatus("Downloaded " . exportCount . " records attachements")
sStatus("Nothing...")
FileMove, %export%, Imported-%export%
return

GuiClose:
ExitApp



tProg(prog) {
	GuiControl,, totalProgress, %prog%
}

sProg(prog) {
	GuiControl,, stepProgress, %prog%
}

tStatus(txt) {
	GuiControl,, totalStatus, Status: %txt%
}

sStatus(txt) {
	GuiControl,, stepStatus, Downloading: %txt%
}

getAttachments(line) {
	return getIndex(line, 5)
}
getName(line) {
	return getIndex(line, 1)
}
getIndex(line, index) {
	global CSVRegex
	i = 0;
	matchPos := RegExMatch(line, CSVRegex, matcher)
	while(matchPos != 0){
		len := matcher.Value(2)
		matchPos := RegExMatch(line, CSVRegex, matcher, matchPos+1)
		i++
		if(i == index){
			return len
		}
	}
}