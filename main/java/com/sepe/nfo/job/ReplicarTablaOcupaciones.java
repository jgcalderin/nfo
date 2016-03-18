package com.sepe.nfo.job;

import java.io.FileNotFoundException;
import java.io.PrintWriter;

import com.documentum.fc.client.IDfSession;
import com.documentum.fc.common.DfException;
import com.sepe.nfo.job.gtspee.GTSPEETablas;

import es.spee.arq.gtspee.GTSPEEException;

public class ReplicarTablaOcupaciones extends ReplicarTablaLV
{

	public ReplicarTablaOcupaciones(
			String lvTableName,
			String nombreCampoCorto, 
			String nombreCampoLargo,
			int lenCampoCorto, 
			int lenCampoLargo,
			PrintWriter print,
			IDfSession idfsession,
			boolean testonly) 
	{
		super(
				lvTableName, 
				nombreCampoCorto, 
				nombreCampoLargo, 
				lenCampoCorto,
				lenCampoLargo,
				print,
				idfsession,
				testonly
			);
	}

	public static final String LV_TYPE_NAME = "do_nfop_lv_cno";
	public static final int MIN_EXPECTED_TABLE_SIZE = 100;
	public static final String NOMBRE_CAMPO_CORTO = "codigo4";
	public static final String NOMBRE_CAMPO_LARGO = "codigo8";
	public static final int LENGTH_CAMPO_CORTO = 4;
	public static final int LENGTH_CAMPO_LARGO = 8;
	public static final String NOMBRE_TABLA_GTSPEE = "ClasifOcupacional";

	public void execute(String separadorCols, String separadorRows) throws DfException, FileNotFoundException, GTSPEEException
	{
		String tabledata = getTableData();
		super.execute(tabledata, separadorCols, separadorRows);
	}
	
	private String getTableData() throws FileNotFoundException, GTSPEEException 
	{
		return GTSPEETablas.getTableData(ReplicarTablaOcupaciones.NOMBRE_TABLA_GTSPEE, null,null,null,null,super.out);
	}
	
}
