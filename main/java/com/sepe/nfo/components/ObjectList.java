package com.sepe.nfo.components;

import com.documentum.web.common.ArgumentList;
import com.documentum.web.form.control.Breadcrumb;

public class ObjectList extends
		com.documentum.webtop.webcomponent.objectlist.ObjectList {

	private static final long serialVersionUID = 1L;

	@Override
	public void onClickFolderPath(Breadcrumb control, ArgumentList args) 
	{
		//no hacemos nada, no queremos que el usuario navegue
		return;
	}
}
