
<%@page import="com.documentum.web.env.PageContextWrapper"%>
<%
	//
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page errorPage="/wdk/errorhandler.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf"%>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx"%>
<%@ page import="com.documentum.web.env.PageContextWrapper" %>
<%@ page import="com.documentum.web.formext.control.docbase.DocbaseObject" %>
<%@ page import="com.documentum.web.form.IParams" %>
<%@ page import="com.sepe.nfo.components.MyAttributes" %>

<%
	//
	MyAttributes myatts = (MyAttributes)pageContext.getAttribute(IParams.FORM, PageContext.REQUEST_SCOPE);
	DocbaseObject dobj = (DocbaseObject)myatts.getControl("obj",DocbaseObject.class);
	
	String titulos[] = myatts.getRepeatingValue("do_nfop_icua_certificados","#");
	String urls[] = myatts.getURLsFromTitulos(titulos);
	String parados[] = myatts.getRepeatingValue("do_nfop_icua_parados_cert");
	
	parados = myatts.paddArray(parados,titulos.length,"??");
	
%>
<dmf:html>
<dmf:head>
	<dmf:webform />
</dmf:head>
<dmf:body cssclass='contentBackground'>
	<dmf:form>
		<dmfx:docbaseobject name="obj" configid="attributes" />
		<dmf:tabbar name="tabs">
			<dmf:tab name="tab1" value="NNFF Competencias Téc. Profesionales" onclick="onClickTab"/>
			<dmf:tab name="tab2" value="NNFF Competencias Transversales" onclick="onClickTab"/>
			<dmf:tab name="tab3" value="Información Cualitativa de MT" onclick="onClickTab"/>
			<dmf:tab name="tab4" value="Actividades Económicas Representativas" onclick="onClickTab"/>
			<dmf:tab name="tab5" value="Documentos Adjuntos" onclick="onClickTab"/>
		</dmf:tabbar>
		<br>
		<table>
			<tr><td align="right" style="font-weight:bold" nowrap>
			Tendencia</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_tendencia" attribute="do_nfop_icua_tendencia" object="obj"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold;" nowrap>
			</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_tendencia_ex" attribute="do_nfop_icua_tendencia_ex" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
			
			<tr><td align="right" style="font-weight:bold" nowrap>
			Cambios Previsibles</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_cambios" attribute="do_nfop_icua_cambios" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold" nowrap>			
			Necesidades Futuras</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_nec_futuras" attribute="do_nfop_icua_nec_futuras" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold" nowrap>			
			Nuevas Ocupaciones</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_nuevas_ocup" attribute="do_nfop_icua_nuevas_ocup" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold" nowrap>
			¿Requiere Experiencia?</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_experiencia" attribute="do_nfop_icua_experiencia" object="obj"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold;" nowrap>
			</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_experiencia_ex" attribute="do_nfop_icua_experiencia_ex" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold" nowrap>			
			¿Vacantes sin Cubrir?</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_vacantes" attribute="do_nfop_icua_vacantes" object="obj"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold" nowrap>			
			Las Vacantes se cubren</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_vacantes_dif" attribute="do_nfop_icua_vacantes_dif" object="obj" size="12"></dmfx:docbaseattributevalue></td></tr>
			
			<tr><td align="right" style="font-weight:bold" nowrap>
			Días promedio en cubrir vacantes</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_vacantes_dias" attribute="do_nfop_icua_vacantes_dias" object="obj" size="4"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold" nowrap>			
			Otras ocupaciones</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_ocupaciones" attribute="do_nfop_icua_ocupaciones" object="obj"></dmfx:docbaseattributevalue></td></tr>
			
			<tr><td align="right" style="font-weight:bold" nowrap>
			Formación para su adaptación</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_formacion" attribute="do_nfop_icua_formacion" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
			
			<tr><td align="right" style="font-weight:bold" nowrap>
			Movilidad</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_movilidad" attribute="do_nfop_icua_movilidad" object="obj"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold;" nowrap>
			</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_movilidad_ex" attribute="do_nfop_icua_movilidad_ex" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold" nowrap>
			Emprendimiento</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_emprend" attribute="do_nfop_icua_emprend" object="obj"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold;" nowrap>
			</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_emprend_ex" attribute="do_nfop_icua_emprend_ex" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>

			<tr><td align="right" style="font-weight:bold;" nowrap>
			Recomendaciones</td><td><dmfx:docbaseattributevalue name="do_nfop_icua_recom" attribute="do_nfop_icua_recom" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
		</table>
		<!-- certificados de profesionalidad-->
		<br>
		<div align="center">
			<span style="font-weight:bold" align="center">CERTIFICADOS DE PROFESIONALIDAD - </span>
			<dmf:link name="certificados" label="Editar" onclick="launchEditarCertificados"></dmf:link>
		</div> 
		<br>
		<table border="1" align="center">
				<tr><th align="center">Certificado</th><th align="center">Nº Parados</th></tr>
			<% for (int i=0;i<titulos.length;i++){ %>
				<!--  desactivamos temporalmente las urls <a href="#" target="blank" >titulos[i]</a>-->
				<tr><td align="right"><%=titulos[i] %></td><td align="right"><%= parados[i]%></td></tr>
			<%} %>
		</table>
	</dmf:form>
</dmf:body>
</dmf:html>
