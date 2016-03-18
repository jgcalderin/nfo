<%
//
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ page import="com.documentum.web.form.Form,
com.documentum.web.formext.session.Logoff,
com.documentum.web.test.recorder.TestStepRecorder,
com.documentum.web.test.TestCaseDriver"%>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx" %>
<%
boolean inTestPlayback = TestCaseDriver.inService();
//
%>
<dmf:html>
<dmf:head>
<dmf:webform/>
<dmf:title><dmf:label nlsid="MSG_TITLE"/></dmf:title>
<script language='javascript'>
function loginAgain()
{
// CUSTOMIZACION PARA REDIRIGIR A INITPATH
var strUrl = addBrowserIdToURL("<%=request.getContextPath()%>/component/initpath");
navigateToURL(strUrl, "logoff", window);
}
</script>
<dmfx:clientenvpanel environment="appintg">
<dmf:fireclientevent event='aiEvent' includeargname='true'>
<dmf:argument    name='event'    value='LogoffSuccess'/>
</dmf:fireclientevent>
</dmfx:clientenvpanel>
</dmf:head>
<dmf:body id="modalSmall" topmargin='0' bottommargin='0'
leftmargin='0' rightmargin='0' marginheight='0' marginwidth='0'>
<dmf:form>
<dmf:panel name="<%=Logoff.PANEL_DEFAULT_PAGE%>">
<%-- THIS PANEL IS DISPLAYED BY DEFAULT (IF LOGOFF IS CALLED WITHOUT THE afterLogoff PARAM) --%>
<div id="mainPaneset" style="padding:20px">
<div><dmf:label cssclass='dialogTitle' nlsid='MSG_TITLE'/></div>
<div id="scrollingcontent">
<div class="innerContent">
	<div id="logo">
	<!-- CUSTOMIZACION PARA PONER EL NOMBRE DE NUESTRA APLICACION -->
	<!--<dmf:label nlsid="MSG_LOGO"/>&nbsp;-->
	<!--<dmf:label cssclass="dialogTitleVersion" nlsid="MSG_VERSION"/>-->
	<dmf:label cssclass="dialogTitleVersion" label="NECESIDADES DE FORMACIÓN DE OCUPACIONES"/>
</div>
<p style="text-align:center;font-weight:bold">
<dmf:label nlsid="MSG_TO_LOGIN_1" /><br/><dmf:label nlsid="MSG_TO_LOGIN_2" />
</p>
</div>
</div>
<div id="buttonareaPane">
<div class="modalSmallButtonBar">
<div class="helpButtonSection">
<dmf:button onclick='onClickHelp' nlsid='MSG_HELP' runatclient='true' src="icons/help.gif" cssclass="helpImage"/>
</div>
<div class="rightButtonSection">
<dmf:button name='loginAgainLink' onclick='loginAgain' nlsid="MSG_LOGIN_AGAIN" runatclient="true" tooltipnlsid='MSG_LOGIN_AGAIN'/>
</div>
</div>
</div>
</div>
</dmf:panel>
<dmf:panel name="<%=Logoff.PANEL_FORWARD%>" visible="false">
<%-- THIS PANEL IS DISPLAYED IF LOGOFF IS CALLED WITH afterLogoff=forward --%>
<% Logoff logoff = (Logoff) pageContext.getAttribute(Form.FORM, PageContext.REQUEST_SCOPE);%>
<jsp:include page="/wdk/redirect.jsp" flush="true">
<jsp:param name="__dmfUrl" value="<%=logoff.getForwardUrl()%>" />
</jsp:include>
</dmf:panel>
<dmf:panel name="<%=Logoff.PANEL_CLOSE%>" visible="false">
<%-- THIS PANEL IS DISPLAYED IF LOGOFF IS CALLED WITH afterLogoff=closeWindow --%>
<script language='javascript'>
function logoffCloseWindow()
{
window.opener = self;
window.close();
}
if (isClientEventHandlerRegistered("logoffCloseWindow") == false)
{
registerClientEventHandler(null, "logoffCloseWindow", logoffCloseWindow);
}
</script>
</dmf:panel>
</dmf:form>
</dmf:body>
</dmf:html>
<script language='javascript'>
<%
String archiveId = null;
if (TestStepRecorder.isRecording())
{
archiveId = TestStepRecorder.archiveRecording();
}
else if (inTestPlayback)
{
archiveId = TestCaseDriver.archiveHarness();
}
if (archiveId != null)
{
String url = TestCaseDriver.RESTORE_URI + "&archiveId=" + archiveId;
url = Form.makeUrl(pageContext.getRequest(), url);
//
%>
postAJAXEvent("<%=url%>", false);
<%
}
session.invalidate();
//
%>
</script>
