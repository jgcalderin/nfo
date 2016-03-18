package com.sepe.nfo.controls;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.documentum.fc.common.DfException;
import com.documentum.fc.common.DfLogger;
import com.documentum.web.common.ArgumentList;
import com.documentum.web.common.SessionState;
import com.documentum.web.form.control.Button;
import com.documentum.web.form.control.DropDownList;
import com.documentum.web.formext.control.docbase.DocbaseRepeatingAttribute;
import com.sepe.nfo.components.MyAttributes;

public class CapacidadesOfimaticaDocbaseRepeatingAttribute extends DocbaseRepeatingAttribute 
{

	private static final long serialVersionUID = 1L;
	private List<String> mOfiTi = new ArrayList<String>(); 
	
	@Override
	public void onInit(ArgumentList arg) 
	{
		super.onInit(arg);
		
		try 
		{
			MyAttributes myattributes = (MyAttributes) SessionState.getAttribute("myattributescomp");
			mOfiTi = myattributes.getOfimaticaAttributeValue();
			
			Vector vec = (Vector)getPageContext().getAttribute((new StringBuilder()).append("string_").append(getControlId()).toString(), 3);
	        if(vec != null)
	        {
	            for(int i = 0; i < vec.size(); i++)
	            {
	                fillTextRow(i,(String)vec.get(i));
	            }
	        }
		} 
		catch (DfException e) 
		{
			e.printStackTrace();
			DfLogger.error(this, "error al llenar el vector de ofimatica", null, null);
		}
	}

	/**
	 * 
	 * @param fila
	 * @param value: por ejemplo, "20"
	 */
	private void fillTextRow(int fila,String value)
	{
		DropDownList t = (DropDownList) getControl(fila + "c0",DropDownList.class);
		t.setValue(new String(value));
	}
	

	private String getTextRow(int fila)
	{
		DropDownList t = (DropDownList) getControl(fila + "c0",DropDownList.class);
		if (t.getValue().trim().equalsIgnoreCase(""))
			return "-";
		else
			return t.getValue();		
	}

	public List<String> getOfimaticaAttributeValue() throws DfException 
	{
		return mOfiTi;
	}

	@Override
	public void onClickOK(Button button, ArgumentList arg) 
	{
        List<String> ret = new ArrayList<String>();
        for (int fila=0;fila<mOfiTi.size();fila++)
        {
        	String textrow = getTextRow(fila);
        	ret.add(textrow);
        }
        
		setReturnValue("updateAttributeValues", ret);
        cleanupPageContext();
        setComponentReturn();
	}	
}
