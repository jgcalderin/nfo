
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
<%@ page import="com.documentum.fc.common.DfException" %>
<%@ page import="com.documentum.fc.common.DfLogger" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.math.RoundingMode" %>

<%
	//
	MyAttributes myatts = (MyAttributes)pageContext.getAttribute(IParams.FORM, PageContext.REQUEST_SCOPE);
	DocbaseObject dobj = (DocbaseObject)myatts.getControl("obj",DocbaseObject.class);
	
	String titulaciones[] = myatts.getRepeatingValue("do_nfop_aer_titulaciones","#");
	String porcentajes[] = myatts.getRepeatingValue("do_nfop_aer_perc_contrat","#");
	porcentajes = myatts.paddArray(porcentajes,titulaciones.length,"?");
	double mayorpercContratacion = 0;
	String smayorpercContratacion = "";
	try
	{
		if (porcentajes != null)
		{
			for (int i=0;i<porcentajes.length;i++)
			{
				double d = (new Double(porcentajes[i])).doubleValue();
				mayorpercContratacion = mayorpercContratacion + d;
			}
		}
	}
	catch (java.lang.NumberFormatException e)
	{
		//La suma no se realiza correctamente. Avisamos:
		DfLogger.error(this, "error al calcular mayorpercContratacion: " + e.getMessage(), null, null);
	}
	
	DecimalFormat df = new DecimalFormat("#.##");
	df.setRoundingMode(RoundingMode.CEILING);
	smayorpercContratacion = df.format(mayorpercContratacion);
	
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
			Total Contratos en</td><td><dmfx:docbaseattributevalue name="do_nfop_aer_y_contratos" attribute="do_nfop_aer_y_contratos" object="obj" size="4"></dmfx:docbaseattributevalue></td>
			<td>:</td>
			<td><dmfx:docbaseattributevalue name="do_nfop_aer_t_contratos" attribute="do_nfop_aer_t_contratos" object="obj" size="4"></dmfx:docbaseattributevalue></td>
			</tr>			
		</table>
		<br>
		<span style="font-weight:bold">Clases de A.E. con mayor contratación(*) - </span><dmf:link name="titulaciones" label="Editar" onclick="launchEditarTitulaciones"></dmf:link>
		<br>
		<br>
		<table border='1'>
			<% for (int i=0;i<titulaciones.length;i++)
			{ 
				if (i==0)
				{
					if (titulaciones[i] == null) break;
					if (titulaciones[i].length() == 0) break;
				}
				%>
				<tr>
					<td><%=titulaciones[i] %></td>
					<td align="center"><%=porcentajes[i] %></td>
					<td align="center">%</td>
				</tr>
			<%} %>
		</table>
		<br>
		<span style="font-weight:bold">(*) A.E. que concentran más del <%=smayorpercContratacion%> % de la contratación</span>
		<br>
		<br>
		<span style="font-weight:bold">La división de A.E. que mantiene la tendencia de mayor contratación de estos profesionales es:</span>
		<br>
		<dmfx:docbaseattributevalue name="do_nfop_aer_division" attribute="do_nfop_aer_division" object="obj" size="20"></dmfx:docbaseattributevalue>
	</dmf:form>
</dmf:body>
</dmf:html>
