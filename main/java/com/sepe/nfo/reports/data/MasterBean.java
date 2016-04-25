package com.sepe.nfo.reports.data;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import com.documentum.fc.client.IDfSysObject;
import com.documentum.fc.common.DfException;

public class MasterBean 
{

	List<ConocimientoBean> conocimientosDireccion = new ArrayList<ConocimientoBean>();
	List<ConocimientoBean> conocimientosAAPP = new ArrayList<ConocimientoBean>();
	List<ConocimientoBean> conocimientosFinancieros = new ArrayList<ConocimientoBean>();
	List<ConocimientoBean> conocimientosJuridicos = new ArrayList<ConocimientoBean>();
	List<ConocimientoBean> conocimientosTEquipo = new ArrayList<ConocimientoBean>();
	List<IdiomaBean> idiomas = new ArrayList<IdiomaBean>();
	List<ConocimientoBean> conocimientosATTPub = new ArrayList<ConocimientoBean>();
	List<ConocimientoBean> conocimientosPersonales = new ArrayList<ConocimientoBean>();
	List<ActividadEconomicaBean> aaeeMasRep = new ArrayList<ActividadEconomicaBean>();
	int year = 2015;
	List<ConocimientoBean> conocimientosCalculo = new ArrayList<ConocimientoBean>();
	List<ConocimientoBean> conocimientosTI = new ArrayList<ConocimientoBean>();
	List<ConocimientoBean> conocimientosResolucionProblemas = new ArrayList<ConocimientoBean>();
	int totalcontratos = 0;
	int yeartotalcontratos = 2015;
	String necesidades = "";
	String division = "";
	String ocupacion = "";
	String sumaPorcentaje = "";
	StringBuffer conocimientosGenericos = new StringBuffer();
	String mVacantes = "";
	

	public MasterBean(IDfSysObject ficha) throws DfException
    {
    	//IDIOMA:
		int count = ficha.getValueCount("do_nfop_ctra_idioma");
    	for (int i=0;i<count;i++)
    	{
    		String idioma = ficha.getRepeatingString("do_nfop_ctra_idioma", i);
    		String niveles = ficha.getRepeatingString("do_nfop_ctra_idioma_c", i).toUpperCase();
    		String nivel1 = ""; String nivel2 = ""; String nivel3 = ""; String nivel4 = ""; String nivel5="";
    		try
    		{
    			nivel1 = niveles.substring(0,1);
    		}
    		catch(IndexOutOfBoundsException e)
    		{
    			//ignore
    		}
    		try
    		{
    			nivel2 = niveles.substring(1,2);
    		}
    		catch(IndexOutOfBoundsException e)
    		{
    			//ignore
    		}
    		try
    		{
    			nivel3 = niveles.substring(2,3);
    		}
    		catch(IndexOutOfBoundsException e)
    		{
    			//ignore
    		}
    		try
    		{
    			nivel4 = niveles.substring(3,4);
    		}
    		catch(IndexOutOfBoundsException e)
    		{
    			//ignore
    		}
    		try
    		{
    			nivel5 = niveles.substring(4);
    		}
    		catch(IndexOutOfBoundsException e)
    		{
    			//ignore
    		}
    		idiomas.add(new IdiomaBean(idioma,nivel1,nivel2,nivel3,nivel4,nivel5));
    	}

    	//OFIMÁTICA/TECNOLOGÍAS DE LA INFORMACIÓN Y COMUNICACIÓN
		count = ficha.getValueCount("do_nfop_ctra_ofiti");
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_ofiti", i);
    		String nivel = ficha.getRepeatingString("do_nfop_ctra_ofiti_c",i);
    		conocimientosTI.add(new ConocimientoBean(conocimiento,nivel));
    	}

    	//CONOCIMIENTOS FINANCIEROS
		count = ficha.getValueCount("do_nfop_ctra_fin");
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_fin", i);
    		String nivel = "N/A";
    		conocimientosFinancieros.add(new ConocimientoBean(conocimiento,nivel));
    	}
    	
    	//CONOCIMIENTOS NORMATIVOS / JURÍDICOS
		count = ficha.getValueCount("do_nfop_ctra_jur");
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_jur", i);
    		String nivel = "N/A";
    		conocimientosJuridicos.add(new ConocimientoBean(conocimiento,nivel));
    	}    	

    	//CONOCIMIENTOS DE LAS ADMINISTRACIONES PÚBLICAS
		count = ficha.getValueCount("do_nfop_ctra_func_app");
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_func_app", i);
    		String nivel = "N/A";
    		conocimientosAAPP.add(new ConocimientoBean(conocimiento,nivel));
    	}

    	/**************************************************************************/
    	//de aqui para abajo, van todos en un mismo campo de texto
    	
    	//CÁLCULO Y COMUNICACIÓN ORAL Y ESCRITA
		count = ficha.getValueCount("do_nfop_ctra_calc");
		
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_calc", i);
    		String nivel = "N/A";
    		//este bloque for debe ir primero, porque se valida if i==0 para evitar empezar por ";"
    		if (i==0)
    			conocimientosGenericos.append(conocimiento);
    		else
    			conocimientosGenericos.append(";" + conocimiento);
    		
    		conocimientosCalculo.add(new ConocimientoBean(conocimiento,nivel));
    	}

    	//NECESIDADES FORMATIVAS EN DIRECCIÓN
		count = ficha.getValueCount("do_nfop_ctra_dir");
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_dir", i);
    		String nivel = "N/A";
			conocimientosGenericos.append(";" + conocimiento);
    		conocimientosDireccion.add(new ConocimientoBean(conocimiento,nivel));
    	}
    	
    	//RESOLUCIÓN DE PROBLEMAS / TOMA DE DECISIONES
		count = ficha.getValueCount("do_nfop_ctra_res");
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_res", i);
    		String nivel = "N/A";
			conocimientosGenericos.append(";" + conocimiento);
    		conocimientosResolucionProblemas.add(new ConocimientoBean(conocimiento,nivel));
    	}

    	//TRABAJO EN EQUIPO
		count = ficha.getValueCount("do_nfop_ctra_t_equipo");
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_t_equipo", i);
    		String nivel = "N/A";
			conocimientosGenericos.append(";" + conocimiento);
    		conocimientosTEquipo.add(new ConocimientoBean(conocimiento,nivel));
    	}
    	
    	//ATT AL PUBLICO
		count = ficha.getValueCount("do_nfop_ctra_att_pub");
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_att_pub", i);
    		String nivel = "N/A";
			conocimientosGenericos.append(";" + conocimiento);
    		conocimientosATTPub.add(new ConocimientoBean(conocimiento,nivel));
    	}
    	
    	//CONOCIMIENTOS PERSONALES
		count = ficha.getValueCount("do_nfop_ctra_pers");
    	for (int i=0;i<count;i++)
    	{
    		String conocimiento = ficha.getRepeatingString("do_nfop_ctra_pers", i);
    		String nivel = "N/A";
			conocimientosGenericos.append(";" + conocimiento);
    		conocimientosPersonales.add(new ConocimientoBean(conocimiento,nivel));
    	}
    	
    	//ACTIVIDADES ECONOMICAS MAS REPRESENTATIVAS
		count = ficha.getValueCount("do_nfop_aer_titulaciones");
    	for (int i=0;i<count;i++)
    	{
    		String actividad = ficha.getRepeatingString("do_nfop_aer_titulaciones", i);
    		double porcentaje = ficha.getRepeatingDouble("do_nfop_aer_perc_contrat",i);
    		aaeeMasRep.add(new ActividadEconomicaBean(actividad,porcentaje));
    	}
    	
    	//AÑO
    	year  = ficha.getInt("do_nfop_year");
    	
    	
    	//total contratos:
    	totalcontratos  = ficha.getInt("do_nfop_aer_t_contratos");
    	
    	//AÑO
    	yeartotalcontratos   = ficha.getInt("do_nfop_aer_y_contratos");
    	
    	//NECESIDADES FORMATIVAS
    	necesidades  = ficha.getString("do_nfop_necesidades");
    	
    	//división de Actividad Económica que mantiene la tendencia de mayor contratación
    	division  = ficha.getString("do_nfop_aer_division");
    	
    	//OCUPACION
    	ocupacion  = ficha.getString("do_nfop_cno");
    	
    	//SUMA PORCENTAJES
    	double dsuma = 0;
		count = ficha.getValueCount("do_nfop_aer_titulaciones");
    	for (int i=0;i<count;i++)
    	{
			double d = (new Double(ficha.getRepeatingDouble("do_nfop_aer_perc_contrat",i))).doubleValue();
			dsuma = dsuma + d;
    	}
    	
    	DecimalFormat df = new DecimalFormat("#.##");
    	df.setRoundingMode(RoundingMode.CEILING);
    	sumaPorcentaje = df.format(dsuma);
    	
    	//VACANTES:
    	String vacantessincubrir = ficha.getString("do_nfop_icua_vacantes");
    	String vacantessecubrendif = ficha.getString("do_nfop_icua_vacantes_dif");
    	int vacantesdias = ficha.getInt("do_nfop_icua_vacantes_dias");
    	if (vacantessincubrir!=null)
    	{
    		if (vacantessincubrir.equalsIgnoreCase("sí"))
    		{
    			mVacantes = "Los expertos manifiestan que las vacantes se cubren ";
    			if (vacantessecubrendif.equalsIgnoreCase("fácilmente") || vacantessecubrendif.equalsIgnoreCase("difícilmente"))
    				mVacantes = mVacantes + vacantessecubrendif.toLowerCase();
    			else if (vacantessecubrendif.equalsIgnoreCase("Dificultad Media"))
    				mVacantes = mVacantes + "con " + vacantessecubrendif.toLowerCase();
    			
    			if (vacantesdias == 1)
    				mVacantes = mVacantes +  " (1 día)";
    			else if (vacantesdias > 1)
    				mVacantes = mVacantes +  " (" + vacantesdias + " días)";
    			//si vacantesdias = 0 --> no aparecen los parentesis, como pidio el usuario
    			
    		}
    		else if (vacantessincubrir.equalsIgnoreCase("no"))
    		{
    			//mVacantes = "Noy hay vacantes sin cubrir";
    		}
    	}
    	
    }
    
	public String getConocimientosGenericos()
	{
		return  conocimientosGenericos.toString();
	}
	
	public String getVacantes()
	{
		return mVacantes;
	}
	
	public List<ConocimientoBean> getConoDireccion()
    {
    	return conocimientosDireccion;
    }
    
    public List<ConocimientoBean> getConoAdminPublicas()
    {
    	return conocimientosAAPP;
    }
    
    public List<ConocimientoBean> getConoFinancieros()
    {
    	return conocimientosFinancieros;
    }
    
    public List<ConocimientoBean> getConoJuridicos()
    {
    	return conocimientosJuridicos;
    }
    
    public List<ConocimientoBean> getConoTrabajoEquipo()
    {
    	return conocimientosTEquipo;
    }
    
    public List<IdiomaBean> getConoIdiomas()
    {    	
    	return idiomas;
    }
    
    public List<ConocimientoBean> getConoAtencionPublico()
    {
    	return conocimientosATTPub;
    }
    
    public List<ConocimientoBean> getConoPersonales()
    {
    	return conocimientosPersonales;
    }
    
    
    public List<ActividadEconomicaBean> getActividades()
    {
    	return aaeeMasRep ;
    }
    
    public int getAnio()
    {
    	return year;
    }
    
    public List<ConocimientoBean> getConoCalculo()
    {
    	return conocimientosCalculo ;	
    }
    
    public List<ConocimientoBean> getConoInformatica()
    {
    	return conocimientosTI ;    	
    }

    public List<ConocimientoBean> getConoResolucionProblemas()
    {
    	return conocimientosResolucionProblemas ;    	
    }

    public int getAerTotalContratos()
    {
    	return totalcontratos;
    }
    
    public int getAerAnio()
    {
    	return yeartotalcontratos;
    }

    public String getNecesidades()
    {
    	return necesidades; 
    }
    
    public String getAerDivision()
    {
    	return division;
    }
    
    public String getOcupacion()
    {
    	return ocupacion;
    }
    
    public String getSumaPorcentaje()
    {
    	return sumaPorcentaje;
    }
}
