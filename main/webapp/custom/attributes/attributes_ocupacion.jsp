
<%@page import="com.documentum.web.env.PageContextWrapper"%>
<%
	//
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page errorPage="/wdk/errorhandler.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf"%>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx"%>
<%@ page import="com.documentum.web.env.PageContextWrapper" %>
<%
	//
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
		<div id="divtab1">
			<br>
			<table>
				<tr><td align="right" style="font-weight:bold" nowrap>
				Código Ocupación</td><td><dmfx:docbaseattributevalue name="do_nfop_cno" attribute="do_nfop_cno" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold" nowrap>
				Año del Informe</td><td><dmfx:docbaseattributevalue name="do_nfop_year" attribute="do_nfop_year" object="obj" size="4"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold">
				¿Información completa de la ocupación?</td><td><dmfx:docbaseattributevalue name="do_nfop_completo" attribute="do_nfop_completo" object="obj" size="4"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold" nowrap>
				Provincia</td><td><dmfx:docbaseattributevalue name="do_nfop_provincia" attribute="do_nfop_provincia" object="obj" size="20"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold" nowrap>
				Agrupación Profesional</td><td><dmfx:docbaseattributevalue name="do_nfop_agrupacion" attribute="do_nfop_agrupacion" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold" nowrap>
				Necesidades Formativas</td><td><dmfx:docbaseattributevalue name="do_nfop_necesidades" attribute="do_nfop_necesidades" object="obj" size="100" lines="5"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold" nowrap>
				Diferencias</td><td><dmf:link name="diferencias" label="(ampliar)" onclick="launchMyDiferencias"></dmf:link></td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td align="right" style="font-weight:bold" nowrap>
				Cobertura de F.P.</td><td><dmf:link name="cobertura" label="(ampliar)" onclick="launchMyCobertura"></dmf:link></td></tr>
			</table>								
		</div>
		<div id="divtab2"></div>
		<div id="divtab3"></div>
	</dmf:form>
</dmf:body>
</dmf:html>
