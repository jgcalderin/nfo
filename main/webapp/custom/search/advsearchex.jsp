<%
//
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/wdk/errorhandler.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/dmform_1_0.tld" prefix="dmf" %>
<%@ taglib uri="/WEB-INF/tlds/dmformext_1_0.tld" prefix="dmfx" %>
<%@ taglib uri="/WEB-INF/tlds/dmfxsearch_1_0.tld" prefix="dmfxs" %>
<%@ page import="com.documentum.web.formext.control.docbase.search.RepositorySearch,
com.documentum.web.formext.control.docbase.search.SearchAttribute,
com.documentum.webcomponent.library.advsearch.AdvSearchEx,
com.documentum.web.form.IParams,
com.documentum.web.form.Form,
com.documentum.web.util.JavascriptUtil"%>
<dmf:html>
<%
String hrSpacerHeight = "1";
String spacerHeight = "6";
//
%>
<dmf:head>
<dmf:webform/>
<%
AdvSearchEx advsearch = (AdvSearchEx)pageContext.getAttribute(IParams.FORM,PageContext.REQUEST_SCOPE);
%>
<script language='JavaScript1.2' src='<%=Form.makeUrl(request, "/wdk/include/windows.js")%>'></script>
<script>
function <%=JavascriptUtil.namespaceScriptlet(request, "executeSavedSearch()")%>
{
<dmf:postserverevent handlerid='<%=advsearch.getElementName()%>' handlermethod='executeSavedSearch'/>
}
registerClientEventHandler(null, '<%=JavascriptUtil.namespaceScriptlet(request, "executeSavedSearch")%>', <%=JavascriptUtil.namespaceScriptlet(request, "executeSavedSearch")%>);
</script>
</dmf:head>
<dmf:body cssclass='contentBackground' marginheight='0' marginwidth='0'
topmargin='0' bottommargin='0' leftmargin='0' rightmargin='0'>
<dmf:form>
<dmfxs:repositorysearch name='repossearchctrl'>
<table cellpadding='1' cellspacing='1'>
	<!-- customizacion: display none -->
	<tr style="display:none">
		<td scope='row' class="rightAlignment" valign=top nowrap><dmf:label nlsid='MSG_CONTAINING_WORDS' cssclass="fieldlabel"/></td>
		<td class="leftAlignment" valign=top nowrap><dmfxs:searchfulltext name='fulltextctrl' size="49" tooltipnlsid='MSG_CONTAINING_WORDS'/></td>
	</tr>
	<tr><td colspan='2' class='spacer' height='<%=spacerHeight%>'>&nbsp;</td></tr>
	<!-- customizacion: display none -->
	<tr style="display:none">
		<td scope='row' class="rightAlignment" valign=top nowrap><dmf:label nlsid='MSG_LOOKIN_LOCATION' cssclass="fieldlabel"/></td>
		<dmfxs:searchlocation visible='false' name='searchlocationctrl'/>
		<td class="leftAlignment" valign=top nowrap>
			<div>
				<table valign=top border=0 cellspacing=0 cellpadding=0 >
					<tr>
					<td nowrap>
					<dmf:stringlengthformatter name="specificlocationformatter" maxlen='80' wrapped='false' postfix='...'>
					<dmf:radio name='specificlocationradio' group='locationradiogroup' onclick='onLocationRadioClicked' prefixassociatedlabelnlsid='MSG_LOOKIN_LOCATION'/>
					</dmf:stringlengthformatter>
					</td>
					<td nowrap width=20>&nbsp;</td>
					<td nowrap>
					<dmf:link cssclass="miniButton" onclick="onBrowseLocations" nlsid="MSG_CHANGE_LOCATION" name="locationlink" prefixassociatedlabelnlsid='MSG_LOOKIN_LOCATION'>
					<dmf:argument name="usemodalpopup" value="true"/>
					<dmf:argument name="modalpopupwindowsize" value="large"/>
					<dmf:argument name="refreshparentwindow" value="onok"/>
					</dmf:link>
					</td>
					</tr>
					<tr>
					<td class="leftAlignment" valign=top nowrap>
					<dmf:stringlengthformatter name="currentlocationformatter" maxlen='80' wrapped='false' postfix='...'>
					<dmf:radio name='currentlocationradio' group='locationradiogroup' onclick='onLocationRadioClicked' prefixassociatedlabelnlsid='MSG_LOOKIN_LOCATION'/>
					</dmf:stringlengthformatter>
					</td>
					<td colspan=2>&nbsp;</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
	<tr><td colspan='2' class='spacer' height='<%=spacerHeight%>'>&nbsp;</td></tr>
	<!-- customizacion: display none -->
	<tr style="display:none">
		<td class="rightAlignment" valign=top nowrap><dmf:label nlsid='MSG_OBJECT_TYPE' cssclass="fieldlabel"/></td>
		<td class="leftAlignment" valign=top nowrap>
			<dmfxs:searchobjecttypedropdownlist name='objecttypectrl' tooltipnlsid="MSG_OBJECT_TYPE_TIP" width='<%=SearchAttribute.DEFAULT_FIELD_WIDTH%>'/>&nbsp;&nbsp;
		</td>
	</tr>
<tr><td colspan='2' class='spacer' height='<%=hrSpacerHeight%>'>&nbsp;</td></tr>
<tr>
<td colspan="2">
<!-- customizacion: quitamos hr -->
<!-- <hr style="color: #808080;background-color: #808080;height: 1px;border: 0;"> -->
</td>
</tr>
<tr><td colspan='2' class='spacer' height='<%=hrSpacerHeight%>'>&nbsp;</td></tr>
<tr>
	<td scope='row' class="rightAlignment" valign=top nowrap><dmf:label nlsid='MSG_PROPERTIES' cssclass="fieldlabel"/></td>
	<td class="leftAlignment" valign=top nowrap><%%>
		<dmfxs:searchattributegroup 
		name='attributesearchcriteria' 
		tooltipnlsid="MSG_PROPERTIES_TIP" 
		excludetypes='time' 
		excludenames='r_content_size,r_full_content_size,a_is_hidden,do_nfop_ctra_att_pub,subject,authors,do_nfop_ctra_dir,a_content_type,r_lock_owner,owner_name,group_name,r_modifier,a_special_app,i_retainer_id,a_publish_formats,a_effective_date,a_expiration_date,keywordds,r_alias_set_id,r_current_state,r_is_virtual_doc,a_is_signed,i_is_replica,a_effective_label,r_lock_machine,a_full_text,r_link_cnt,r_resume_state,r_is_public,a_is_template,r_has_events,a_effective_flag,r_version_label,owner_permit,world_permit,i_is_reference,i_direct_dsc,a_link_resolved,version_label,r_lock_owner,group_permit,do_nfop_ctra_pers,i_latest_flag,r_has_frzn_assembly,owner_name,acl_name,keywords,a_controlling_app,a_category,a_extended_properties,r_aspect_name,controlling_app,r_creator_name,language_code,category_name,i_branch_cnt,item_type,log_entry,r_object_type,type' 
		casevisible='false' 
		width="200" 
		valuewidth="280" 
		logicaloperatorpos="newline">
		</dmfxs:searchattributegroup>
	</td>
</tr>
<tr><td colspan='2' class='spacer' height='<%=spacerHeight%>'>&nbsp;</td></tr>
<tr>
<td scope='row' class="rightAlignment" valign=top nowrap><dmf:label nlsid='MSG_DATE' cssclass="fieldlabel"/></td>
<td class="leftAlignment" valign=top nowrap>
<dmfxs:searchattributegroup name='datesearchcriteria' tooltipnlsid="MSG_DATE_TIP" excludetypes='number,id,string,boolean' defaultattribute="r_modify_date" addvisible='false' width='<%=SearchAttribute.DEFAULT_FIELD_WIDTH%>'>
<dmfxs:searchdateattribute name='dateattributes' valuespos="right" size="10">
</dmfxs:searchdateattribute>
</dmfxs:searchattributegroup>
</td>
</tr>
<tr><td colspan='2' class='spacer' height='<%=hrSpacerHeight%>'>&nbsp;</td></tr>
<tr>
<td colspan="2">
<!-- customizacion: quitamos hr -->
<!-- <hr style="color: #808080;background-color: #808080;height: 1px;border: 0;"> -->
</td>
</tr>
<tr><td colspan='2' class='spacer' height='<%=hrSpacerHeight%>'>&nbsp;</td></tr>
<dmf:panel name='contentsizepanel'>
<tr>
<td scope='row' class="rightAlignment" valign=top nowrap><dmf:label nlsid='MSG_SIZE' cssclass="fieldlabel"/></td>
<td class="leftAlignment" valign=top nowrap>
<%
%>
<dmfxs:searchsizeattribute name='contentsizeattr' removable='false' width='<%=SearchAttribute.DEFAULT_FIELD_WIDTH%>'>
</dmfxs:searchsizeattribute>
</td>
</tr>
</dmf:panel>
<dmf:panel name='additionalpanel'>
<tr>
<td colspan='2' class='spacer' height='<%=spacerHeight%>'>&nbsp;</td>
</tr>
<!-- customizacion: display none -->
<tr style="display:none">
	<td scope='row' class="rightAlignment" valign=top nowrap>
		<dmf:label nlsid='MSG_ADDTIONAL' cssclass="fieldlabel"/>
	</td>
	<td class="leftAlignment" valign=top nowrap>
		<table class="leftAlignment" valign=top border=0 cellpadding=0 cellspacing=0>
			<tr class="leftAlignment" valign=top>
				<td class="leftAlignment" valign=top nowrap>
					<dmfxs:searchscopecheckbox name='findhiddencheck' scopename='<%=RepositorySearch.SCOPE_FIND_HIDDEN%>' checkedvalue='true' uncheckedvalue='false' nlsid='MSG_FIND_HIDDEN' tooltipnlsid="MSG_FIND_HIDDEN" prefixassociatedlabelnlsid="MSG_ADDTIONAL"/>
				</td>
			</tr>
			<dmf:panel name='findversionpanel'>
				<tr class="leftAlignment" valign=top>
					<td class="leftAlignment" valign=top nowrap>
						<dmfxs:searchscopecheckbox name='findversioncheck' scopename='<%=RepositorySearch.SCOPE_FIND_ALL_VERSIONS%>' checkedvalue='true' uncheckedvalue='false' nlsid='MSG_FIND_VERSIONS' tooltipnlsid="MSG_FIND_VERSIONS" prefixassociatedlabelnlsid="MSG_ADDTIONAL"/>
					</td>
				</tr>
			</dmf:panel>
		</table>
	</td>
</tr>
</dmf:panel>
</table>
</dmfxs:repositorysearch>
<dmf:panel name='searchbtnpanel'>
<br>
<table>
<tr>
<td>
<table class="leftAlignment" cellspacing='4' cellpadding='0' border='0'>
<tr><td>
<dmf:button onclick='onClickHelp' nlsid='MSG_HELP' runatclient='true' src="icons/help.gif" cssclass="helpImage"/>
</td></tr>
</table>
</td>
<td>
<table class="rightAlignment" cellspacing='4' cellpadding='0' border='0'>
<tr>
<td>
<dmf:button name='submitsearch' cssclass='buttonLink' nlsid='MSG_SEARCH' onclick="onClickSearch" height='16' default='true' tooltipnlsid="MSG_SEARCH_TIP" />
</td>
<td width=5>
</td>
<td>
<dmf:button name='clearsearch' cssclass='buttonLink' nlsid='MSG_CLEAR' onclick="onClickClear" height='16' tooltipnlsid="MSG_CLEAR_TIP"/>
</td>
<td width=5>
</td>
<dmf:panel name='closepanel'>
<td>
<dmf:button name='cancelsearch' cssclass='buttonLink' nlsid='MSG_CLOSE' onclick="onCloseSearch" height='16' tooltipnlsid="MSG_CLOSE_TIP"/>
</td>
<td width=5>
</td>
</dmf:panel>
</tr>
</table>
</td>
</tr>
</table>
</dmf:panel>
</dmf:form>
</dmf:body>
</dmf:html>
