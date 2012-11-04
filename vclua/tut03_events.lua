function onCloseQueryEventHandler(Sender)
	if VCL.MessageDlg("Are you sure?","mtConfirmation",{"mbYes","mbCancel"})=="mrYes" then
		return true
	end
	return false
end

function onOpenAction(Sender)
     local fod = VCL.OpenDlg(mainForm)
     local fileFilter = "Any files|*.*|Text files|*.txt|Lua scripts|*.lua"
     local openOptions = "[ofAllowMultiSelect, ofFileMustExist, ofViewDetail]"
	local filename = fod:Execute({ title="Open file(s)",initialdir="./",filter=fileFilter,options=openOptions})
	fod:Free()
	if filename==nil then return end
	local s = filename
	if type(filename)=="table" then
		s = table.concat(filename,"\n")
	end
	VCL.ShowMessage("File(s) to open:\n"..s)
end

function onAboutAction(Sender)
	print("not implemented")
end

function onExitAction(Sender)
	mainForm:Close()
end

