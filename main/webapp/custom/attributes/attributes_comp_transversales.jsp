
<%@page import="com.documentum.web.env.PageContextWrapper"%>
<%
	//
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page errorPage="/wdk/errorhandler.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf"%>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx"%>
<%@ page import="com.documentum.web.formext.control.docbase.DocbaseObject" %>
<%@ page import="com.documentum.web.form.IParams" %>
<%@ page import="com.sepe.nfo.components.MyAttributes" %>
<%@ page import="com.documentum.fc.common.DfException" %>

<%
	//
	MyAttributes myatts = (MyAttributes)pageContext.getAttribute(IParams.FORM, PageContext.REQUEST_SCOPE);
	DocbaseObject dobj = (DocbaseObject)myatts.getControl("obj",DocbaseObject.class);
	
	String idiomas[] = myatts.getRepeatingValue("do_nfop_ctra_idioma");
	String competencias[] = myatts.getRepeatingValue("do_nfop_ctra_idioma_c");
	competencias = myatts.paddArray(competencias,idiomas.length,"-----");

	//este bloque es basura para lidiar con valores frontera, hay que mejorarlo.
	for (int i=0;i<competencias.length;i++)
	{
		competencias[i]= competencias[i]==null?"-":competencias[i].trim();
		competencias[i] = myatts.pad(competencias[i],5,"-");
	}

	String ofiti[] = myatts.getRepeatingValue("do_nfop_ctra_ofiti");
	String competenciasOfiTI[] = myatts.getRepeatingValue("do_nfop_ctra_ofiti_c");
	competenciasOfiTI = myatts.paddArray(competenciasOfiTI,ofiti.length,"-");
	
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
		<span style="font-weight:bold">Idiomas - </span><dmf:link name="idiomas" label="Editar" onclick="launchEditarIdiomas"></dmf:link>
		<table border='1'>
			<th></th>
			<th>Comprensión Auditiva</th>
			<th>Comprensión de Lectura</th>
			<th>Interacción Oral</th>
			<th>Expresión Oral</th>
			<th>Escritura</th>
			<% for (int i=0;i<idiomas.length;i++)
			{ 
				if (i==0)
				{
					if (idiomas[i] == null) break;
					if (idiomas[i].length() == 0) break;
				}
				%>
				<tr>
					<td><%=idiomas[i] %></td>
					<td align="center"><%=competencias[i].substring(0,1) %></td>
					<td align="center"><%=competencias[i].substring(1,2)  %></td>
					<td align="center"><%=competencias[i].substring(2,3)  %></td>
					<td align="center"><%=competencias[i].substring(3,4)  %></td>
					<td align="center"><%=competencias[i].substring(4)  %></td>
				</tr>
			<%} %>
		</table>
		<br>
		<span style="font-weight:bold">Ofimática y TI - </span><dmf:link name="ofiti" label="Editar" onclick="launchEditarOfiTI"></dmf:link>
		<table border='1'>
			<% for (int i=0;i<ofiti.length;i++)
			{ 
				if (i==0)
				{
					if (ofiti[i] == null) break;
					if (ofiti[i].length() == 0) break;
				}
				%>
				<tr>
					<td><%=ofiti[i] %></td>
					<td align="center"><%=competenciasOfiTI[i]%></td>
				</tr>
			<%} %>
		</table>
		<br>
		<table>
			<tr><td align="right" style="font-weight:bold" nowrap>
			Conocimientos Financieros</td><td><dmfx:docbaseattributevalue name="do_nfop_ctra_fin" attribute="do_nfop_ctra_fin" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>		
			<tr><td align="right" style="font-weight:bold" nowrap>
			Conocimientos Jurídicos</td><td><dmfx:docbaseattributevalue name="do_nfop_ctra_jur" attribute="do_nfop_ctra_jur" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>
			<tr><td align="right" style="font-weight:bold" nowrap>
			Conocimientos Funcionamiento AA.PP.</td><td><dmfx:docbaseattributevalue name="do_nfop_ctra_func_app" attribute="do_nfop_ctra_func_app" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>
			<tr><td align="right" style="font-weight:bold" nowrap>
			Cálculo y Comunicación Oral y Escrita</td><td><dmfx:docbaseattributevalue name="do_nfop_ctra_calc" attribute="do_nfop_ctra_calc" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>
			<tr><td align="right" style="font-weight:bold" nowrap>
			Conocimientos de Dirección</td><td><dmfx:docbaseattributevalue name="do_nfop_ctra_dir" attribute="do_nfop_ctra_dir" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>
			<tr><td align="right" style="font-weight:bold" nowrap>
			Resolución de Problemas</td><td><dmfx:docbaseattributevalue name="do_nfop_ctra_res" attribute="do_nfop_ctra_res" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>
			<tr><td align="right" style="font-weight:bold" nowrap>
			Trabajo en Equipo</td><td><dmfx:docbaseattributevalue name="do_nfop_ctra_t_equipo" attribute="do_nfop_ctra_t_equipo" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>
			<tr><td align="right" style="font-weight:bold" nowrap>
			Atención al Público</td><td><dmfx:docbaseattributevalue name="do_nfop_ctra_att_pub" attribute="do_nfop_ctra_att_pub" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>
			<tr><td align="right" style="font-weight:bold" nowrap>
			Personales/Actitud/Valores:</td><td><dmfx:docbaseattributevalue name="do_nfop_ctra_pers" attribute="do_nfop_ctra_pers" object="obj" size="40"></dmfx:docbaseattributevalue></td></tr>			
		</table>
	</dmf:form>
</dmf:body>
</dmf:html>
