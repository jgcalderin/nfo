package com.sepe.nfo.components;

import com.documentum.fc.common.DfException;
import com.documentum.fc.common.DfLogger;
import com.documentum.web.common.ArgumentList;
import com.documentum.web.formext.component.Component;

public class Redirecciona extends Component {

	private static final long serialVersionUID = 1L;

	public void onInit(ArgumentList arg)
	{
		super.onInit(arg);
		
		String startFolderId = null;
		try 
		{
			startFolderId = getDfSession().getObjectByPath("/NFO").getObjectId().toString();
		} catch (DfException e) 
		{
			e.printStackTrace();
			DfLogger.error(this,"ERROR al intentar obtener path de inicio",null,null);
		}
		
		ArgumentList entryargs = new ArgumentList();
		entryargs.add("objectId",startFolderId);
		setComponentJump("main", "classic",entryargs , getContext());
	}
}
