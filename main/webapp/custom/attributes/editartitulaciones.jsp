
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
			Pulse en 'Editar' para modificar la lista de clases de A.E. y sus porcentajes de contratación respectivos.
			<br>
		</p> 
		<div class="attributeList">
			<table>
				<tr>
					<td style="font-weight:bold">Clases de A.E. con mayor contratación</td>
					<td><dmfx:docbaseattributevalue name="do_nfop_aer_titulaciones" attribute="do_nfop_aer_titulaciones" object="obj"></dmfx:docbaseattributevalue></td>
				</tr>
			</table>
			<table>
				<tr>
					<td style="font-weight:bold">% de Contratación</td>
					<td><dmfx:docbaseattributevalue name="do_nfop_aer_perc_contrat" attribute="do_nfop_aer_perc_contrat" object="obj"></dmfx:docbaseattributevalue></td>
				</tr>
			</table>
		</div>
	</dmf:form>
</dmf:body>
</dmf:html>
