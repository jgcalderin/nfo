
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
		<div class="attributeList">
			<div>
				<table>
					<tr><td align="right" style="font-weight:bold" nowrap>
					(seleccione AA.EE.)--></td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_d_ae" attribute="do_nfop_ctp_d_ae" object="obj"></dmfx:docbaseattributevalue></td></tr>
					<tr><td align="right" style="font-weight:bold" nowrap>
					Por A.E.</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_d_ae_ex" attribute="do_nfop_ctp_d_ae_ex" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
					<hr/>
					<tr><td>&nbsp;</td></tr>
					<tr><td align="right" style="font-weight:bold" nowrap>
					(seleccione provincias)--></td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_d_territ" attribute="do_nfop_ctp_d_territ" object="obj"></dmfx:docbaseattributevalue></td></tr>
					<tr><td align="right" style="font-weight:bold" nowrap>
					Por Territorio</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_d_territ_ex" attribute="do_nfop_ctp_d_territ_ex" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
				</table>
			</div>
			<hr>
			<div>
				<table>
					<tr><td align="right" style="font-weight:bold" nowrap>
					(seleccione ocupación)--></td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_d_ocup" attribute="do_nfop_ctp_d_ocup" object="obj"></dmfx:docbaseattributevalue></td></tr>
					<tr><td align="right" style="font-weight:bold" nowrap>
					Por Ocupación</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_d_ocup_ex" attribute="do_nfop_ctp_d_ocup_ex" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
					<tr><td>&nbsp;</td></tr>
					<tr><td align="right" style="font-weight:bold" nowrap>
					(seleccione tamaño)--></td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_d_tam_empr" attribute="do_nfop_ctp_d_tam_empr" object="obj"></dmfx:docbaseattributevalue></td></tr>
					<tr><td align="right" style="font-weight:bold" nowrap>
					Por Tamaño Empresa</td><td><dmfx:docbaseattributevalue name="do_nfop_ctp_d_tam_emp_ex" attribute="do_nfop_ctp_d_tam_emp_ex" object="obj" size="80" lines="5"></dmfx:docbaseattributevalue></td></tr>
				</table>
				<br>
				<p style="margin-left:150px">
					[Microempresa]: hasta 10 trabajadores<br>
					[Pequeña]: 10 - 50 trabajadores<br>
					[Mediana]: 50 - 250 trabajadores<br>
					[Grande]: +250 trabajadores<br>
				</p>
			</div>
		</div>
	</dmf:form>
</dmf:body>
</dmf:html>
