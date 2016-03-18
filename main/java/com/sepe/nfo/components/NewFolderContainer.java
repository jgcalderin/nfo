package com.sepe.nfo.components;

import com.documentum.web.common.ArgumentList;
import com.documentum.web.form.Control;
import com.documentum.webcomponent.library.create.NewFolder;

@SuppressWarnings("serial")
public class NewFolderContainer extends com.documentum.webcomponent.library.create.NewFolderContainer
{
	public void onInit(ArgumentList args) 
	{
		super.onInit(args);
	}

	public void onOk(Control arg0, ArgumentList arg1)
	{
		//sin esta sentencia, se lanzaria el componente de propiedades aunque haya errores de validación 
		//(como atributos obligatorios vacios), y no queremos eso :
		if (!((NewFolder)getContainedComponents().get(0)).getIsValid()) return;
		
		super.onOk(arg0, arg1);
		
		String newFolderType = ((NewFolder)getContainedComponents().get(0)).getNewType();
		
		ArgumentList args = new ArgumentList();
		
		args.add(arg1);
		args.add("objectId",((NewFolder)getContainedComponents().get(0)).getNewObjectId());
		args.add("component","attributes");
		this.getContext().set("type", newFolderType);
		setComponentJump("properties", args,this.getContext());
	}
}