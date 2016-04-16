<%
//
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx" %>
<%@ page import="com.documentum.webcomponent.environment.preferences.display.ColumnSelector,
com.documentum.web.form.Form,
com.documentum.web.form.control.ListBox" %>
<html>
<head>
<dmf:webform/>
<script type="text/javascript">
registerClientEventHandler(null, "onSetErrorFocus", setErrorFocus);
function setErrorFocus(msg)
{
alert(msg);
}
</script>
</head>
<body class='contentBackground' onload="document.getElementsByName('body_attributeselectorControl_lstItems_0')[0].multiple='true';">
<dmf:form autofocusneeded='true'>
<table  cellspacing=2 cellpadding=2 border=0>
<tr>
<td>
<dmfx:attributeselector name="<%=ColumnSelector.ATTRIBUTESELECTOR%>" size="10" itemsnlsid="MSG_SELECT_ATTRIBUTES"
selecteditemsnlsid="MSG_SELECTED_ATTRIBUTES" docbasetypesnlsid="MSG_TYPE_DROPDOWN"
buttonimagefolder="images/button" buttoncssclass="buttonLink" labelcssclass="shortfieldlabel" />
</td>
</tr>
<dmf:panel name="pnlReset">
<tr>
<td>
<dmf:button name="btnReset" nlsid="MSG_RESET" onclick="onClickReset" cssclass='buttonLink'
height='16' tooltipnlsid="MSG_RESET_TIP"/>
</td>
</tr>
</dmf:panel>
<dmf:panel name="pnlEmptyWarning">
<tr>
<td>
<dmf:label name="lblEmptyWarning" nlsid="MSG_EMPTYWARNING" cssclass='validatorMessageStyle'/>
</td>
</tr>
</dmf:panel>
</table>
</dmf:form>
</body>
</html>
