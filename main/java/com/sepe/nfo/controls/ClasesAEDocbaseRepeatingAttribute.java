package com.sepe.nfo.controls;

import com.documentum.web.common.ArgumentList;
import com.documentum.web.common.SessionState;
import com.documentum.web.form.control.Button;
import com.documentum.web.formext.control.docbase.DocbaseRepeatingAttribute;
import com.sepe.nfo.components.MyAttributes;

public class ClasesAEDocbaseRepeatingAttribute extends DocbaseRepeatingAttribute 
{

	private static final long serialVersionUID = 1L;

	@Override
	public void onClickOK(Button button, ArgumentList arg) 
	{
		super.onClickOK(button, arg);

		MyAttributes myattributes = (MyAttributes) SessionState.getAttribute("myattributescomp");
		myattributes.setClasesAEAttributeValue(getListData());
	}
}
