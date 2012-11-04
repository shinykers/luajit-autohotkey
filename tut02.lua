require "vcl"

mainForm = VCL.Form{
	name="mainForm",
	caption = "My first VCLua application",
	position="podesktopcenter", 
	height=400, 
	width=600, 
	onclosequery = "onCloseQueryEventHandler", 
	icon="images/form.ico" 
}

mainImages = VCL.ImageList{name="mainImages"}

mainImages:LoadFromTable({
	"images/open.png", "images/exit.png", "images/help.png"
})

mainActions = VCL.ActionList{name="mainActions"}
mainActions:LoadFromTable({ 
    {name="fileOpenAction", caption="&Open...", shortcut="Ctrl+O", onexecute="onOpenAction", imageindex=0},
    {name="fileExitAction", caption="&Exit", shortcut="Alt+F4", onexecute="onExitAction", imageindex=1}, 
	{name="helpAboutAction", caption="&About", shortcut="Alt+F1", onexecute="onAboutAction", imageindex=2},
})

mainMenu = VCL.MainMenu(mainForm,"mainMenu")
mainMenu.Images = mainImages
mainMenu:LoadFromTable({
	{name="mmfile", caption="&File",   
		submenu={
			{action=mainActions:Get("fileOpenAction")},
			{caption="-",},
			{action=mainActions:Get("fileExitAction")},  
		}
	},
	{name="mmhelp", caption="&Help", RightJustify=true, 
	    submenu =  {
			{action=mainActions:Get("helpAboutAction")},
		}
	}
})

mainToolbar = VCL.ToolBar(mainForm,"mainToolbar")
mainToolbar._ = { borderwidth =0, edgeborders = "[ebLeft,ebTop,ebRight,ebBottom]", edgeinner = "esRaised", edgeouter = "esLowered", autosize = true, buttonwidth = 24, buttonheight = 24, align = alTop, flat = true }
mainToolbar.Images = mainImages
mainToolbar:LoadFromTable({
	{action=mainActions:Get("fileOpenAction")},
	{action=mainActions:Get("fileExitAction")},
	{style="tbsDivider"},	
	{action=mainActions:Get("helpAboutAction")},
})

-- Events
function onCloseQueryEventHandler(Sender)
	return true -- the form can be closed
end

function onOpenAction(Sender)
	print("not implemented")
end

function onAboutAction(Sender)
	print("not implemented")
end

function onExitAction(Sender)
	mainForm:Close()
end

mainForm:ShowModal()

	
