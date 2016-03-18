
<%
	//customizacion: Se ha quitado el icono de la carpeta, la informacion del tipo, del formato y el tabbar se ha puesto a invisible
	//tambien se ha anyadido el label: micabecera 
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page errorPage="/wdk/errorhandler.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf"%>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx"%>
<%@ page
	import="com.documentum.webcomponent.library.properties.Properties,
com.documentum.web.formext.component.DialogContainer"%>
<dmf:html>
<dmf:head>
	<dmf:webform validation="true" />
	<dmf:title>
		<dmf:label nlsid='MSG_TITLE' /> &nbsp;<dmf:label nlsid='MSG_OBJECT' />
	</dmf:title>
</dmf:head>
<dmf:body id="modal" marginheight='0' marginwidth='0' topmargin='0' bottommargin='0' leftmargin='0' rightmargin='0'>
	<dmf:form>
		<dmf:paneset name="mainPaneset" rows="5,*,45" cssclass='defaultPanesetBackground' minheight="300" minwidth="350" toppadding="0" bottompadding="0">
			<dmf:pane name="headerareaPane" overflow="hidden">
				<dmfx:fragment src='modal/modalContainerStart.jsp' />
				<dmfx:clientenvpanel environment="portal" reversevisible="true">
					<dmf:label nlsid='MSG_TITLE' cssclass='webcomponentTitle' />
				</dmfx:clientenvpanel>
				<dmfx:fragment src='modal/modalTabbarStart.jsp' />
				<dmf:tabbar name='tabs' scrollable='false' showtabs="false" visible="false"/>
				<dmfx:fragment src='modal/modalTabbarEnd.jsp' />
			</dmf:pane>
			<dmf:paneset name="contentareaPaneset" cols="18,*,18" cssclass="contentBackground">
				<dmf:pane name="leftcolumn" overflow="hidden" printable="false">
					<dmfx:fragment src='modal/modalEdgesStart.jsp' />
				</dmf:pane>
				<dmf:pane name="scrollingcontent" overflow="auto">
					<dmfx:fragment src='modal/modalContentGutterStart.jsp' />
					<!-- customizacion start -->
					<dmf:label name="micabecera" style="font-weight:bold"/>
					<!-- customizacion end -->
					<table cellspacing="0" cellpadding="0" border="0" class="contentBackground">
						<tr>
							<dmf:label name='error_msg' visible="false" style="color:red" cssclass="validatorMessageStyle" /> 
							<dmf:panel name='<%=Properties.LAST_REFRESHED_PANEL%>'>
									<br>
									<dmf:label nlsid='MSG_LAST_REFRESHED' />&nbsp;
									<dmf:datevalueformatter><dmf:label name='r_last_refresh' /></dmf:datevalueformatter>
							</dmf:panel> 
							<dmf:panel name='<%=Properties.GOTO_TARGET_PANEL%>'>
								<br>
								<dmf:link name='gototargetlink' nlsid='MSG_GOTO_TARGET' onclick='onGotoTargetClick' />
							</dmf:panel>
						</tr>
					</table>
					<dmf:panel name='<%=Properties.THUMBNAIL_PANEL%>'>
						<dmfx:thumbnail name='thumbnail' />
					</dmf:panel>
					<dmfx:containerinclude />
					<dmfx:fragment src='modal/modalContentGutterEnd.jsp' />
				</dmf:pane>
				<dmf:pane name="rightcolumn" overflow="hidden" printable="false">
					<dmfx:fragment src='modal/modalEdgesEnd.jsp' />
				</dmf:pane>
			</dmf:paneset>
			<dmf:pane name="buttonareaPane" overflow="hidden">
				<dmfx:fragment src='modal/modalButtonbarStart.jsp' />
				<dmf:button name='ok' cssclass="buttonLink" nlsid='MSG_OK'
					onclick='onOk' hotkeyid='HOTKEY_OK' height='16'
					tooltipnlsid='MSG_OK_TIP' />
				<dmf:button name='cancel' cssclass='buttonLink' nlsid='MSG_CANCEL'
					onclick='onCancel' hotkeyid='HOTKEY_CANCEL' height='16'
					tooltipnlsid='MSG_CANCEL_TIP' />
				<dmfx:fragment src='modal/modalButtonbarEnd.jsp' />
				<dmfx:fragment src='modal/modalContainerEnd.jsp' />
			</dmf:pane>
		</dmf:paneset>
	</dmf:form>
</dmf:body>
</dmf:html>
