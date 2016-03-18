<%
//
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx" %>
<%@ page import="com.documentum.web.form.IParams" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.documentum.web.form.Form" %>
<%@ page import="com.documentum.web.formext.control.docbase.DocbaseRepeatingAttribute" %>
<%@ page import="com.documentum.web.test.recorder.TestStepRecorder" %>
<dmf:html>
<head>
<dmf:webform/>
<dmf:title>
<dmf:label nlsid='MSG_REPEATING_ATTRIBUTE_TITLE'/>
</dmf:title>
</head>
<dmf:body id="modal" cssclass='defaultPanesetBackground' marginheight='0' marginwidth='12'
topmargin='0' bottommargin='0' leftmargin='12' rightmargin='0'
showdialogevent='true' width='590' height='313' titlenlsid='MSG_REPEATING_ATTRIBUTE_TITLE'>
<dmf:form autofocusneeded="true">
<%
Form form = (Form) pageContext.getAttribute(IParams.FORM, PageContext.REQUEST_SCOPE);
DocbaseRepeatingAttribute docbaseRepeatingAttribute = (DocbaseRepeatingAttribute) form;
//
%>
<script src='<%=Form.makeUrl(request, "/wdk/include/modal.js")%>' language='JavaScript1.2'></script>
<script src='<%=Form.makeUrl(request, "/wdk/control/repeatingAttributes.js")%>' language='JavaScript1.2'></script>
<script>
repeatingAttributesFormId = "<%=form.getElementName()%>";
booleanTrueDisplayValue = "<%=docbaseRepeatingAttribute.getBooleanTrueDisplay()%>";
booleanFalseDisplayValue = "<%=docbaseRepeatingAttribute.getBooleanFalseDislay()%>";
<%
if (TestStepRecorder.isRecording())
{
%>
isTestRecording = "true";
<%
}
%>
</script>
<dmf:paneset name="mainPaneset" rows="42,*,45" cssclass='defaultPanesetBackground'
toppadding="0" bottompadding="0"
leftpadding="130" rightpadding="130"
minheight="300" minwidth="400">
<dmf:pane name="headerareaPane" overflow="hidden">
<dmfx:fragment src='modal/modalContainerStart.jsp'/>
<dmf:label name="attrLabel" cssclass='dialogTitle'/>
<dmfx:fragment src='modal/modalNavbarStart.jsp'/>
&nbsp;
<dmfx:fragment src='modal/modalNavbarEnd.jsp'/>
</dmf:pane>
<dmf:paneset name="contentareaPaneset" cols="18,*,18" cssclass="contentBackground">
<dmf:pane name="leftcolumn" overflow="hidden">
<dmfx:fragment src='modal/modalEdgesStart.jsp'/>
</dmf:pane>
<dmf:pane name="scrollingcontent" overflow="auto">
<dmfx:fragment src='modal/modalContentGutterStart.jsp'/>
<table border=0 cellPadding=1 cellSpacing=1>
<tr>
<td width="15%">&nbsp;</td>
<td colspan='2'>
<dmf:label name="attrError" cssclass='validatorMessageStyle'/>
</td>
</tr>
<tr>
<td width="15%">&nbsp;</td>
<td colspan='2' class="listlabel leftAlignment">
<dmf:label name="selectLabel"/>
</td>
</tr>
<tr>
<td width="15%">&nbsp;</td>
<td valign=top>
<dmf:panel name="valueAssistancePanel">
<!-- customizacion: se aumenta el widh a 450 -->
<dmf:listbox name='va' id="va" size='5' tooltipnlsid="MSG_SELECT_FROM_LIST" width="450">
<%
Iterator vaIt = docbaseRepeatingAttribute.vaRecords();
while (vaIt.hasNext() == true)
{
String strVaValue = (String) vaIt.next();
%>
<dmf:option value="<%= strVaValue %>" label="<%= strVaValue %>"/>
<%
}
%>
</dmf:listbox>
</dmf:panel>
<dmf:panel name="noVAdatetimePanel">
<div style="width: 210px; padding: 0px; margin: 0px ">
<dmf:datetime id="noVAdateTimeAddEntry" name="noVAdateTimeAddEntry" width="400" tooltipnlsid="MSG_ENTER_VALUE"/>
</div>
</dmf:panel>
<dmf:panel name="noVAbooleanPanel">
<dmf:checkbox name="noVAbooleanAddEntry" id="noVAbooleanAddEntry" tooltipnlsid="MSG_ENTER_VALUE"/>
</dmf:panel>
<dmf:panel name="noVAdefaultPanel">
<dmf:text name="noVAaddEntry" id="noVAaddEntry" defaultonenter='true' tooltipnlsid="MSG_ENTER_VALUE"
autocompleteid="ac_noVAaddEntry"/>
</dmf:panel>
</td>
<td align=left valign=bottom>
<dmf:button id="addbutton" name="addbutton" tooltipnlsid='MSG_ADD_BUTTON_MOUSEOVER_INFO' onclick='onClickAdd'
nlsid='MSG_ADD' cssclass='buttonLink, listBoxButton' default="true"/>
</td>
</tr>
<tr>
<td width="15%"></td>
<td colspan=2>
<dmf:panel name="openlistLabelPanel">
<dmf:label nlsid='MSG_OR_ENTER_VALUE' cssclass='listlabel'/>
</dmf:panel>
</td>
</tr>
<tr>
<td width="15%"></td>
<td valign=top>
<dmf:panel name="datetimePanel">
<dmf:datetime name="dateTimeAddEntry" width="400"/>
<dmf:datetimevalidator name="dateTimeAddEntryValidator" controltovalidate="dateTimeAddEntry"
nlsid="MSG_INVALID_DATE"/>
</dmf:panel>
<dmf:panel name="booleanPanel">
<dmf:checkbox name="booleanAddEntry" id="booleanAddEntry" tooltipnlsid='MSG_ENTER_VALUE'/>
</dmf:panel>
<dmf:panel name="defaultPanel">
<dmf:text name="addEntry" id="addEntry" defaultonenter='true' tooltipnlsid='MSG_ENTER_VALUE'
autocompleteid="ac_addEntry"/>
</dmf:panel>
</td>
<td align=left valign=bottom>
<dmf:panel name="textaddbuttonPanel">
<dmf:button id="textaddbutton" name="textaddbutton" tooltipnlsid='MSG_ADD_BUTTON_MOUSEOVER_INFO' onclick='onClickAdd'
nlsid='MSG_ADD' cssclass='buttonLink, listBoxButton' default="true"/>
</dmf:panel>
</td>
</tr>
<tr>
<td colspan='3'>&nbsp;</td>
</tr>
<tr>
<td width="15%">&nbsp;</td>
<td colspan='2' class="listlabel leftAlignment">
<dmf:label name="attrLabel2"/>:</td>
</tr>
<tr>
<td width="15%">&nbsp;</td>
<td>
<!-- customizacion: se aumenta el widh a 450 -->
<dmf:listbox name='attrvalue' id='attrvalue' size='7' width='450'>
</dmf:listbox>
</td>
<td valign=top>
<table border=0 cellPadding=2 cellSpacing=1 width="100%">
<tr>
<td align=left>
<dmf:button id="moveupbutton" name="moveupbutton" tooltipnlsid='MSG_MOVEUP_BUTTON_MOUSEOVER_INFO'
onclick='onClickMoveUp' runatclient="true" src="images/button/btn_up.gif"
cssclass='buttonLink, listBoxButton' />
</td>
</tr>
<tr>
<td align=left>
<dmf:button id="movedownbutton" name="movedownbutton" tooltipnlsid='MSG_MOVEDOWN_BUTTON_MOUSEOVER_INFO'
onclick='onClickMoveDown' runatclient="true" src="images/button/btn_down.gif"
cssclass='buttonLink, listBoxButton' />
</td>
</tr>
<tr>
<td align=left>
<dmf:button id="editbutton" name="editbutton" tooltipnlsid='MSG_EDIT_BUTTON_MOUSEOVER_INFO'
onclick='onClickEdit' runatclient="true" nlsid='MSG_EDIT'
cssclass='buttonLink, listBoxButton' />
</td>
</tr>
<tr>
<td align=left>
<dmf:button id="removebutton" name="removebutton" tooltipnlsid='MSG_REMOVE_BUTTON_MOUSEOVER_INFO'
onclick='onClickRemove' runatclient="true" nlsid='MSG_REMOVE'
cssclass='buttonLink, listBoxButton' />
</td>
</tr>
</table>
</td>
</tr>
</table>
<dmfx:fragment src='modal/modalContentGutterEnd.jsp'/>
</dmf:pane>
<dmf:pane name="rightcolumn" overflow="hidden">
<dmfx:fragment src='modal/modalEdgesEnd.jsp'/>
</dmf:pane>
</dmf:paneset>
<dmf:pane name="buttonareaPane" overflow="hidden">
<dmfx:fragment src='modal/modalButtonbarStart.jsp'/>
<dmf:button name='ok' cssclass="buttonLink" nlsid='MSG_OK' onclick='onClickOK' height='16'
tooltipnlsid="MSG_OK_TIP"/>
<dmf:button name='cancel' cssclass='buttonLink' nlsid='MSG_CANCEL' onclick='onClickCancel'
height='16' tooltipnlsid="MSG_CANCEL_TIP"/>
<dmfx:fragment src='modal/modalButtonbarEnd.jsp'/>
<dmfx:fragment src='modal/modalContainerEnd.jsp'/>
</dmf:pane>
</dmf:paneset>
<dmf:hidden name="hiddenText" id="hiddenText"/>
<dmf:hidden name="hiddenControl" id="hiddenControl"/>
<dmf:hidden name="hiddenVaControl" id="hiddenVaControl"/>
<script>setTimeout('initListbox()', 10);</script>
</dmf:form>
</dmf:body>
</dmf:html>
