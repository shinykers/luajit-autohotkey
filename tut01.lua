require "vcl"

mainForm = VCL.Form{
	name="mainForm",
	caption = "My first VCLua application",
	position="podesktopcenter", 
	height=400, 
	width=600,
	onclosequery = "onCloseQueryEventHandler" 
}

function onCloseQueryEventHandler(Sender)
	return true -- the form can be closed
end

-- it should be a bug in lcl
mainMenu = VCL.MainMenu{name="mainMenu"}
mainMenu:LoadFromTable({
    {name="mmfile", caption="&File", 
        submenu={
            {name="mmOpen", caption="Open...", onclick="onMenuOpenClick", shortcut="Ctrl+O"}, 
			{caption="-",},
			{caption="Exit", onclick="onMenuExitClick", shortcut="Alt+F4"}, 
		}
	},
	{name="mmhelp", caption="&Help", RightJustify=true, 
	    submenu =  {
			{caption="Help", shortcut="F1", checked=true},
			{caption="-",},
		}
	}
})

mainMenu:Find("mmhelp"):Add("mmAbout")._=  {caption="About", onclick="onMenuAboutClick", enabled=false}

function onMenuExitClick()
	mainForm:Close()
end

function onMenuOpenClick()
	print("not implemented")
end

mainForm:ShowModal()
mainForm:Free()

	
