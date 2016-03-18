
<%
	//
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page errorPage="/wdk/errorhandler.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf"%>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx"%>
<dmf:html>
<dmf:head>
	<dmf:webform />
</dmf:head>
<dmf:body cssclass='contentBackground'>
	<dmf:form>
		<dmfx:docbaseobject name="obj" configid="attributes" />
		<p>
			Pulse en 'Editar' para modificar la lista de capacidades y sus respectivos niveles:
			<br>
		</p> 
		<div class="attributeList">
			<table>
				<tr>
					<td style="font-weight:bold">Competencia</td>
					<td><dmfx:docbaseattributevalue name="do_nfop_ctra_ofiti" attribute="do_nfop_ctra_ofiti" object="obj" size="40"></dmfx:docbaseattributevalue></td>
				</tr>
			</table>
			<table>
				<tr>
					<td style="font-weight:bold">Nivel</td>
					<td><dmfx:docbaseattributevalue name="do_nfop_ctra_ofiti_c" attribute="do_nfop_ctra_ofiti_c" object="obj" size="40"></dmfx:docbaseattributevalue></td>
				</tr>
			</table>
		</div>
	</dmf:form>
</dmf:body>
</dmf:html>
