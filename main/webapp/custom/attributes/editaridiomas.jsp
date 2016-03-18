
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
			Pulse en 'Editar' para modificar la lista de idiomas y sus respectivo nivel:
			<br>
		</p> 
		<div class="attributeList">
			<table>
				<tr>
					<td style="font-weight:bold">Idiomas</td>
					<td><dmfx:docbaseattributevalue name="do_nfop_ctra_idioma" attribute="do_nfop_ctra_idioma" object="obj"></dmfx:docbaseattributevalue></td>
				</tr>
			</table>
			<table>
				<tr>
					<td style="font-weight:bold">Nivel</td>
					<td><dmfx:docbaseattributevalue name="do_nfop_ctra_idioma_c" attribute="do_nfop_ctra_idioma_c" object="obj"></dmfx:docbaseattributevalue></td>
				</tr>
			</table>
		</div>
	</dmf:form>
</dmf:body>
</dmf:html>
