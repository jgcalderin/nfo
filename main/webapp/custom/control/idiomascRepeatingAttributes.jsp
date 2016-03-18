
<%@page import="com.documentum.web.formext.control.docbase.DocbaseObject"%>
<%
	//
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page errorPage="/wdk/errorhandler.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf"%>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx"%>
<%@ page import="com.documentum.web.form.IParams"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.documentum.web.form.Form"%>
<%@ page import="com.documentum.web.formext.control.docbase.DocbaseRepeatingAttribute"%>
<%@ page import="com.documentum.web.test.recorder.TestStepRecorder"%>
<%@ page import="com.sepe.nfo.controls.CapacidadesIdiomasDocbaseRepeatingAttribute" %>
<%@ page import="java.util.List"%>

<dmf:html>
	<head>
		<dmf:webform />
		<dmf:title>
			<dmf:label nlsid='MSG_REPEATING_ATTRIBUTE_TITLE' />
		</dmf:title>
	</head>
	<dmf:body id="modal" cssclass='defaultPanesetBackground'
	marginheight='0' marginwidth='12' topmargin='0' bottommargin='0'
	leftmargin='12' rightmargin='0' showdialogevent='true' width='590'
	height='313' titlenlsid='MSG_REPEATING_ATTRIBUTE_TITLE'>
		<dmf:form autofocusneeded="true">
			<%
				Form form = (Form) pageContext.getAttribute(IParams.FORM, PageContext.REQUEST_SCOPE);
				CapacidadesIdiomasDocbaseRepeatingAttribute docbaseRepeatingAttribute = (CapacidadesIdiomasDocbaseRepeatingAttribute) form;
				//
			%>
			<script src='<%=Form.makeUrl(request, "/wdk/include/modal.js")%>' language='JavaScript1.2'></script>
			<script src='<%=Form.makeUrl(request,"/wdk/control/repeatingAttributes.js")%>' language='JavaScript1.2'></script>
			<script>
				repeatingAttributesFormId = "<%=form.getElementName()%>";
				booleanTrueDisplayValue = "<%=docbaseRepeatingAttribute.getBooleanTrueDisplay()%>";
				booleanFalseDisplayValue = "<%=docbaseRepeatingAttribute.getBooleanFalseDislay()%>";
				<%if (TestStepRecorder.isRecording()) {%>
					isTestRecording = "true";
				<%}%>
			</script>
			<dmf:paneset name="mainPaneset" rows="42,*,45"
			cssclass='defaultPanesetBackground' toppadding="0" bottompadding="0"
			leftpadding="130" rightpadding="130" minheight="300" minwidth="400">
			<dmf:pane name="headerareaPane" overflow="hidden">
				<dmfx:fragment src='modal/modalContainerStart.jsp' />
				<h5 style="display: inline;">
					<dmf:label name="attrLabel" cssclass='dialogTitle' />
				</h5>
				<dmfx:fragment src='modal/modalNavbarStart.jsp' />&nbsp;
				<dmfx:fragment src='modal/modalNavbarEnd.jsp' />
			</dmf:pane>
			<dmf:paneset name="contentareaPaneset" cols="18,*,18"
				cssclass="contentBackground">
				<dmf:pane name="leftcolumn" overflow="hidden">
					<dmfx:fragment src='modal/modalEdgesStart.jsp' />
				</dmf:pane>
				<dmf:pane name="scrollingcontent" overflow="auto">
					<dmfx:fragment src='modal/modalContentGutterStart.jsp' />
					<p>
						Especifique las competencias escribiendo una secuencia de 5 letras de entre las 3 siguientes:
						<br>
						<li>A: Usuario básico</li>
						<li>B: Usuario independiente</li>
						<li>C: Usuario competente</li>
						<br>
					</p> 
					<table border=0 cellPadding=1 cellSpacing=1>
						<tr>
							<td colspan=1>&nbsp;</td>
							<td>
								<table border="1">
									<th>-</th>
									<th>Comprensión Auditiva</th>
									<th>Comprensión de Lectura</th>
									<th>Interación Oral</th>
									<th>Expresión Oral</th>
									<th>Escritura</th>
									<%
										List<String> idiomas = docbaseRepeatingAttribute.getIdiomasAttributeValue();
										int i=0;
										for (String idioma:idiomas)
										{
											%>
											<tr>
												<td><%=idioma %></td>
												<td align=center><dmf:text name='<%=i + "c0" %>' size="2" maxlength="1"/></td>
												<td align=center><dmf:text name='<%=i + "c1" %>' size="2" maxlength="1"/></td>
												<td align=center><dmf:text name='<%=i + "c2" %>' size="2" maxlength="1"/></td>
												<td align=center><dmf:text name='<%=i + "c3"%>' size="2" maxlength="1"/></td>
												<td align=center><dmf:text name='<%=i + "c4"%>' size="2" maxlength="1"/></td>
											</tr>
											<%i++;%>
										<%}%>
								</table>
							</td>
						</tr>
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr>
							<td colspan="2"><dmf:label name="lblmsg" style="color:red"/></td>
						</tr>
					</table>
					<dmfx:fragment src='modal/modalContentGutterEnd.jsp' />
				</dmf:pane>
				<dmf:pane name="rightcolumn" overflow="hidden">
					<dmfx:fragment src='modal/modalEdgesEnd.jsp' />
				</dmf:pane>
			</dmf:paneset>
			<dmf:pane name="buttonareaPane" overflow="hidden">
				<dmfx:fragment src='modal/modalButtonbarStart.jsp' />
				<dmf:button name='ok' cssclass="buttonLink" nlsid='MSG_OK'
					onclick='onClickOK' height='16' tooltipnlsid="MSG_OK_TIP" />
				<dmf:button name='cancel' cssclass='buttonLink' nlsid='MSG_CANCEL'
					onclick='onClickCancel' height='16' tooltipnlsid="MSG_CANCEL_TIP" />
				<dmfx:fragment src='modal/modalButtonbarEnd.jsp' />
				<dmfx:fragment src='modal/modalContainerEnd.jsp' />
			</dmf:pane>
		</dmf:paneset>
		<dmf:hidden name="hiddenText" id="hiddenText" />
		<dmf:hidden name="hiddenControl" id="hiddenControl" />
		<dmf:hidden name="hiddenVaControl" id="hiddenVaControl" />
		<script>
			setTimeout('initListbox()', 10);
		</script>
	</dmf:form>
</dmf:body>
</dmf:html>
