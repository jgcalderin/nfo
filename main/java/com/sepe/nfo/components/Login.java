package com.sepe.nfo.components;

public class Login extends com.documentum.web.formext.session.Login 
{

	private static final long serialVersionUID = 1L;

	@Override
	protected void initDocbaseDropdown(String strDocbase) 
	{
		String[] misdocbases = getDocbaseList();
		for (int i=0;i<misdocbases.length;i++)
		{
			String d = misdocbases[i];
			if (d.startsWith("INVESPACE")) //docbasename validas: INVESACEDESA, INVESPACEPRE, INVESPACE,...
			{
				super.initDocbaseDropdown(d);
				return;
			}
		}
		
		super.initDocbaseDropdown(strDocbase);
	}	
}
