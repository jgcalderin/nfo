<%@ page import="com.documentum.web.form.Form" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<html>
<head>
<dmf:webcontainerrequirements/>
<script type="text/javascript" src='<%=Form.makeUrl(request, "/index.js")%>'></script>
</head>
<body onload='doRedirect("/component/initpath")'>
</body>
</html>
