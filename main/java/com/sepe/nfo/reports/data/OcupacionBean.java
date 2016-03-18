package com.sepe.nfo.reports.data;

import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
public class OcupacionBean implements Serializable {
	
	private String ocupacion;
	private int anio;
	private String necesidades;
	
	// Competencias transversales
	private List<IdiomaBean> conoIdiomas;
	private List<ConocimientoBean> conoInformatica;
	private List<ConocimientoBean> conoJuridicos;
	private List<ConocimientoBean> conoFinancieros;
	private List<ConocimientoBean> conoAdminPublicas;
	private String conoGenericos;
	private String vacantes;
	
	// Actividades económicas mas representativas
	private int aerTotalContratos;
	private int aerAnio;
	private List<ActividadEconomicaBean> actividades;
	private String aerDivision;
	private String sumaPorcentaje;
	

	public OcupacionBean() {}

	
	public String getOcupacion() {
		return ocupacion;
	}


	public void setOcupacion(String ocupacion) {
		this.ocupacion = ocupacion;
	}


	public int getAnio() {
		return anio;
	}


	public void setAnio(int anio) {
		this.anio = anio;
	}


	public String getNecesidades() {
		return necesidades;
	}


	public void setNecesidades(String necesidades) {
		this.necesidades = necesidades;
	}


	public List<ConocimientoBean> getConoFinancieros() {
		return conoFinancieros;
	}


	public void setConoFinancieros(List<ConocimientoBean> conoFinancieros) {
		this.conoFinancieros = conoFinancieros;
	}


	public List<IdiomaBean> getConoIdiomas() {
		return conoIdiomas;
	}


	public void setConoIdiomas(List<IdiomaBean> conoIdiomas) {
		this.conoIdiomas = conoIdiomas;
	}


	public List<ConocimientoBean> getConoJuridicos() {
		return conoJuridicos;
	}


	public void setConoJuridicos(List<ConocimientoBean> conoJuridicos) {
		this.conoJuridicos = conoJuridicos;
	}


	public List<ConocimientoBean> getConoAdminPublicas() {
		return conoAdminPublicas;
	}


	public void setConoAdminPublicas(List<ConocimientoBean> conoAdminPublicas) {
		this.conoAdminPublicas = conoAdminPublicas;
	}


	public List<ConocimientoBean> getConoInformatica() {
		return conoInformatica;
	}


	public void setConoInformatica(List<ConocimientoBean> conoInformatica) {
		this.conoInformatica = conoInformatica;
	}


	public int getAerTotalContratos() {
		return aerTotalContratos;
	}


	public void setAerTotalContratos(int aerTotalContratos) {
		this.aerTotalContratos = aerTotalContratos;
	}


	public int getAerAnio() {
		return aerAnio;
	}


	public void setAerAnio(int aerAnio) {
		this.aerAnio = aerAnio;
	}


	public List<ActividadEconomicaBean> getActividades() {
		return actividades;
	}


	public void setActividades(List<ActividadEconomicaBean> actividades) {
		this.actividades = actividades;
	}


	public String getAerDivision() {
		return aerDivision;
	}


	public void setAerDivision(String aerDivision) {
		this.aerDivision = aerDivision;
	}


	public String getSumaPorcentaje() {
		return sumaPorcentaje;
	}


	public void setSumaPorcentaje(String sumaPorcentaje) {
		this.sumaPorcentaje = sumaPorcentaje;
	}


	public String getConoGenericos() {
		return conoGenericos;
	}


	public void setConoGenericos(String conoGenericos) {
		this.conoGenericos = conoGenericos;
	}


	public String getVacantes() {
		return vacantes;
	}


	public void setVacantes(String vacantes) {
		this.vacantes = vacantes;
	}

}
