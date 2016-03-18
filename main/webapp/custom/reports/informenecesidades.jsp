<%@ page contentType="text/html;; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx" %>
<%@ page import="com.documentum.web.formext.component.Component,com.documentum.web.form.IParams"%>
<%@ page import="com.sepe.nfo.components.InformeNecesidades"%>
<%@ page import="com.documentum.web.form.Form" %>
<%
	InformeNecesidades mycomp = (InformeNecesidades)pageContext.getAttribute(IParams.FORM, PageContext.REQUEST_SCOPE);
%>
	            
<dmf:html>
	<dmf:head>
		<dmf:webform/>
		<script>
			function onClickViewInforme(obj)
			{
				var url = '<%=Form.makeUrl(request,"/servlet/DownloadServlet?docId=")%>';
				window.open(url + '<%=mycomp.getInformeObjectId()%>');
			}
		</script>
	</dmf:head>
	<dmf:body>
		<dmf:form>
			<br>
			<br>
			<dmf:label name="lblmsg" id="lblmsg" style="font-weitgh:bold;"/>
			<br>
			<br>
			<dmf:button name="visualizar" label="Sí" onclick="onClickViewInforme" runatclient='true' width="20"/>
		</dmf:form>
	</dmf:body>
</dmf:html>