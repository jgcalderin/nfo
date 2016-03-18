package com.sepe.nfo.components;

import com.documentum.fc.common.DfException;
import com.documentum.fc.common.DfId;
import com.documentum.fc.common.DfLogger;
import com.documentum.web.common.ArgumentList;
import com.documentum.web.form.Control;
import com.documentum.web.form.Form;
import com.documentum.web.form.IControlListener;
import com.documentum.web.form.control.Label;
import com.documentum.webcomponent.library.properties.Properties;

public class MyProperties extends Properties implements IControlListener{

	private static final long serialVersionUID = 1L;

	private String mObjectId = null;

	public void onInit(ArgumentList arg)
	{
		super.onInit(arg);
		addControlListener(this);
		mObjectId = arg.get("objectId");
	}
	
	@Override
	public void onOk(Control arg0, ArgumentList arg1) 
	{
		//Queremos reutilizar el boton del container como un OK de la pagina actual
		if (getContainedComponent().getComponentPage().equalsIgnoreCase("diferencias"))
		{
			((MyAttributes)getContainedComponent()).onOKDiferencias(null, null);
			return;
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("editaridiomas"))
		{
			((MyAttributes)getContainedComponent()).onOKEditarIdiomas(null, null);
			return;
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("cobertura"))
		{
			((MyAttributes)getContainedComponent()).onOKCobertura(null, null);
			return;
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("editarofiti"))
		{
			((MyAttributes)getContainedComponent()).onOKEditarOfiTI(null, null);
			return;
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("editartitulaciones"))
		{
			((MyAttributes)getContainedComponent()).onOKEditarTitulaciones(null, null);
			return;
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("editarcertificados"))
		{
			((MyAttributes)getContainedComponent()).onOKEditarCertificados(null, null);
			return;
		}
		
		super.onOk(arg0, arg1);
	}

	@Override
	public boolean onCancelChanges() 
	{
		//Queremos reutilizar el boton del container como un CANCEL de la pagina actual
		if (getContainedComponent().getComponentPage().equalsIgnoreCase("diferencias"))
		{
			((MyAttributes)getContainedComponent()).onCancelDiferencias(null, null);
			return false; //necesario para que no se vuelve al componente doclist
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("editaridiomas"))
		{
			((MyAttributes)getContainedComponent()).onCancelEditarIdiomas(null, null);
			return false; //necesario para que no se vuelve al componente doclist
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("cobertura"))
		{
			((MyAttributes)getContainedComponent()).onCancelCobertura(null, null);
			return false; //necesario para que no se vuelve al componente doclist
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("editarofiti"))
		{
			((MyAttributes)getContainedComponent()).onCancelEditarOfiTI(null, null);
			return false; //necesario para que no se vuelve al componente doclist
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("editartitulaciones"))
		{
			((MyAttributes)getContainedComponent()).onCancelEditarTitulaciones(null, null);
			return false; //necesario para que no se vuelve al componente doclist
		}
		else if (getContainedComponent().getComponentPage().equalsIgnoreCase("editarcertificados"))
		{
			((MyAttributes)getContainedComponent()).onCancelEditarCertificados(null, null);
			return false;  //necesario para que no se vuelve al componente doclist
		}

		
		return super.onCancelChanges();
	}

	@Override
	public void onControlInitialized(Form arg0, Control control) 
	{
		if (control != null)
			if (control instanceof Label)
				if (control.getName() != null && control.getName().equalsIgnoreCase("micabecera"))
				{
					String codigo;
					try 
					{
						codigo = getDfSession().getObject(new DfId(mObjectId)).getString("do_nfop_cno");
						if (codigo != null)
							((Label)control).setLabel(codigo);
					} 
					catch (DfException e) 
					{
						DfLogger.error(this,"error al recuperar el código:" + e.getMessage(),null,null);
					}
				}
	}
}
