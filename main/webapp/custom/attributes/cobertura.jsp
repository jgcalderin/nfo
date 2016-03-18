
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
		<hr>
		<span style="font-weight:bold">[PARA EL EMPLEO]</span>
		<br>
		<div>
			<table>
				<tr><td align="right" style="font-weight:bold">
				Cubierto?</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_cob_fp" attribute="do_nfop_ctp_cob_fp" object="obj" size="4"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold">
				Grado de Cobertura</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_cob_fp_grado" attribute="do_nfop_ctp_cob_fp_grado" object="obj" size="4"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold">
				Nuevas Acciones Formativas</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_cob_fp_grado_x" attribute="do_nfop_ctp_cob_fp_grado_x" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold">
				Razones del NO</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_cob_fp_raz_no" attribute="do_nfop_ctp_cob_fp_raz_no" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
			</table>
		</div>
		<hr>
		<span style="font-weight:bold">[REGLADA]</span>
		<br>
		<div>
			<table>
				<tr><td align="right" style="font-weight:bold">
				Titulaciones</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_cob_reg_tit" attribute="do_nfop_ctp_cob_reg_tit" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
				<tr><td align="right" style="font-weight:bold">
				Formación Complementaria</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_cob_reg_com" attribute="do_nfop_ctp_cob_reg_com" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
			</table>			
		</div>
	</dmf:form>
</dmf:body>
</dmf:html>
