package com.sepe.nfo.reports.data;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ActividadEconomicaBean implements Serializable {
	
	private String actividad;	
	private double porcentaje;
	
	public ActividadEconomicaBean() {}
	
	public ActividadEconomicaBean(String actividad, double porcentaje) {
		super();
		this.actividad = actividad;
		this.porcentaje = porcentaje;
	}

	public String getActividad() {
		return actividad;
	}

	public void setActividad(String actividad) {
		this.actividad = actividad;
	}

	public double getPorcentaje() {
		return porcentaje;
	}

	public void setPorcentaje(double porcentaje) {
		this.porcentaje = porcentaje;
	}

}
