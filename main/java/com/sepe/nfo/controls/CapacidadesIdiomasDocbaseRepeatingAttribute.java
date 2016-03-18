package com.sepe.nfo.controls;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.documentum.fc.common.DfException;
import com.documentum.fc.common.DfLogger;
import com.documentum.web.common.ArgumentList;
import com.documentum.web.common.SessionState;
import com.documentum.web.form.control.Button;
import com.documentum.web.form.control.Label;
import com.documentum.web.form.control.Text;
import com.documentum.web.formext.control.docbase.DocbaseRepeatingAttribute;
import com.sepe.nfo.components.MyAttributes;

public class CapacidadesIdiomasDocbaseRepeatingAttribute extends DocbaseRepeatingAttribute 
{

	private static final long serialVersionUID = 1L;
	private List<String> mIdiomas = new ArrayList<String>(); 
	
	@Override
	public void onInit(ArgumentList arg) 
	{
		super.onInit(arg);
		
		try 
		{
			MyAttributes myattributes = (MyAttributes) SessionState.getAttribute("myattributescomp");
			mIdiomas = myattributes.getIdiomasAttributeValue();
			
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
			DfLogger.error(this, "error al llenar el vector de idiomas", null, null);
		}
	}

	/**
	 * 
	 * @param fila
	 * @param value: por ejemplo, "ABBBC"
	 */
	private void fillTextRow(int fila,String value)
	{
		for (int i=0;i<value.length();i++)
		{
			String valor = value.substring(i,i+1); //por ejemplo, "A"
			try
			{
				Text t = (Text) getControl(fila + "c" + i,Text.class);
				t.setValue(new String(valor));
			}
			catch (java.lang.IndexOutOfBoundsException e)
			{
				continue;
			}
		}
	}
	
	/**
	 * 
	 * @param fila
	 * @return: por ejemplo: String[]{"A","B","B","B","C"}
	 */
	private String getTextRow(int fila)
	{
		String ret = "";;
		for (int c=0;c<=4;c++)
		{
			Text t = (Text) getControl(fila + "c" + c,Text.class);
			if (t.getValue().trim().equalsIgnoreCase(""))
				ret = ret +  "-";
			else
				ret = ret +  t.getValue().toUpperCase();
		}
		
		return ret;
	}

	public List<String> getIdiomasAttributeValue() throws DfException 
	{
		return mIdiomas;
	}

	@Override
	public void onClickOK(Button button, ArgumentList arg) 
	{
        List<String> ret = new ArrayList<String>();
        for (int fila=0;fila<mIdiomas.size();fila++)
        {
        	String textrow = getTextRow(fila);
        	String forbiddenCharFound = validar(textrow); 
        	if (forbiddenCharFound != null)
        	{
        		printMessage("El carácter '" + forbiddenCharFound + "' no está permitido. Sólo se permiten los carácteres siguientes: A, B, C, -");
        		return;
        	}
        	ret.add(textrow);
        }
        
		setReturnValue("updateAttributeValues", ret);
        cleanupPageContext();
        setComponentReturn();
	}
	
	private String validar(String row)
	{
		String forbiddenCharFound = null;
		for (int i=0;i<row.length();i++)
		{
			String c = row.substring(i,i+1).trim();
			if (c.trim().equalsIgnoreCase("A")) continue;
			if (c.trim().equalsIgnoreCase("B")) continue;
			if (c.trim().equalsIgnoreCase("C")) continue;
			if (c.trim().equalsIgnoreCase("-")) continue;
			if (c.trim().equalsIgnoreCase("")) continue;
			forbiddenCharFound = c;
		}
		return forbiddenCharFound;
	}
	
	private void printMessage(String message)
	{
		((Label)getControl("lblmsg",Label.class)).setLabel(message);		
	}
}
