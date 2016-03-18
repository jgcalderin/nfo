package com.sepe.nfo.reports.data;

import java.io.Serializable;

@SuppressWarnings("serial")
public class IdiomaBean implements Serializable {
	
	private String idioma;	
	private String nivelCompAuditiva;
	private String nivelCompLectura;
	private String nivelInteracOral;
	private String nivelExprOral;
	private String nivelEscritura;
	
	public IdiomaBean() {}

	public IdiomaBean(String idioma, String nivelCompAuditiva,
			String nivelCompLectura, String nivelInteracOral, String nivelExprOral,
			String nivelEscritura) {	
		super();
		this.idioma = idioma;
		this.nivelCompAuditiva = nivelCompAuditiva;
		this.nivelCompLectura = nivelCompLectura;
		this.nivelInteracOral = nivelInteracOral;
		this.nivelExprOral = nivelExprOral;
		this.nivelEscritura = nivelEscritura;
	}

	public String getIdioma() {
		return idioma;
	}

	public void setIdioma(String idioma) {
		this.idioma = idioma;
	}

	public String getNivelCompAuditiva() {
		return nivelCompAuditiva;
	}

	public void setNivelCompAuditiva(String nivelCompAuditiva) {
		this.nivelCompAuditiva = nivelCompAuditiva;
	}

	public String getNivelCompLectura() {
		return nivelCompLectura;
	}

	public void setNivelCompLectura(String nivelCompLectura) {
		this.nivelCompLectura = nivelCompLectura;
	}

	public String getNivelInteracOral() {
		return nivelInteracOral;
	}

	public void setNivelInteracOral(String nivelInteracOral) {
		this.nivelInteracOral = nivelInteracOral;
	}

	public String getNivelExprOral() {
		return nivelExprOral;
	}

	public void setNivelExprOral(String nivelExprOral) {
		this.nivelExprOral = nivelExprOral;
	}

	public String getNivelEscritura() {
		return nivelEscritura;
	}

	public void setNivelEscritura(String nivelEscritura) {
		this.nivelEscritura = nivelEscritura;
	}
	
}
