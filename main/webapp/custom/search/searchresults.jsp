<%
//
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx" %>
<%@ page import="com.documentum.webcomponent.library.search.result.SearchResultSet,
com.documentum.webcomponent.library.search.SearchInfo,
com.documentum.web.dragdrop.IDropTarget" %>
<%@ page import="com.documentum.web.form.Form" %>
<%@ page import="com.documentum.web.form.control.databound.Datagrid" %>
<%@ page import="com.documentum.webcomponent.library.search.Search60"%>
<%@ page import="com.documentum.web.common.AccessibilityService"%>
<%@ page import="com.documentum.web.formext.control.cluster.SmartNavigationService" %>
<html>
<head>
<dmf:webform/>
<script language='JavaScript1.2' src='<%=Form.makeUrl(request, "/wdk/include/dynamicAction.js")%>'></script>
<script language='JavaScript1.2' src='<%=Form.makeUrl(request, "/wdk/include/windows.js")%>'></script>
<script language='JavaScript1.2' src='<%=Form.makeUrl(request, "/webcomponent/navigation/navigation.js")%>'></script>
<script>
function showQuery(strQueryId)
{
window.open('<%=Form.makeUrl(request, "/webcomponent/library/searchresultslist/searchex/showquery.jsp?queryId=")%>' + escape(strQueryId), "" + new Date().getTime(), g_strDefWinOptions);
}
var gRegisterShowQuery;
if (gRegisterShowQuery != "true")
{
gRegisterShowQuery = "true";
registerClientEventHandler(null, "showQuery", showQuery);
}
</script>
</head>
<body class='contentBackground' marginheight='0' marginwidth='0'
topmargin='0' bottommargin='0' leftmargin='0' rightmargin='0'>
<dmfx:dragdrop/>
<dmf:form>
<%
Search60 form = (Search60)pageContext.getAttribute(Form.FORM, PageContext.REQUEST_SCOPE);
Datagrid datagrid = ((Datagrid)form.getControl(Search60.CONTROL_GRID, Datagrid.class));
%>
<table class='headerBackground' cellspacing='0' cellpadding='0' border='0' width="100%" >
<tr >
<td colspan="23">
<table cellspacing=0 cellpadding=0 border=0 width="100%">
<tr valign="middle">
<td class="leftAlignment" height="30">
<div>
<dmf:label name='<%=Search60.CONTROL_QUERY_TITLE%>' cssclass='webcomponentTitle'/>
</div>
<div class="floatLeftAlignment">
<dmf:image name='<%=Search60.CONTROL_PROCESSING_SEARCH%>' id='<%=Search60.CONTROL_PROCESSING_SEARCH%>'
onclick="onClickStatus" alttext='<%=form.getString("MSG_PROCESSING_TIP")%>'/>
</div>
<%--query desc--%>
<div style="vertical-align: top; padding: 6px 50px 0; margin-left: -50px;">
<dmf:label id='<%=Search60.CONTROL_RESULT_COUNT%>' name='<%=Search60.CONTROL_RESULT_COUNT%>'
cssclass='drilldownLabel'/>
<dmf:stringlengthformatter maxlen='<%=Search60.LABEL_MAXLEN%>'>
<dmf:label id='<%=Search60.CONTROL_QUERY_DESCRIPTION%>'
name='<%=Search60.CONTROL_QUERY_DESCRIPTION%>' cssclass='drilldownLabel'/>
</dmf:stringlengthformatter>
</div>
</td>
<td valign="middle" class="rightAlignment" nowrap>
<table cellspacing='0' cellpadding='3' border='0' class='searchResultsBackground floatRightAlignment'>
<tr align="center">
<%--stop search--%>
<td width="54">
<div >
<%if(!AccessibilityService.isAllAccessibilitiesEnabled()){%>
<a href="#">
<dmf:image name='<%=Search60.CONTROL_START_STOP_SEARCH%>'
id='<%=Search60.CONTROL_START_STOP_SEARCH%>' cssclass='actionimage'/>
</a>
<%}%>
<a id="stopStartLink" class="drilldownLabel" href="#">
<nobr id="stopStartBr"><%=form.getString("MSG_STOP_SEARCH")%>
</nobr>
</a>
</div>
</td>
<td>
	<a href="#">
		<dmf:image name='dummy' id='dummy' cssclass='actionimage' src='<%=Form.makeUrl(request,"/custom/icons/go-back-icon.png")%>'/>
	</a>
	<div>
		<a id="linkback" class="drilldownLabel" href="<%=Form.makeUrl(request,"/component/initpath")%>" target="_top">
			<nobr>Volver</nobr>
		</a>
	</div>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<dmf:panel name="<%=Search60.CLUSTER_BREADCRUMB_PANEL%>">
<tr class='contentBackground'>
<td colspan='23' height='1' class='spacer'></td>
</tr>
<tr>
<td colspan=23 height="24">
<table width=100% border=0 cellspacing=0 cellpadding=0>
<tr>
<td>
<table border=0 cellspacing=0 cellpadding=0>
<tr>
<td nowrap>&nbsp;
<dmf:link name="<%=Search60.CONTROL_LINK_ALLRESULTS%>" onclick='onClickAllResults'
cssclass='drilldownLabel'/>
</td>
<td nowrap>&nbsp;
<dmf:label name="<%=Search60.FST_SEPARATOR_LABEL%>" cssclass="drilldownLabel"/>
</td>
<dmf:panel name="<%=Search60.SUB_LINK_PANEL%>">
<td nowrap>&nbsp;
<dmf:link name="<%=Search60.CONTROL_LINK_CLUSTER%>" onclick="onClickClusterLink"
cssclass='drilldownLabel'/>
</td>
<td nowrap>&nbsp;
<dmf:label name="<%=Search60.SND_SEPARATOR_LABEL%>" cssclass="drilldownLabel"/>
</td>
</dmf:panel>
<td nowrap>&nbsp;
<dmf:label name="<%=Search60.CLUSTER_LABEL%>" cssclass="drilldownLabel"/>
</td>
</tr>
</table>
</td>
<td nowrap class="rightAlignment" >&nbsp;&nbsp;</td>
</tr>
</table>
</td>
</tr>
</dmf:panel>
</table>
<dmfx:actionmultiselect name='multi' selectionargs='objectId,<%=SearchInfo.ENTRYID_PARAM%>,<%=SearchInfo.QUERYID_PARAM%>'
selectiongroupargs='<%=SearchResultSet.ATTR_DOCBASE_ID%>'>
<dmfx:argument name='objectId' contextvalue='objectId'/>
<dmfx:argument name='type' contextvalue='type'/>
<dmfx:argument name='a_content_type' contextvalue='a_content_type'/>
<dmf:argument name='startworkflowId' value='startworkflow'/>
<dmf:argument name='<%=SearchInfo.ENTRYID_PARAM%>' datafield='<%=SearchResultSet.ATTR_KEY%>'/>
<dmfx:argument name='<%=SearchInfo.QUERYID_PARAM%>' contextvalue='<%=SearchInfo.QUERYID_PARAM%>'/>
<dmf:datagrid name='<%=Search60.CONTROL_GRID%>' paged='true' preservesort='false'
width='100%' cellspacing='0' cellpadding='0' bordersize='0' rowselection="true" fixedheaders="true" focus="true">
<tr class='pagerBackground'>
<td colspan="40" height="24">
<table width=100% border=0 cellspacing=0 cellpadding=0>
<tr>
<dmf:panel name='<%=Search60.CONTROL_HIGHLIGHT%>'>
<td nowrap class="leftAlignment">&nbsp;</td>
<td nowrap class="leftAlignment">
<dmf:image name='<%=Search60.CONTROL_HIGHLIGHT_BUTTON%>' alttext='<%=form.getString("MSG_TOGGLEHIGHLIGHT_TIP")%>' onclick="onToggleHighlight" height='16' />
</td>
</dmf:panel>
<td>
<table width="100%">
<tr>
<td class="rightAlignment" ><dmf:datapaging name='<%=Search60.CONTROL_PAGER%>' gotopageclass='doclistPager'/></td>
<td class="rightAlignment" ><dmf:label nlsid='MSG_SHOW_ITEMS'/>&nbsp;<dmf:datapagesize name='<%=Search60.CONTROL_DATAPAGESIZE%>' preference='application.display.classic' tooltipnlsid='MSG_SHOW_ITEMS' />&nbsp;</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td colspan='23' height='1' class='spacer'>&nbsp;</td>
</tr>
<%
if (AccessibilityService.isAllAccessibilitiesEnabled())
{
%>
<table width=100% border=0 cellspacing=0 cellpadding=0 summary='Data'>
<%
}
%>
<tr class='colHeaderBackground'>
<dmf:datagridTh scope='col' nowrap="true" cssclass='doclistcheckbox leftAlignment'>
<% if  (datagrid.getDataProvider().getResultsCount() >0 ) {%>
<dmfx:actionmultiselectcheckall cssclass='doclistbodyDatasortlink'>
<dmfx:argument name='objectId' contextvalue='objectId'/>
<dmfx:argument name='type' contextvalue='type'/>
<dmfx:argument name='folderId' contextvalue='folderId'/>
<dmfx:argument name='a_content_type' contextvalue='a_content_type'/>
<dmf:argument name='<%=SearchInfo.ENTRYID_PARAM%>' datafield='<%=SearchResultSet.ATTR_KEY%>'/>
<dmfx:argument name='<%=SearchInfo.QUERYID_PARAM%>' contextvalue='<%=SearchInfo.QUERYID_PARAM%>'/>
</dmfx:actionmultiselectcheckall>
<% } %>
</dmf:datagridTh>
<dmf:datagridTh scope='col' nowrap="true" cssclass='doclistlocicon leftAlignment'>
<dmf:datasortimage name='sortimg' datafield='r_lock_owner' cssclass='doclistbodyDatasortlink' reversesort='true' image='icons/sort/sortByLock.gif'/>
</dmf:datagridTh>
<dmf:celllist name='<%=Search60.CONTROL_COLUMNS_CELLLIST%>'>
<dmf:celltemplate field='object_name'>
<dmf:datagridTh scope='col' nowrap="true" cssclass='doclistfilenamedatagrid objectlistheaderspacing leftAlignment' resizable="true">
<dmf:datasortlink name='sort1' datafield='object_name' cssclass='doclistbodyDatasortlink'/>
</dmf:datagridTh>
<dmf:datagridRowModifier>
<dmf:datagridTh scope='col' align='center' nowrap="true" cssclass='spacer'>
<dmf:image name='prop' nlsid='MSG_PROPERTIES' src='images/space.gif'/>
</dmf:datagridTh>
</dmf:datagridRowModifier>
</dmf:celltemplate>
<dmf:celltemplate field='attachment_count'>
<dmf:datagridTh scope='col' align='center' cssclass='doclisticon'>
<dmf:datasortimage name='attachmentcount' datafield='CURRENT' cssclass='doclistbodyDatasortlink'
image='icons/indicator/Attachmentheader_16.gif'/>
</dmf:datagridTh>
</dmf:celltemplate>
<dmf:celltemplate field='score'>
<dmf:datagridTh scope='col' cssclass='doclistfilenamedatagrid leftAlignment' resizable="true">
<nobr><dmf:datasortlink name='sortScore' datafield='score' cssclass='doclistbodyDatasortlink' reversesort="true" mode='numeric'/></nobr>
</dmf:datagridTh>
</dmf:celltemplate>
<dmf:celltemplate field='topic_status'>
<dmf:datagridTh scope='col' cssclass='doclisticon leftAlignment'>
<dmf:datasortimage name='sorttopic' datafield='topic_status' cssclass='doclistbodyDatasortlink'
image='icons/sort/sortByDisc.gif'/>
</dmf:datagridTh>
</dmf:celltemplate>
<dmf:celltemplate field='room_status'>
<dmf:datagridTh scope='col' align='center' cssclass='doclisticon'>
<dmf:datasortimage name='sortroom' datafield='room_status' cssclass='doclistbodyDatasortlink'
image='icons/sort/sortByRoom.gif'/>
</dmf:datagridTh>
</dmf:celltemplate>
<dmf:celltemplate field='title'>
<dmf:datagridTh scope='col' cssclass='doclistfilenamedatagrid leftAlignment' resizable="true">
<dmf:datasortlink name='sort2' datafield='title' cssclass='doclistbodyDatasortlink'/>
</dmf:datagridTh>
</dmf:celltemplate>
<dmf:celltemplate field='authors'>
<dmf:datagridTh scope='col' cssclass='doclistfilenamedatagrid leftAlignment' resizable="true">
<dmf:datasortlink name='sort3' datafield='authors' cssclass='doclistbodyDatasortlink'/>
</dmf:datagridTh>
</dmf:celltemplate>
<dmf:celltemplate type='number'>
<dmf:datagridTh scope='col' cssclass='doclistfilenamedatagrid leftAlignment' resizable="true">
<nobr><dmf:datasortlink name='sort4' datafield='CURRENT' mode='numeric' cssclass='doclistbodyDatasortlink'/></nobr>
</dmf:datagridTh>
</dmf:celltemplate>
<dmf:celltemplate type='date'>
<dmf:datagridTh scope='col' cssclass='doclistfilenamedatagrid leftAlignment' resizable="true">
<nobr><dmf:datasortlink name='sort5' datafield='CURRENT' mode='numeric' cssclass='doclistbodyDatasortlink'/></nobr>
</dmf:datagridTh>
</dmf:celltemplate>
<dmf:celltemplate field='summary'>
</dmf:celltemplate>
<dmf:celltemplate>
<dmf:datagridTh scope='col' cssclass='doclistfilenamedatagrid leftAlignment'  resizable="true">
<nobr><dmf:datasortlink name='sort6' datafield='CURRENT' cssclass='doclistbodyDatasortlink'/></nobr>
</dmf:datagridTh>
</dmf:celltemplate>
</dmf:celllist>
<dmf:datagridTh valign="middle" cssclass="doclisticon">
<dmf:image name='<%=Search60.ICON_COLUMNS_PREF%>' src="icons/columnprefs_16.gif" nlsid="MSG_COLUMN_PREFERENCES" onclick="onClickColumnsPrefs">
<dmf:argument name="usemodalpopup" value="true"/>
<dmf:argument name="modalpopupwindowsize" value="large"/>
<dmf:argument name="refreshparentwindow" value="onok"/>
</dmf:image>
</dmf:datagridTh>
<dmf:datagridTh width="99%">&nbsp;</dmf:datagridTh>
</tr>
<dmf:datagridRow tooltipdatafield='object_name' cssclass='defaultDatagridRowStyle' altclass="defaultDatagridRowAltStyle">
<dmf:datagridRowTd height='24' nowrap="true" cssclass="doclistcheckbox">
<dmf:panel datafield="<%=SearchResultSet.ATTR_IS_CONNECTED%>">
<dmfx:actionmultiselectcheckbox name='check' value='false' cssclass='actions'>
<dmf:argument name='objectId' datafield='r_object_id'/>
<dmf:argument name='type' datafield='r_object_type'/>
<dmf:argument name='lockOwner' datafield='r_lock_owner'/>
<dmf:argument name='ownerName' datafield='owner_name'/>
<dmf:argument name='contentSize' datafield='r_full_content_size'/>
<dmf:argument name='contentType' datafield='a_content_type'/>
<dmf:argument name="isVirtualDoc" datafield='r_is_virtual_doc'/>
<dmf:argument name="linkCount" datafield='r_link_cnt'/>
<dmf:argument name='startworkflowId' value='startworkflow'/>
<dmf:argument name='workflowRuntimeState' value='-1'/>
<dmf:argument name='isReference' datafield='i_is_reference'/>
<dmf:argument name='isReplica' datafield='i_is_replica'/>
<dmf:argument name='assembledFromId' datafield='r_assembled_from_id'/>
<dmf:argument name='isFrozenAssembly' datafield='r_has_frzn_assembly'/>
<dmf:argument name='<%=SearchResultSet.ATTR_DOCBASE_ID%>' datafield='<%=SearchResultSet.ATTR_DOCBASE_ID%>'/>
<dmf:argument name='<%=SearchInfo.ENTRYID_PARAM%>' datafield='<%=SearchResultSet.ATTR_KEY%>'/>
<dmfx:argument name='<%=SearchInfo.QUERYID_PARAM%>' contextvalue='<%=SearchInfo.QUERYID_PARAM%>'/>
<dmf:argument name='topicStatus' datafield='topic_status'/>
</dmfx:actionmultiselectcheckbox>
</dmf:panel>
</dmf:datagridRowTd>
<dmf:datagridRowTd nowrap="true" cssclass="doclistlocicon">
<dmfx:docbaselockicon datafield='r_lock_owner' size='16'/>
</dmf:datagridRowTd>
<dmf:celllist>
<dmf:celltemplate field='object_name'>
<dmf:datagridRowTd nowrap="true" scope='row' cssclass='doclistfilenamedatagrid'>
<dmf:termshighlightingformatter datafield='<%=SearchResultSet.ATTR_THH%>' cssclass='termshighlight' separator='<%=SearchResultSet.THH_SEPARATOR%>'  visible='<%=String.valueOf(form.isHighlightActive())%>'>
<dmf:stringlengthformatter maxlen='32'>
<dmf:panel datafield='r_object_id' reversevisible='true' >
<dmfx:docbaseicon formatdatafield='a_content_type' type='dm_document'/>
<dmf:panel datafield='<%=SearchResultSet.ATTR_URL%>'>
<dmf:datagridRowEvent eventname="dblclick">
<dmf:open datafield='object_name' uridatafield='<%=SearchResultSet.ATTR_URL%>' target='' sendcontext='false'/>
</dmf:datagridRowEvent>
</dmf:panel>
<dmf:panel datafield='<%=SearchResultSet.ATTR_URL%>' reversevisible='true'>
<dmfx:actionlink action='view'  datafield='object_name' name='viewExtResult' showifinvalid="true" >
<dmf:argument name='<%=SearchInfo.ENTRYID_PARAM%>' datafield='<%=SearchResultSet.ATTR_KEY%>'/>
<dmfx:argument name='<%=SearchInfo.QUERYID_PARAM%>' contextvalue='<%=SearchInfo.QUERYID_PARAM%>'/>
<dmf:argument name='type' datafield='r_object_type'/>
</dmfx:actionlink>
</dmf:panel>
</dmf:panel>
<dmf:panel datafield='r_object_id'>
<dmfx:dragdropregion datafield='object_name' enableddroppositions="<%=IDropTarget.DROP_POSITION_OVER%>" ondrop='onDrop' dragenabled='true' overlayAsDiv="true">
<dmf:argument name='objectId' datafield='r_object_id'/>
<dmf:argument name='lockOwner' datafield='r_lock_owner'/>
<dmfx:docbaseicon formatdatafield='a_content_type' typedatafield='r_object_type' linkcntdatafield='r_link_cnt' isvirtualdocdatafield='r_is_virtual_doc' assembledfromdatafield='r_assembled_from_id' isfrozenassemblydatafield='r_has_frzn_assembly' isreplicadatafield='i_is_replica' isreferencedatafield='i_is_reference' size='16'/>
<dmf:datagridRowEvent eventname="dblclick">
<dmf:link name='doclnk' onclick='onClickDocbaseObject' datafield='object_name' runatclient='true'>
<dmf:argument name='objectId' datafield='r_object_id'/>
<dmf:argument name='type' datafield='r_object_type'/>
<dmf:argument name="isVirtualDoc" datafield='r_is_virtual_doc'/>
<dmf:argument name='assembledFromId' datafield='r_assembled_from_id'/>
<dmf:argument name="linkCount" datafield='r_link_cnt'/>
</dmf:link>
</dmf:datagridRowEvent>
</dmfx:dragdropregion>
</dmf:panel>
</dmf:stringlengthformatter>
</dmf:termshighlightingformatter>
</dmf:datagridRowTd>
<dmf:datagridRowModifier>
<dmf:datagridRowTd align="center" valign="middle">
<dmfx:actionimage name='propact' nlsid='MSG_PROPERTIES' action='properties' src='icons/info.gif' showifdisabled='false'>
<dmf:argument name='objectId' datafield='r_object_id'/>
<dmf:argument name='type' datafield='r_object_type'/>
<dmf:argument name='<%=SearchInfo.ENTRYID_PARAM%>' datafield='<%=SearchResultSet.ATTR_KEY%>'/>
<dmfx:argument name='<%=SearchInfo.QUERYID_PARAM%>' contextvalue='<%=SearchInfo.QUERYID_PARAM%>'/>
</dmfx:actionimage>
</dmf:datagridRowTd>
</dmf:datagridRowModifier>
</dmf:celltemplate>
<dmf:celltemplate field='score'>
<dmf:datagridRowTd cssclass='doclistfilenamedatagrid'>
<dmf:panel datafield='score'>
<dmf:numberformatter type='percent'>
<dmf:label datafield='score'/>
</dmf:numberformatter>
</dmf:panel>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field="attachment_count">
<dmf:datagridRowTd nowrap="true" cssclass='doclisticon'>
<dmf:msgattachmenticon>
<dmf:argument name='attachmentcount' datafield='attachment_count'/>
</dmf:msgattachmenticon>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='message_importance'>
<dmf:datagridRowTd nowrap="true" cssclass='doclistfilenamedatagrid'>
<dmf:messageimportanceformatter lownlsid="MSG_IMPORTANCE_LOW" normalnlsid="MSG_IMPORTANCE_NORMAL"  hinlsid="MSG_IMPORTANCE_HIGH">
<dmf:label datafield='message_importance'/>
</dmf:messageimportanceformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='<%=SearchResultSet.ATTR_LOCATION%>'>
<dmf:datagridRowTd cssclass='doclistfilenamedatagrid' nowrap="true">
<dmf:termshighlightingformatter datafield='<%=SearchResultSet.ATTR_THH%>' cssclass='termshighlight' separator='<%=SearchResultSet.THH_SEPARATOR%>'  visible='<%=String.valueOf(form.isHighlightActive())%>'>
<dmf:stringlengthformatter maxlen='32'>
<dmf:panel datafield='<%=SearchResultSet.ATTR_LOCATION_URL%>'>
<dmf:open datafield='<%=SearchResultSet.ATTR_SOURCE%>' uridatafield='<%=SearchResultSet.ATTR_LOCATION_URL%>' target='' sendcontext='false'/>
</dmf:panel>
<dmf:panel datafield='<%=SearchResultSet.ATTR_LOCATION_FOLDERPATH%>'>
<dmf:link name='loclnk' onclick='onClickContainer' datafield='<%=SearchResultSet.ATTR_LOCATION_FOLDERPATH%>'>
<dmf:argument name='objectId' datafield='r_object_id'/>
</dmf:link>
</dmf:panel>
<dmf:panel datafield='<%=SearchResultSet.ATTR_LOCATION_FOLDERPATH%>' reversevisible='true'>
<dmf:panel datafield='<%=SearchResultSet.ATTR_LOCATION_URL%>' reversevisible='true'>
<dmf:label datafield='<%=SearchResultSet.ATTR_SOURCE%>'/>
</dmf:panel>
</dmf:panel>
</dmf:stringlengthformatter>
</dmf:termshighlightingformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field="topic_status">
<dmf:datagridRowTd cssclass='doclisticon'>
<dmfx:topicstatus name='status'  nlsid='MSG_NO_COMMENTS' action='showtopicaction'  src='icons/none.gif' height='16' width='16' showifdisabled='false' >
<dmf:argument name='objectId' datafield='r_object_id'/>
<dmf:argument name='type' datafield='r_object_type'/>
<dmf:argument name='topicStatus' datafield='topic_status'/>
<dmfx:argument name='folderId' contextvalue='objectId'/>
</dmfx:topicstatus>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='room_status' >
<dmf:datagridRowTd cssclass='doclisticon'>
<dmfx:governedicon name='room' action='view' src='icons/none.gif' height='16' width='16'  >
<dmf:argument name='objectId' datafield='r_object_id'/>
<dmf:argument name='governing' datafield='room_status'/>
<dmf:argument name='type' value='dmc_room'/>
</dmfx:governedicon>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='title'>
<dmf:datagridRowTd cssclass='doclistfilenamedatagrid'>
<dmf:termshighlightingformatter datafield='<%=SearchResultSet.ATTR_THH%>' cssclass='termshighlight' separator='<%=SearchResultSet.THH_SEPARATOR%>'  visible='<%=String.valueOf(form.isHighlightActive())%>'>
<dmfx:folderexclusionformatter datafield='r_object_type'>
<dmf:htmlsafetextformatter>
<dmf:label datafield='title'/>
</dmf:htmlsafetextformatter>
</dmfx:folderexclusionformatter>
</dmf:termshighlightingformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='authors'>
<dmf:datagridRowTd cssclass='doclistfilenamedatagrid'>
<dmf:termshighlightingformatter datafield='<%=SearchResultSet.ATTR_THH%>' cssclass='termshighlight' separator='<%=SearchResultSet.THH_SEPARATOR%>'  visible='<%=String.valueOf(form.isHighlightActive())%>'>
<dmfx:folderexclusionformatter datafield='r_object_type'>
<dmf:htmlsafetextformatter>
<dmf:label datafield='authors'/>
</dmf:htmlsafetextformatter>
</dmfx:folderexclusionformatter>
</dmf:termshighlightingformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='r_version_label'>
<dmf:datagridRowTd cssclass='doclistfilenamedatagrid'>
<dmfx:folderexclusionformatter datafield='r_object_type'>
<dmf:htmlsafetextformatter>
<dmf:label datafield='r_version_label'/>
</dmf:htmlsafetextformatter>
</dmfx:folderexclusionformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='a_content_type'>
<dmf:datagridRowTd nowrap="true" cssclass='doclistfilenamedatagrid'>
<dmf:termshighlightingformatter datafield='<%=SearchResultSet.ATTR_THH%>' cssclass='termshighlight' separator='<%=SearchResultSet.THH_SEPARATOR%>'  visible='<%=String.valueOf(form.isHighlightActive())%>'>
<dmf:stringlengthformatter maxlen='14'>
<dmfx:docformatvalueformatter>
<dmf:label datafield='CURRENT'/>
</dmfx:docformatvalueformatter>
</dmf:stringlengthformatter>
</dmf:termshighlightingformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='r_full_content_size'>
<dmf:datagridRowTd nowrap="true" cssclass='doclistfilenamedatagrid'>
<dmfx:docsizevalueformatter datafield='r_object_type'>
<dmf:label datafield='r_full_content_size'/>
</dmfx:docsizevalueformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='r_current_state'>
<dmf:datagridRowTd nowrap="true" cssclass='doclistfilenamedatagrid'>
<dmfx:policystatenameformatter datafield='r_policy_id'>
<dmf:label datafield='r_current_state'/>
</dmfx:policystatenameformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate type='date'>
<dmf:datagridRowTd nowrap="true" cssclass='doclistfilenamedatagrid'>
<dmf:datevalueformatter>
<dmf:label datafield='CURRENT'/>
</dmf:datevalueformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
<dmf:celltemplate field='summary'>
</dmf:celltemplate>
<dmf:celltemplate>
<dmf:datagridRowTd nowrap="true" cssclass='doclistfilenamedatagrid'>
<dmf:termshighlightingformatter datafield='<%=SearchResultSet.ATTR_THH%>' cssclass='termshighlight' separator='<%=SearchResultSet.THH_SEPARATOR%>'  visible='<%=String.valueOf(form.isHighlightActive())%>'>
<dmf:htmlsafetextformatter>
<dmf:label datafield='CURRENT'/>
</dmf:htmlsafetextformatter>
</dmf:termshighlightingformatter>
</dmf:datagridRowTd>
</dmf:celltemplate>
</dmf:celllist>
<dmf:datagridRowTd>&nbsp;</dmf:datagridRowTd>
<dmf:datagridRowTd width="99%">&nbsp;</dmf:datagridRowTd>
<dmf:panel datafield="summary">
<dmf:datagridRowBreak/>
<dmf:celllist>
<dmf:celltemplate field="summary">
<td colspan="40" class="additionalRow">
<dmf:termshighlightingformatter
datafield='<%=SearchResultSet.ATTR_THH%>'
cssclass='termshighlight'
separator='<%=SearchResultSet.THH_SEPARATOR%>'
visible='<%=String.valueOf(form.isHighlightActive())%>'>
<dmf:stringlengthformatter maxlen='130'>
<dmf:label datafield='summary'/>
</dmf:stringlengthformatter>
</dmf:termshighlightingformatter>
</td>
</dmf:celltemplate>
</dmf:celllist>
</dmf:panel>
</dmf:datagridRow>
<dmf:nodataRow>
<td colspan=23 height=24>
&nbsp;&nbsp;<dmf:label name='<%=Search60.CONTROL_NODATA%>' id='<%=Search60.CONTROL_NODATA%>'/>
</td>
</dmf:nodataRow>
<%
if (AccessibilityService.isAllAccessibilitiesEnabled())
{
%>
</table>
<%
}
%>
</dmf:datagrid>
</dmfx:actionmultiselect>
<script type="text/javascript">
var updateStatusCall;
function initInlineCall ()
{
notifyPollingInitiation()
updateStatusCall = setInterval("updateSearchStatus()", 1000);
var startStopSearchImg = wdk.dom.get('<%=Search60.CONTROL_START_STOP_SEARCH%>');
var startStopSearchLink = document.getElementById("stopStartLink");
if ( startStopSearchImg != null)
{
startStopSearchImg.onclick = null;
startStopSearchImg.onclick = onStopSearch;
}
startStopSearchLink.onclick = onStopSearch;
}
function updateSearchStatus ()
{
var prefs = InlineRequestEngine.getPreferences(InlineRequestType.JSON);
prefs.setCallback(renderSearchStatus);
postInlineServerEvent(null, prefs, null, null, "onUpdateSearchStatus", null, null);
}
function renderSearchStatus (data)
{
var showResults = data['<%=Search60.JSON_SHOW_RESULTS%>'];
var isCompleted = data['<%=Search60.JSON_IS_COMPLETED%>'];
if (showResults)
{
var noDataLabel = document.getElementById('<%=Search60.CONTROL_NODATA%>');
if(noDataLabel != null)
{
showSearchResults();
}
else
{
fireClientEvent("onExecuteQuery", '<%=form.getSearchInfo().getQueryId()%>','<%=SmartNavigationService.isContentClusteringServiceAvailable()%>');
}
}
else
{
if (isCompleted)
{
clearInterval(updateStatusCall);
var processingImg = wdk.dom.get('<%=Search60.CONTROL_PROCESSING_SEARCH%>');
if (processingImg !=null)
{
processingImg.src = '<%=Form.makeUrl(request, "/wdk/theme/documentum/"+Search60.ICON_SEARCH_DONE)%>';
}
var startStopSearchImg = wdk.dom.get('<%=Search60.CONTROL_START_STOP_SEARCH%>');
if(startStopSearchImg!=null)
{
startStopSearchImg.src = '<%=Form.makeUrl(request, "/wdk/theme/documentum/"+Search60.ICON_START_SEARCH)%>';
}
document.getElementById("stopStartBr").innerHTML = "<%=form.getString("MSG_RESTART_SEARCH")%>";
var alttext = '<%=form.getString("MSG_RESTART_SEARCH_TIP")%>';
var startStopSearchLink = document.getElementById("stopStartLink");
startStopSearchLink.alt = alttext;
if(startStopSearchImg!=null)
{
startStopSearchImg.alt = alttext;
startStopSearchImg.onclick = null;
startStopSearchImg.onclick = onRestartSearch;
}
startStopSearchLink.onclick = onRestartSearch;
}
else
{
var startStopSearchImg = wdk.dom.get('<%=Search60.CONTROL_START_STOP_SEARCH%>');
var startStopSearchLink = document.getElementById("stopStartLink");
var alttext = '<%=form.getString("MSG_STOP_SEARCH_TIP")%>';
document.getElementById("stopStartBr").innerHTML = '<%=form.getString("MSG_STOP_SEARCH")%>';
if(startStopSearchImg !=null)
{
startStopSearchImg.onclick = null;
startStopSearchImg.onclick = onStopSearch;
startStopSearchImg.alt = alttext;
}
startStopSearchLink.onclick = onStopSearch;
startStopSearchLink.alt = alttext;
}
var resultsCount = data['<%=Search60.JSON_RESULTS%>'];
wdk.dom.get('<%=Search60.CONTROL_RESULT_COUNT%>').innerHTML = resultsCount;
var desc = data['<%=Search60.JSON_DESCRIPTION%>'];
wdk.dom.get('<%=Search60.CONTROL_QUERY_DESCRIPTION%>').innerHTML = desc;
}
unlock();
if (isCompleted)
{
notifyPollingComplete();
}
}
function notifyPollingInitiation()
{
if (window.suspendTestEvents)
{
window.suspendTestEvents();
}
}
function notifyPollingComplete()
{
if (window.resumeTestEvents)
{
window.resumeTestEvents();
}
}
function showSearchResults ()
{
clearInterval(updateStatusCall);
unlock();
notifyPollingComplete();
<dmf:postserverevent handlermethod='onShowResults'/>
}
function onStopSearch ()
{
clearInterval(updateStatusCall);
unlock();
notifyPollingComplete();
<dmf:postserverevent handlermethod='onStopSearch'/>
}
function onRestartSearch ()
{
clearInterval(updateStatusCall);
unlock();
notifyPollingComplete();
<dmf:postserverevent handlermethod='onRestartSearch' />
}
function unlock ()
{
if (isEventPostingLocked())
{
releaseEventPostingLock();
}
}
</script>
</dmf:form>
<script>initInlineCall();</script>
</body>
</html>
