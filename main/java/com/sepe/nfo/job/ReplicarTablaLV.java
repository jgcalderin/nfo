package com.sepe.nfo.job;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Hashtable;

import com.documentum.fc.client.DfQuery;
import com.documentum.fc.client.IDfPersistentObject;
import com.documentum.fc.client.IDfSession;
import com.documentum.fc.common.DfException;

import es.spee.arq.gtspee.GTSPEEException;

public class ReplicarTablaLV 
{

	private Hashtable<String, String> htNombreCorto = new Hashtable<String, String>();
	private final int MIN_EXPECTED_TABLE_SIZE = 50;
	
	private String LV_TYPE_NAME = "do_nfop_lv_cno";
	private String NOMBRE_CAMPO_CORTO = "codigo4";
	private String NOMBRE_CAMPO_LARGO = "codigo8";
	private int LENGTH_CAMPO_CORTO = 4;
	private int LENGTH_CAMPO_LARGO = 8;
	
	protected PrintWriter out;
	private IDfSession session;
	private boolean testOnly = false;
	
	public ReplicarTablaLV(
			String lvTableName,
			String nombreCampoCorto, 
			String nombreCampoLargo, 
			int lenCampoCorto,
			int lenCampoLargo,
			PrintWriter print,
			IDfSession idfsession,
			boolean testonly)
	{
		NOMBRE_CAMPO_CORTO = nombreCampoCorto;
		NOMBRE_CAMPO_LARGO = nombreCampoLargo;
		LV_TYPE_NAME = lvTableName; 
		LENGTH_CAMPO_CORTO = lenCampoCorto;
		LENGTH_CAMPO_LARGO = lenCampoLargo;
		out = print;
		session = idfsession;
		this.testOnly = testonly;
	}
	
	public void execute(String tabla, String separadorCols, String separadorRows) throws DfException, FileNotFoundException, GTSPEEException
	{
		try
		{
			String[] filas = tabla.split(separadorRows);
			if (filas.length < MIN_EXPECTED_TABLE_SIZE)
			{
				out.println("el número de filas es menor que " + MIN_EXPECTED_TABLE_SIZE + ", algo raro ha pasado. Salimos");
				return;
			}
			
			if (separadorCols == null)
				separadorCols = "#";
			
			if (separadorRows ==null)
				separadorRows= "\n";
			
			vaciarTabla();
			
			for (int i=0;i<filas.length;i++)
			{
				String fila = filas[i];
				System.out.println("fila:" + fila);
				String[] cols = fila.split(separadorCols);
				
				String id=cols[0];
				String desclarga=cols[1];
				if (id.length() == LENGTH_CAMPO_CORTO)
				{
					htNombreCorto.put(id, id + "-" + desclarga);
				}
				else if (id.length() == LENGTH_CAMPO_LARGO)
				{
					System.out.println("\tid:" + id);
					insertInDctm (cols);
				}
				else if (LENGTH_CAMPO_CORTO ==-1)
				{
					insertInDctm (cols);					
				}
			}
		}
		catch(DfException e)
		{
			throw e;
		}
		finally
		{
			
		}
	}
	
	protected void vaciarTabla() throws DfException 
	{
		if (testOnly) 
		{
			out.println("tesonly=true: no se borrará " + LV_TYPE_NAME);
			return;
		}
		
		DfQuery dquery = new DfQuery();
		dquery.setDQL("delete objects from " + LV_TYPE_NAME );
		//TODO: DESCOMENTAR
		//dquery.execute(session, IDfQuery.EXEC_QUERY);
	}

	protected void insertInDctm(String[] cols) throws DfException
	{
		String id = cols[0];
		String desclarga = cols[1];

		String valorLargo = id + "-" + desclarga;
		String valorCorto = htNombreCorto.get(id.substring(0,LENGTH_CAMPO_CORTO));
		
		IDfPersistentObject newvalue = session.newObject(LV_TYPE_NAME);
		newvalue.setString(NOMBRE_CAMPO_CORTO,valorCorto);
		newvalue.setString(NOMBRE_CAMPO_LARGO,valorLargo);
		newvalue.setString("object_name",valorLargo);
		if (testOnly) 
		{
			out.println("tesonly=true: object_name = " + valorLargo + ",typename=" + LV_TYPE_NAME);
			return;
		}

		//TODO: DESCOMENTAR
		//newvalue.save();
	}
}
