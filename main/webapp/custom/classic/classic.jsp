<%
//customizacion: en el ultimo dmf:frameset se ha puesto 0 pixels al browsertree: <dmf:frameset cols="0,*"/>
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ page import="com.documentum.web.form.Form" %>
<%@ page import="com.documentum.webtop.webcomponent.classic.Classic" %>
<%@ page import="com.documentum.webtop.webcomponent.browsertree.BrowserTree" %>
<%@ page import="com.documentum.web.common.AccessibilityService" %>
<%@ page import="com.documentum.web.common.LocaleService"%>
<html>
<head>
<dmf:webform formclass="com.documentum.webtop.webcomponent.classic.Classic"
nlsbundle="com.documentum.webtop.accessibility.FrameTitleNlsProp" />
<script type="text/javascript" src='<%=Form.makeUrl(request, "/wdk/include/dynamicAction.js")%>'></script>
<script type="text/javascript" src='<%=Form.makeUrl(request, "/webtop/classic/browsertree/browsertree.js")%>'></script>
<script type="text/javascript" src='<%=Form.makeUrl(request, "/webtop/classic/classic.js")%>'></script>
</head>
<%
Classic form = (Classic)pageContext.getAttribute(Classic.FORM, PageContext.REQUEST_SCOPE);
String strBrowsertreeArgs = "?inlineRefresh=true";
StringBuffer browsertreeArgsBuffer = new StringBuffer(strBrowsertreeArgs);
String strEntryNode = form.getEntryNode();
// from the request.  We can't get the parameter from the initialization parameters since F5 refresh support
String strEntryObjectId = form.getPageContext().getRequest().getParameter(Classic.ARG_ENTRY_ID);
boolean haveEntryNode = strEntryNode != null && strEntryNode.length() > 0;
boolean haveObjectId = strEntryObjectId != null && strEntryObjectId.length() > 0;
if (haveEntryNode || haveObjectId)
{
if (haveEntryNode)
{
browsertreeArgsBuffer.append("&");
browsertreeArgsBuffer.append(BrowserTree.ARG_ENTRY_NODE);
browsertreeArgsBuffer.append('=');
browsertreeArgsBuffer.append(strEntryNode);
}
if (haveObjectId)
{
browsertreeArgsBuffer.append("&");
browsertreeArgsBuffer.append(BrowserTree.ARG_ENTRY_OBJECT_ID);
browsertreeArgsBuffer.append('=');
browsertreeArgsBuffer.append(strEntryObjectId);
}
strBrowsertreeArgs = browsertreeArgsBuffer.toString();
}
boolean bAccessibilitiesEnabled = AccessibilityService.isAllAccessibilitiesEnabled();
String strRows = "0,*";
if (bAccessibilitiesEnabled)
{
strRows = "100%";
}
//
%>
<dmf:frameset rows="<%=strRows%>" border="0" frameborder="0" framespacing="0" onunload="onPageUnload()">
<%
if (!bAccessibilitiesEnabled)
{
%>       <dmf:frame nlsid="MSG_TOOLBAR" name='toolbar' marginwidth='0' marginheight='0' frameborder='no' src='/component/toolbar' scrolling='no' noresize="true"/>
<%    }
//
%>
<%
boolean bRtlEnabled = LocaleService.isRightToLeftLocale();
if (bRtlEnabled == true)
{
//
%>
<dmf:frameset cols="*,240" border="3" frameborder="1" framespacing="3">
<dmf:frame nlsid="MSG_WORKAREA" name='workarea' src='/webtop/classic/workarea.jsp' frameborder='0'/>
<dmf:frame nlsid="MSG_BROWSER" name='browser' src='<%="/component/browsertree" + strBrowsertreeArgs%>' frameborder='1' scrolling='auto'/>
</dmf:frameset>
<%
}
else
{
//
%>
<dmf:frameset cols="0,*" border="3" frameborder="1" framespacing="3">
<dmf:frame nlsid="MSG_BROWSER" name='browser' src='<%="/component/browsertree" + strBrowsertreeArgs%>' frameborder='1' scrolling='auto' noresize="true"/>
<dmf:frame nlsid="MSG_WORKAREA" name='workarea' src='/webtop/classic/workarea.jsp' frameborder='0' noresize="true"/>
</dmf:frameset>
<% } %>
</dmf:frameset>
</html>
