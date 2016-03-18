package com.sepe.nfo.job.gtspee;

import java.io.FileNotFoundException;
import java.io.PrintWriter;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.documentum.fc.common.DfLogger;

import es.spee.arq.gtspee.AccesoGTSPEE;
import es.spee.arq.gtspee.ConsultaGTSPEE;
import es.spee.arq.gtspee.FilaGTSPEE;
import es.spee.arq.gtspee.GTSPEEException;

public class GTSPEETablas 
{

	private static PrintWriter out;

	public static synchronized String getTableData(
			String tablename,
			String[] fields, 
			String orderby, 
			String colseparator,
			String rowseparator,
			PrintWriter out) throws FileNotFoundException, GTSPEEException 
	{
		if (colseparator == null)
			colseparator = "#";
		
		if (rowseparator == null)
			rowseparator = "\n";

		ApplicationContext context = 
				new ClassPathXmlApplicationContext(new String[] { "classpath*:/conf/arqContext.xml" });

		ConsultaGTSPEE<FilaGTSPEE> consultaGTSPEE = new ConsultaGTSPEE<FilaGTSPEE>("es");
		
		consultaGTSPEE.anadirCamposTabla(tablename);
		if (fields == null)
			fields = new String[]{"Id","DescripcionLarga"};
		
		for (int i=0;i<fields.length;i++)
			consultaGTSPEE.anadirCampo(tablename + "." + fields[i]);
		
		if (orderby != null)
			consultaGTSPEE.anadirOrdenCampo(tablename + "." + orderby);
		else
			consultaGTSPEE.anadirOrdenCampo(tablename + "." + fields[0]);


		try 
		{
			AccesoGTSPEE.consultar(consultaGTSPEE);
			StringBuffer sbTable = new StringBuffer();
			
			if (consultaGTSPEE.getNumeroFilas() >= 1) 
			{
				for (int i = 0; i < consultaGTSPEE.getNumeroFilas(); i++) 
				{
					String row = "";
					for (int j=0;j<fields.length;j++)
					{
						String f = consultaGTSPEE.getFila(i).getDato(tablename + "." + fields[j]);
						if (j>0)
							row = row + colseparator + f;
						else
							row = f;
					}
					sbTable.append(row + rowseparator);
				}

			}
			print("devolvemos tabla GTSPEE, de longitud " + consultaGTSPEE.getNumeroFilas());
			return sbTable.toString();
		}
		catch (GTSPEEException e) 
		{
			DfLogger.error(GTSPEETablas.class,"error al recuperar tabla " + tablename + " de GTSPEE:" + e.getMessage(),null,null);
			throw e;
		}
	}
	
	private static synchronized void print(String message)
	{
		DfLogger.debug(GTSPEETablas.class, message, null, null);
		if (out != null)
			out.println("message");
	}
}
