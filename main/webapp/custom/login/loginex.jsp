<%--
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ page import="com.documentum.web.formext.session.Login" %>
<%@ page import="com.documentum.web.form.Form" %>
<%@ page import="com.documentum.web.common.AccessibilityService"%>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx" %>
<dmf:html>
<dmf:head>
<dmf:webcontainerrequirements/>
<dmf:webform/>
<dmf:title><dmf:label nlsid="MSG_TITLE"/></dmf:title>
<script type="text/javascript" src='<%=Form.makeUrl(request, "/wdk/include/browserRequirements.js")%>'></script>
<script type="text/javascript">
function burstFrame ()
{
if (top != self)
{
top.location.href = self.location.href;
}
}
burstFrame();
</script>
<script type="text/javascript">
function onClickHelp()
{
fireClientEvent("InvokeHelp");
}
function clientSideTestHook()
{
}
function onSelectDocbaseFromDropDown()
{
var docbaseDropDownList = wdk.dom.get("DocbaseName");
var prefs = InlineRequestEngine.getPreferences(InlineRequestType.JSON);
prefs.setCallback("onSelectDocbaseFromDropDownCallBack");
prefs.setErrorCallback("onSelectDocbaseFromDropDownErrorCallBack");
if (window.suspendTestEvents)
{
window.suspendTestEvents();
}
postInlineServerEvent(null, prefs, docbaseDropDownList.name, null, "onSelectDocbaseFromDropDown",null, null);
}
function onSelectDocbaseFromDropDownCallBack (data)
{
var bSaveCredential = data['<%=Login.JSON_KEY_IS_SAVE_CREDENTIAL%>'];
updateSaveCredentialDisplay(bSaveCredential);
updateServerList(data);
releaseEventPostingLock();
if (window.resumeTestEvents)
{
window.resumeTestEvents();
}
}
function onSelectDocbaseFromDropDownErrorCallBack (data)
{
releaseEventPostingLock();
}
function onShowOptions()
{
var prefs = InlineRequestEngine.getPreferences(InlineRequestType.JSON);
prefs.setCallback("onShowOptionsCallBack");
prefs.setErrorCallback("onShowOptionsErrorCallBack");
if (window.suspendTestEvents)
{
window.suspendTestEvents();
}
postInlineServerEvent(null, prefs, null, null, "onShowOptions", null, null);
}
function onShowOptionsCallBack (data)
{
updateShowOptionsDisplay (data);
releaseEventPostingLock();
if (window.resumeTestEvents)
{
window.resumeTestEvents();
}
}
function onShowOptionsErrorCallBack (data)
{
releaseEventPostingLock();
}
function updateSaveCredentialDisplay (bSaveCredentialEnabled)
{
showOrHidePanel('<%=Login.CONTROL_CREDENTIAL_PANEL%>', bSaveCredentialEnabled);
}
function updateServerList (data)
{
var serverListElem = wdk.dom.get('<%=Login.CONTROL_SERVER%>');
if (serverListElem != null)
{
var serverNames = data['<%=Login.JSON_KEY_SERVER_NAMES%>'];
var serverLabels = data['<%=Login.JSON_KEY_SERVER_LABELS%>'];
serverListElem.options.length=1;
for (var i in serverNames)
{
var option = document.createElement('option');
option.value = serverNames[i];
option.text = serverLabels[i];
serverListElem.options[serverListElem.options.length]=option;
}
}
}
function updateShowOptionsDisplay (data)
{
var bShowOptions = data['<%=Login.JSON_KEY_IS_SHOW_OPTIONS%>'];
var strShowOptionsLabel = data['<%=Login.JSON_KEY_SHOW_OPTIONS_LABEL%>'];
var strShowOptionsToolTip = data['<%=Login.JSON_KEY_SHOW_OPTIONS_TOOLTIP%>'];
var showHideElem = wdk.dom.get('<%=Login.CONTROL_SHOWOPTIONS%>');
showHideElem.innerHTML = strShowOptionsLabel;
showHideElem.setAttribute('title', strShowOptionsToolTip);
showOrHidePanel('<%=Login.CONTROL_OPTIONSPANEL%>', bShowOptions);
showOrHidePanel('<%=Login.CONTROL_CHANGEPASSWORD_PANEL%>', bShowOptions);
var errMsgElem = wdk.dom.get('<%=Login.CONTROL_ERRMSG%>');
if (errMsgElem != null)
{
var errMsgParentElem = wdk.dom.findAncestorWithTagName(errMsgElem, "div");
errMsgParentElem.style.display = "none";
}
}  // end of "updateShowOptionsDisplay()"
function showOrHidePanel(panelName, bIsDisplay)
{
wdk.control.Panel.setVisible(panelName, bIsDisplay);
}
</script>
</dmf:head>
<dmf:body id="modalSmall">
<dmf:form keepfresh="true">
<dmf:browserrequirements/>
<div id="mainPaneset" style="padding:20px">
<div><dmf:label cssclass='dialogTitle' nlsid='MSG_TITLE'/></div>
<div id="scrollingcontent" style="overflow: auto;">
<div class="innerContent">
<h2 style="display:inline;">
	<div id="logo">
		<!-- CUSTOMIZACIÓN PARA CAMBIAR WEBTOP 6.7 POR EL NOMBRE DE NUESTRA APLICACION -->
		<!--<dmf:label nlsid="MSG_LOGO"/>&nbsp;-->
		<!--<dmf:label cssclass="dialogTitleVersion" nlsid="MSG_VERSION"/>-->
		<dmf:label cssclass="dialogTitleVersion" label="NECESIDADES DE FORMACIÓN DE OCUPACIONES"/>
	</div>
</h2>
<table align='center' cellspacing='0' cellpadding='0' border='0'>
<tr>
<td scope="row" class="fieldlabel rightAlignment" height="30" ><dmf:label nlsid='MSG_USERNAME'/></td>
<td class="defaultcolumnspacer">:&nbsp;</td>
<td><dmf:text id='LoginUsername' name='<%=Login.CONTROL_USERNAME%>' size='40' defaultonenter='true'
tooltipnlsid='MSG_USERNAME'/></td>
</tr>
<tr>
<td></td>
<td></td>
<td><dmf:requiredfieldvalidator name='<%=Login.CONTROL_USERNAME_VALIDATOR%>' controltovalidate='<%=Login.CONTROL_USERNAME%>' nlsid='<%=Login.MSG_USERNAME_REQUIRED%>' indicator=""/></td>
</tr>
<tr>
<td scope="row" class="fieldlabel rightAlignment" height="30" ><dmf:label nlsid='MSG_PASSWORD'/></td><td class="defaultcolumnspacer">:&nbsp;</td>
<td>
<% if (AccessibilityService.isAllAccessibilitiesEnabled())
{ %>
<dmf:password id='LoginPassword' name='<%=Login.CONTROL_PASSWORD%>' size='40' defaultonenter='true'/>
<% }
else
{ %>
<dmf:password id='LoginPassword' name='<%=Login.CONTROL_PASSWORD%>' size='40' defaultonenter='true' tooltipnlsid='MSG_PASSWORD'/>
<% } %>
</td>
</tr>
<tr>
<td></td>
<td></td>
<td><dmf:requiredfieldvalidator name='<%=Login.CONTROL_PASSWORD_VALIDATOR%>' controltovalidate='<%=Login.CONTROL_PASSWORD%>' nlsid='<%=Login.MSG_PASSWORD_REQUIRED%>' indicator=""/></td>
</tr>
<!-- CUSTOMIZACION PARA OCULTAR EL CONTROL DE LA DOCBASE. PONERMOS LA FILA A DISPLAY:NONE -->
<tr style="display:none">
	<td scope="row" class="fieldlabel rightAlignment" height="30" nowrap><dmf:label nlsid='MSG_DOCBASE'/></td>
	<td class="defaultcolumnspacer">:&nbsp;</td>
	<td>
		<dmf:datadropdownlist name='<%=Login.CONTROL_DOCBASE%>' id='DocbaseName' tooltipnlsid='MSG_DOCBASE' runatclient='true' onselect="onSelectDocbaseFromDropDown" enabled="false">
			<dmf:dataoptionlist>
				<dmf:option datafield="docbase" labeldatafield="docbase"/>
			</dmf:dataoptionlist>
		</dmf:datadropdownlist>
	</td>
</tr>
<dmf:panel name='<%=Login.CONTROL_NETWORK_LOCATION_PANEL%>' visible='false'>
<tr>
<td scope="row" class="fieldlabel rightAlignment" height="30" nowrap><dmf:label nlsid='MSG_NETWORK_LOCATION'/></td><td class="defaultcolumnspacer">:&nbsp;</td>
<td>
<dmf:datadropdownlist name='<%=Login.CONTROL_NETWORK_LOCATION_DROPDOWN%>' id='NetworkLocation' tooltipnlsid='MSG_NETWORK_LOCATION' runatclient='true' onselect='clientSideTestHook'>
<dmf:option nlsid='MSG_SELECT_NETWORK_LOCATION' value='<%=Login.CONTROL_NETWORK_LOCATION_DROPDOWN_SELECT%>' />
<dmf:dataoptionlist>
<dmf:option datafield="<%=Login.COLUMN_NETWORK_LOCATION_ID%>" labeldatafield="<%=Login.COLUMN_NETWORK_LOCATION_LABEL%>"/>
</dmf:dataoptionlist>
</dmf:datadropdownlist>
<dmf:label name='<%=Login.CONTROL_NETWORK_LOCATION_LABEL%>'/>
<dmf:hidden name='<%=Login.CONTROL_NETWORK_LOCATION_LABEL_HIDDEN%>'/>
</td>
</tr>
<tr>
<td></td>
<td></td>
<td>
<dmf:requiredfieldvalidator name="<%=Login.CONTROL_NETWORK_LOCATION_DROPDOWN_VALIDATOR%>" controltovalidate="<%=Login.CONTROL_NETWORK_LOCATION_DROPDOWN%>" nlsid="<%=Login.MSG_SELECT_NETWORK_LOCATION_REQUIRED%>" indicator="" />
</td>
</tr>
</dmf:panel>
<dmf:panel name='<%=Login.CONTROL_CREDENTIAL_PANEL%>' id='<%=Login.CONTROL_CREDENTIAL_PANEL%>' renderifinvisible='true'>
<tr class='<%=Login.CONTROL_CREDENTIAL_PANEL%>'>
<td height="5" colspan="3" class="spacer">&nbsp;</td>
</tr>
<tr class='<%=Login.CONTROL_CREDENTIAL_PANEL%>'>
<td scope="row" class="rightAlignment"></td><td></td>
<td>
<dmf:checkbox name='<%=Login.CONTROL_SAVE_CREDENTIAL%>' nlsid='MSG_SAVE_OPTION'/>
</td>
</tr>
</dmf:panel>
<tr>
<td class="spacer" height="30">&nbsp;</td>
<td></td><td></td>
</tr>
<tr>
<td class="fieldlabel leftAlignment" nowrap height="20" colspan="3"><dmf:link id='<%=Login.CONTROL_SHOWOPTIONS%>' name='<%=Login.CONTROL_SHOWOPTIONS%>' runatclient='true' onclick='onShowOptions'/></td>
</tr>
<dmf:panel name='<%=Login.CONTROL_OPTIONSPANEL%>' id='<%=Login.CONTROL_OPTIONSPANEL%>' renderifinvisible='true'>
<tr class='<%=Login.CONTROL_OPTIONSPANEL%>'>
<td class="spacer" height="30">&nbsp;</td>
<td></td><td></td>
</tr>
<tr class='<%=Login.CONTROL_OPTIONSPANEL%>'>
<td scope="row" class="fieldlabel rightAlignment" height="30" nowrap><dmf:label nlsid='MSG_DOMAIN'/></td><td class="defaultcolumnspacer">:&nbsp;</td>
<td><dmf:text name='<%=Login.CONTROL_DOMAIN%>' id='Domain' size='40' defaultonenter='true' tooltipnlsid='MSG_DOMAIN'/></td>
</tr>
<tr class='<%=Login.CONTROL_OPTIONSPANEL%>'>
<td scope="row" class="fieldlabel rightAlignment" height="30" nowrap><dmf:label nlsid='MSG_LANGUAGE'/></td><td class="defaultcolumnspacer">:&nbsp;</td>
<td>
<dmf:datadropdownlist id='<%=Login.CONTROL_LANGUAGE%>' name='<%=Login.CONTROL_LANGUAGE%>' onselect="onChangeLanguage" tooltipnlsid='MSG_LANGUAGE'>
<dmf:dataoptionlist>
<dmf:option datafield="locale" labeldatafield="language"/>
</dmf:dataoptionlist>
</dmf:datadropdownlist>
</td>
</tr>
<dmf:panel name='<%=Login.CONTROL_SERVER_PANEL%>' visible='false'>
<tr class='<%=Login.CONTROL_OPTIONSPANEL%>'>
<td scope="row" class="fieldlabel rightAlignment" height="30" nowrap><dmf:label nlsid='MSG_SERVER'/></td><td class="defaultcolumnspacer">:&nbsp;</td>
<td>
<dmf:datadropdownlist id='<%=Login.CONTROL_SERVER%>' name='<%=Login.CONTROL_SERVER%>' tooltipnlsid='MSG_SERVER'>
<dmf:option nlsid='MSG_ANY_RUNNING_SERVER' value='<%=Login.ANY_RUNNING_SERVER%>'/>
<dmf:dataoptionlist>
<dmf:option datafield="servername" labeldatafield="serverlabel"/>
</dmf:dataoptionlist>
</dmf:datadropdownlist>
</td>
</tr>
</dmf:panel>
<tr class='<%=Login.CONTROL_OPTIONSPANEL%>'>
<td height="30">&nbsp;</td>
<td>&nbsp;</td>
<td scope="row" class="leftAlignment"><dmf:checkbox id='<%=Login.CONTROL_ACCESS%>' name='<%=Login.CONTROL_ACCESS%>' nlsid='MSG_ACCESS' />
</tr>
</dmf:panel>
</table>
<dmf:panel name='<%=Login.CONTROL_ERRMSGPANEL%>'>
<div class='loginerrorspacing'>
<dmf:label name='<%=Login.CONTROL_ERRMSG%>' id='<%=Login.CONTROL_ERRMSG%>' style='{COLOR: #FF0000}'/>
<% if (AccessibilityService.isAllAccessibilitiesEnabled())
{  %>
<script language='JavaScript'>
registerClientEventHandler(null, "onDisplayWarning", DisplayWarning);
function DisplayWarning(msg)
{
alert(msg);
}
<% } %>
</script>
</div>
</dmf:panel>
</div>
</div>
<div id="buttonareaPane">
<div class="modalSmallButtonBar">
<div class="helpButtonSection">
<dmf:button onclick='onClickHelp' nlsid='MSG_HELP' runatclient='true' src="icons/help.gif" cssclass="helpImage"/>
</div>
<div class="rightButtonSection" nowrap>
<dmf:button name='<%=Login.CONTROL_LOGINBUTTON%>' nlsid='MSG_LOGIN' onclick='onLogin' default='true' accessible='true' tooltipnlsid='MSG_LOGIN_TIP'/>
<dmf:panel name='<%=Login.CONTROL_CHANGEPASSWORD_PANEL%>' id='<%=Login.CONTROL_CHANGEPASSWORD_PANEL%>' visible='false' renderifinvisible='true' >
<dmf:button name='<%=Login.CONTROL_CHANGEPASSWORD%>' cssclass='<%=Login.CONTROL_CHANGEPASSWORD_PANEL%>' visible='true' nlsid='<%=Login.MSG_CHANGE_PASSWORD%>' onclick='onChangePassword' accessible='true' tooltipnlsid='MSG_CHANGE_PASSWORD_TIP'/>
</dmf:panel>
</div>
</div>
</div>
</dmf:form>
</dmf:body>
</dmf:html>
