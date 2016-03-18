<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page errorPage="/wdk/errorhandler.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf"%>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx"%>
<%@ page import="com.documentum.web.formext.control.docbase.DocbaseObject" %>
<%@ page import="com.documentum.web.form.IParams" %>
<%@ page import="com.sepe.nfo.components.MyAttributes" %>
<%	

%>
<dmf:html>
<dmf:head>
	<dmf:webform />
</dmf:head>
<dmf:body cssclass='contentBackground'>
	<dmf:form>
		<dmfx:docbaseobject name="obj" configid="attributes" />
		<div class="attributeList">
			<table>
				<tr>
					<td style="font-weight:bold">Seleccione certificados</td>
					<td><dmfx:docbaseattributevalue name="do_nfop_icua_certificados" attribute="do_nfop_icua_certificados" object="obj"></dmfx:docbaseattributevalue></td>
				</tr>
			</table>
			<table>
				<tr>
					<td style="font-weight:bold">Indique nº de parados de cada certificado</td>
					<td><dmfx:docbaseattributevalue name="do_nfop_icua_parados_cert" attribute="do_nfop_icua_parados_cert" object="obj"></dmfx:docbaseattributevalue></td>
				</tr>
			</table>
		</div>
	</dmf:form>
</dmf:body>
</dmf:html>
