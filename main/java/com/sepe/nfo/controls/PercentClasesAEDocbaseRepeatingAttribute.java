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

public class PercentClasesAEDocbaseRepeatingAttribute extends DocbaseRepeatingAttribute 
{

	private static final long serialVersionUID = 1L;
	private List<String> mClases = new ArrayList<String>(); 
	
	@Override
	public void onInit(ArgumentList arg) 
	{
		super.onInit(arg);
		
		try 
		{
			MyAttributes myattributes = (MyAttributes) SessionState.getAttribute("myattributescomp");
			mClases = myattributes.getClasesAEAttributeValue();
			
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
			DfLogger.error(this, "error al llenar el vector de clases", null, null);
		}
	}

	/**
	 * 
	 * @param fila
	 * @param value: por ejemplo, "20"
	 */
	private void fillTextRow(int fila,String value)
	{
		Text t = (Text) getControl(fila + "c0",Text.class);
		t.setValue(new String(value));
	}
	

	private String getTextRow(int fila)
	{
		Text t = (Text) getControl(fila + "c0",Text.class);
		if (t.getValue().trim().equalsIgnoreCase(""))
			return "0";
		else
			return t.getValue();		
	}

	public List<String> getClasesAEAttributeValue() throws DfException 
	{
		return mClases;
	}

	@Override
	public void onClickOK(Button button, ArgumentList arg) 
	{
        List<String> ret = new ArrayList<String>();
        for (int fila=0;fila<mClases.size();fila++)
        {
        	String textrow = getTextRow(fila);
        	String forbiddenCharFound = validar(textrow); 
        	if (forbiddenCharFound != null)
        	{
        		printMessage("El carácter '" + forbiddenCharFound + "' no está permitido. Sólo se permiten carácteres numéricos y puntos decimales.");
        		return;
        	}
        	try
        	{
        		Double d = new Double(textrow);
        		if (d > 100)
        		{
            		printMessage("No se puede introducir un valor mayor que 100.");
            		return;
        		}
        	}
        	catch (NumberFormatException e)
        	{
        		printMessage("Se ha introducido un número no válido.");
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
			if (c.trim().equalsIgnoreCase("0")) continue;
			if (c.trim().equalsIgnoreCase("1")) continue;
			if (c.trim().equalsIgnoreCase("2")) continue;
			if (c.trim().equalsIgnoreCase("3")) continue;
			if (c.trim().equalsIgnoreCase("4")) continue;
			if (c.trim().equalsIgnoreCase("5")) continue;
			if (c.trim().equalsIgnoreCase("6")) continue;
			if (c.trim().equalsIgnoreCase("7")) continue;
			if (c.trim().equalsIgnoreCase("8")) continue;
			if (c.trim().equalsIgnoreCase("9")) continue;
			if (c.trim().equalsIgnoreCase(".")) continue;
			forbiddenCharFound = c;
		}
		return forbiddenCharFound;
	}
	
	private void printMessage(String message)
	{
		((Label)getControl("lblmsg",Label.class)).setLabel(message);		
	}
}
