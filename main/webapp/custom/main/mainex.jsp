<%
//customizacion: se ha tocado <dmf:frame nlsid=MSG_CLASSICVIEW> para que apunte a /custom/classic/classic.jsp
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ page import="com.documentum.web.form.Form" %>
<%@ page import="com.documentum.webtop.webcomponent.main.Main" %>
<%@ page import="com.documentum.webtop.webcomponent.classic.Classic" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
"http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<dmf:webform/>
<title><dmf:label nlsid="MSG_TITLE"/></title>
<script type='text/javascript' src='<%=Form.makeUrl(request, "/webtop/main/main.js")%>'></script>
<script type='text/javascript' src='<%=Form.makeUrl(request, "/wdk/include/timeoutControl.js")%>'></script>
<script type='text/javascript' src='<%=Form.makeUrl(request, "/wdk/include/unsavedChanges.js")%>'></script>
<script type='text/javascript'>onSetView("classic");</script>
<script type='text/javascript'>
function onUnload()
{
promptIfUnsavedChangesExist();
manageTimeout(frames["timeoutcontrol"]);
}
</script>
</head>
<%
Main main = (Main)pageContext.getAttribute(Form.FORM, PageContext.REQUEST_SCOPE);
String strClassicArgs = "";
StringBuffer classicArgsBuffer = new StringBuffer();
String strEntrySection = main.getEntrySection();
String strEntryId = main.getEntryId();
boolean haveEntrySection = strEntrySection != null && strEntrySection.length() > 0;
boolean haveEntryId = strEntryId != null && strEntryId.length() > 0;
if (haveEntrySection || haveEntryId)
{
classicArgsBuffer.append("?");
if (haveEntrySection)
{
classicArgsBuffer.append(Classic.ARG_ENTRY_NODE);
classicArgsBuffer.append('=');
classicArgsBuffer.append(strEntrySection);
if (haveEntryId)
{
classicArgsBuffer.append('&');
}
}
if (haveEntryId)
{
classicArgsBuffer.append(Classic.ARG_ENTRY_ID);
classicArgsBuffer.append('=');
classicArgsBuffer.append(strEntryId);
}
strClassicArgs = classicArgsBuffer.toString();
}
//
%>
<dmf:frameset rows='0,0,28,*,21' border='0' framespacing='0' frameborder='false' onunload='onUnload()'>
<dmf:frame name="timeoutcontrol" src="/wdk/timeoutcontrol.jsp" marginwidth="0" marginheight="0" scrolling="no" noresize="true"/>
<dmf:frame name="residentucfinvoker" src="/component/residentucfinvoker" marginwidth="0" marginheight="0" scrolling="no" noresize="true"/>
<dmf:frame nlsid="MSG_TITLEBAR" name='titlebar' src="/component/titlebar" scrolling="no" noresize="true"/>
<dmf:frame nlsid="MSG_CLASSICVIEW" name='view' src='<%="/custom/classic/classic.jsp" + strClassicArgs%>' scrolling="no" noresize="true"/>
<dmf:frame nlsid="MSG_MESSAGEBAR" frameborder='false' name='messagebar' src='/component/messagebar' scrolling='no' noresize="true"/>
</dmf:frameset>
</html>
