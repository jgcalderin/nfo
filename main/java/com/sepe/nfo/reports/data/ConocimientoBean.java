package com.sepe.nfo.reports.data;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ConocimientoBean implements Serializable {
	
	private String conocimiento;	
	private String nivel;
	
	public ConocimientoBean() {}
	
	public ConocimientoBean(String conocimiento, String nivel) {
		super();
		this.setConocimiento(conocimiento);
		this.nivel = nivel;
	}

	public String getConocimiento() {
		return conocimiento;
	}

	public void setConocimiento(String conocimiento) {
		this.conocimiento = conocimiento;
	}

	public String getNivel() {
		return nivel;
	}

	public void setNivel(String nivel) {
		this.nivel = nivel;
	}
}
