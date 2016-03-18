package com.sepe.nfo.job;

import java.io.PrintWriter;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import com.documentum.fc.client.DfSingleDocbaseModule;
import com.documentum.fc.client.IDfModule;
import com.documentum.fc.client.IDfSession;
import com.documentum.fc.client.IDfSessionManager;
import com.documentum.fc.common.DfException;
import com.documentum.fc.methodserver.IDfMethod;

public class ReplicaJob extends  DfSingleDocbaseModule implements IDfMethod, IDfModule 
{

	public PrintWriter out;
    int Result;
    boolean replicarOcupaciones = false;
    boolean TESTONLY = false;
    
    public ReplicaJob()
    {
    	
    }
	@Override
	public int execute(Map params, PrintWriter printer) throws Exception 
	{
		// TODO Auto-generated method stub
		int resultado = 0;
		IDfSessionManager sessionMgr=null;
 		IDfSession sesion = null;
 		try{
 		
 			out = printer;
  		    out.println(construirFechaLog() + " Inicio del proceso de replica de listas de valores - v 01-02-2016");

	        String docbaseName = this.getDocbaseName();
	        sessionMgr = this.getSessionManager();
	        sesion = sessionMgr.getSession(docbaseName);
 			
  		    out.println(construirFechaLog() + " Sesión iniciada: " + sesion.toString());

  		    out.println(construirFechaLog() + " Conectado con usuario: " + sesion.getLoginUserName());
  		    out.println(construirFechaLog() + " Conectado a docbase: " + sesion.getDocbaseName());
  		    
  		    Iterator entries = params.entrySet().iterator();
			out.println("Argumentos:");
			while (entries.hasNext()) 
			{
				Entry thisEntry = (Entry) entries.next();
				String key = (String) thisEntry.getKey();
				if (key.equalsIgnoreCase("-ocupaciones"))
				{
					replicarOcupaciones = true;
				}
				else if (key.equalsIgnoreCase("-test"))
				{
					TESTONLY = true; //no se guardará nada en docbase
				}

			}

			/***************************************************************************/
			if (replicarOcupaciones)
			{
				ReplicarTablaOcupaciones replicador = new ReplicarTablaOcupaciones(
						ReplicarTablaOcupaciones.LV_TYPE_NAME,
						ReplicarTablaOcupaciones.NOMBRE_CAMPO_CORTO,
						ReplicarTablaOcupaciones.NOMBRE_CAMPO_LARGO,
						ReplicarTablaOcupaciones.LENGTH_CAMPO_CORTO,
						ReplicarTablaOcupaciones.LENGTH_CAMPO_LARGO,
						out,
						sesion,
						TESTONLY
						);
				replicador.execute(null,null);
				out.println("replica de ocupaciones realizada");
			}
				
  		  
		 	//getParametros(params);
  		    //out.println(construirFechaLog() + " Leidos parametros\n ");
		 	//printParametros(parameters);
 		
  		    resultado = 0;		    
  		    
 		}catch(DfException dfe)
		{
 			out.println(construirFechaLog() + " Errror en el proceso principal: "+ dfe.getMessage());
			resultado=-1;
			
		}catch(Exception ex)
		{
			out.println(construirFechaLog() + " Errror en el proceso principal: "+ ex.getMessage());
			resultado=-1;
		}
		finally{
    		//Liberar DCMT Sesion
    		if(sesion != null){
    			//Liberar DCMT Sesion
        		if(sesion != null)
        		{
        			String id="";
					try {
						id = sesion.getSessionId();
					} catch (DfException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
        			sessionMgr.release(sesion);    			
        			out.println(construirFechaLog() + " Sesión '" + id + "' liberada en la docbase");
        		}
    		}
		}
		out.println(construirFechaLog() + " Resultado final: " + Result);
		
		return resultado;
	}
	
	/**
	 * Obtiene la fecha del sistema
	 * @return	String con al fecha del sistema.
	 */
	public  String construirFechaLog()
	{
		String fecha=null;
		try
		{
			Calendar c = new GregorianCalendar();
			fecha = c.getTime().toString();
		}
		catch(Exception e)
		{
			out.println(construirFechaLog() + " Error en el método construirFechaLog(): " + e.getMessage());					
		}
		return fecha;
	}

}
