<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx" %>
<%@ page import="com.documentum.web.form.Form" %>
<dmf:html>
	<dmf:head>
		<dmf:webform/>
		<script>
			//El siguiente script esta incluido en custom/include/invesdoc.js (como todos los demas) pero por algun extranyo motivo no se carga. Por eso se incluye a continuacion:
			function onClickViewDocument(src,objectId)
			{
				var url = '<%=Form.makeUrl(request,"/servlet/DownloadServlet?docId=")%>';
				window.open(url + objectId);
			}
		</script>
	</dmf:head>
	<dmf:body>
		<dmf:form>
			<dmf:label name="lblmsg" id="lblmsg"/>
			<div>
				<!-- panel de nuevos documentos a importar -->
				<dmf:panel name="panel" visible="true">
					<table width="100%">
						<!--<dmf:fileselectorapplet name="fselectorapplet" fileselect="true" folderselect="false" multiselect="true" showbuttonpanel="true" width="800" height="200"></dmf:fileselectorapplet>-->
						<tr><td>
							<dmf:label name="lblseleccion" label="Seleccione fichero:"/><dmf:filebrowse name="fselect" fileupload="true" size="250"/>
						</td></tr>
						<tr><td>
							<dmf:label id="lblname" label="Guardar con este nombre:"/>
							<dmf:text name="txtname"/>&nbsp;&nbsp;&nbsp;
						</td></tr>
						<tr><td>
							<dmf:label id="lblname" label="Marcar si es Ficha OMSMT:"/>
							<dmf:checkbox name="chkmejorsituacion"/>
							<dmf:button name="btnupload" label="Agregar Documentos" onclick="onUpLoadFile"/>
						</td></tr>
						<tr><td>
							<dmf:label name="lblmsg" id="lblmsg"/>
						</td></tr>
						<tr><td>
							<dmf:datagrid name="dgrNewDocsList">
								<dmf:datagridTh><span>Nombre</span></dmf:datagridTh>
								<dmf:datagridTh><span>Tama&ntilde;o</span></dmf:datagridTh>
								<dmf:datagridTh><span>Formato</span></dmf:datagridTh>
								<dmf:datagridRow>
									<td>
										<dmf:link name="linkview" datafield="object_name" onclick="onClickViewDocument" runatclient="true">
											<dmf:argument name="objectId" datafield="r_object_id"/>
										</dmf:link>
										<dmf:label name="lblname" datafield="object_name" visible="false"/>
									</td>
									<td align="center">
										<dmf:label name="lblsize" datafield="r_content_size"/>
									</td>
									<td align="center">
										<dmf:label name="lblformato" datafield="formato"/>
									</td>
								</dmf:datagridRow>
								<dmf:nodataRow>
									<td>No hay documentos</td>
								</dmf:nodataRow>
							</dmf:datagrid>
						</td></tr>
					</table>
				</dmf:panel>
			</div>
		</dmf:form>
	</dmf:body>
</dmf:html>