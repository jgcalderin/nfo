
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
<%@ page import="com.documentum.web.form.Form" %>

<%
	//
	MyAttributes myatts = (MyAttributes)pageContext.getAttribute(IParams.FORM, PageContext.REQUEST_SCOPE);
	DocbaseObject dobj = (DocbaseObject)myatts.getControl("obj",DocbaseObject.class);
%>
<dmf:html>
<dmf:head>
	<dmf:webform />
	<script>
		//El siguiente script esta incluido en custom/include/invesdoc.js (como todos los demas) pero por algun extranyo motivo no se carga. Por eso se incluye a continuacion:
		function onClickViewDocument(src,objectId)
		{
			var url = '<%=Form.makeUrl(request,"/servlet/DownloadServlet?docId=")%>';
			window.open(url + objectId);
		}
	</script>
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
		<dmf:panel name="paneldocs">
			<br>
			<table width="100%">
				<tr><td><dmf:link name="lnkadddoc" id="lnkadddoc" onclick="onAddFile" label="Agregar Documentos"/></td></tr>
				<tr><td>
				<dmf:datagrid name="dgrDocsList">
					<dmf:datagridTh><span>Nombre</span></dmf:datagridTh>
					<dmf:datagridTh><span>Tama&ntilde;o</span></dmf:datagridTh>
					<dmf:datagridTh><span>Formato</span></dmf:datagridTh>
					<dmf:datagridTh><span>Acci&oacute;n</span></dmf:datagridTh>
					<dmf:datagridRow>
						<td>
							<dmf:link name="linkview" datafield="object_name" onclick="onClickViewDocument" runatclient="true">
								<dmf:argument name="objectId" datafield="r_object_id"/>
							</dmf:link>
						</td>
						<td align="center">
							<dmf:label datafield="r_content_size"/>
						</td>
						<td align="center">
							<dmf:label datafield="formato"/>
						</td>
						<td align="center">
							<dmf:link name="linkdelete" id="linkdelete" label="borrar" onclick="onClickDeleteFile">
								<dmf:argument name="objectId" datafield="r_object_id"/>
								<dmf:argument name="objectname" datafield="object_name"/>
							</dmf:link>
						</td>
					</dmf:datagridRow>
					<dmf:nodataRow>
						<td>No hay documentos</td>
					</dmf:nodataRow>
				</dmf:datagrid>
				</td></tr>
			</table>
		</dmf:panel>
	</dmf:form>
</dmf:body>
</dmf:html>
