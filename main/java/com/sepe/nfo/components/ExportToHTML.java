
package com.sepe.nfo.components;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.documentum.web.common.AccessibilityService;
import com.documentum.web.common.ArgumentList;
import com.documentum.web.common.WrapperRuntimeException;
import com.documentum.web.common.reporting.ColumnInfo;
import com.documentum.web.common.reporting.ITableDataProvider;
import com.documentum.web.common.reporting.ITableRowsDataProvider;
import com.documentum.web.common.reporting.MetaData;
import com.documentum.web.contentxfer.ContentTransferConfig;
import com.documentum.web.contentxfer.http.HttpTransportManager;
import com.documentum.web.form.Form;
import com.documentum.web.form.control.multiselector.MultiSelector;
import com.sepe.nfo.utils.HTMLFormatter;

public class ExportToHTML extends com.documentum.webcomponent.library.exporttocsv.ExportToCsv
{
    public ExportToHTML()
    {
        m_tableDataProvider = null;
        m_tableRowsDataProvider = null;
        rowSelection = null;
    }

    public void onInit(ArgumentList arg)
    {
        super.onInit(arg);
        rowSelection = arg.get("selection");
        Form caller = getCallerForm();
        if(!(caller instanceof ITableDataProvider) && AccessibilityService.isAllAccessibilitiesEnabled() && caller != null && caller.getId().equalsIgnoreCase("menubar"))
            caller = caller.getCallerForm();
        if(!(caller instanceof ITableDataProvider))
            throw new WrapperRuntimeException("Caller component does not support providing external data");
        if(rowSelection != null && !(caller instanceof ITableRowsDataProvider))
            throw new WrapperRuntimeException("Caller component does not support providing row selection as external data");
        m_tableDataProvider = (ITableDataProvider)caller;
        m_tableRowsDataProvider = (ITableRowsDataProvider)caller;
        MetaData metaData = m_tableDataProvider.getMetaData();
        List colInfoList = metaData.getAllColumnInfo();
        MultiSelector colSelectorCtrl = (MultiSelector)getControl("ctrlColSelector", com.documentum.web.form.control.multiselector.MultiSelector.class);
        colSelectorCtrl.setSize("10");
        List lstItems = new ArrayList();
        for(int i = 0; i < colInfoList.size(); i++)
        {
            ColumnInfo colInfo = (ColumnInfo)colInfoList.get(i);
            String anItem[] = new String[2];
            anItem[0] = colInfo.getName();
            anItem[1] = colInfo.getLabel();
            lstItems.add(anItem);
        }

        colSelectorCtrl.setSelectedItems(lstItems);
    }
    
	
	public boolean onCommitChanges()
    {
        OutputStreamWriter writer = null;
        try
        {
            List columnNames;
            HTMLFormatter htmlFormatter;
            File tempFile;
            MultiSelector colSelectorCtrl = (MultiSelector)getControl("ctrlColSelector", com.documentum.web.form.control.multiselector.MultiSelector.class);
            List selItemsList = colSelectorCtrl.getSelectedItems();
            columnNames = new ArrayList();
            String item[];
            for(Iterator i$ = selItemsList.iterator(); i$.hasNext(); columnNames.add(item[0]))
                item = (String[])i$.next();

            htmlFormatter = new HTMLFormatter(m_tableDataProvider, m_tableRowsDataProvider);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy'.'MM'.'dd'-'HHmm'h.'ss's'");
            String timestamp = sdf.format(new Date());
            ContentTransferConfig ctConfig = ContentTransferConfig.getConfig();
            File tempFolderAppServer = ctConfig.getServerContentLocation();
            tempFile = File.createTempFile((new StringBuilder()).append("mytemphtml_").append(timestamp).append(".html").toString(), "", tempFolderAppServer);
            FileOutputStream fileOutputStream = new FileOutputStream(tempFile);
            String charEncoding = lookupString("characterencoding");
            if(charEncoding == null || charEncoding.trim().length() == 0)
                charEncoding = "UTF-8";
            writer = new OutputStreamWriter(fileOutputStream, charEncoding);
            if(rowSelection == null)
            	htmlFormatter.save(writer, columnNames, charEncoding);
            else
            	htmlFormatter.save(writer, columnNames, charEncoding, rowSelection);
            HttpTransportManager manager = HttpTransportManager.getManager();
            List ids = new ArrayList(1);
            com.documentum.web.contentxfer.http.HttpTransportManager.Content content = new com.documentum.web.contentxfer.http.HttpTransportManager.Content(tempFile, (new StringBuilder()).append(getString("MSG_FILENAME")).append(".html").toString(), "text/html", tempFile.getParent(), 2);
            ids.add(manager.addOutgoing(content));
            String contextPath = ((HttpServletRequest)getPageContext().getRequest()).getContextPath();
            manager.setClientDownloadEvent(ids, getTopForm(), contextPath);
            tempFile.deleteOnExit();
            return true;
        }
        catch(IOException ioe)
        {
        	throw new WrapperRuntimeException("Error creando html file.", ioe);
        }
        finally
        {
        	if (writer != null)
				try {writer.close();} catch (IOException e) {throw new WrapperRuntimeException("Error cerrando html file");}
        }
    }

    public static final String CTRL_COL_SELECTOR = "ctrlColSelector";
    private static final String MIME_TYPE = "text/csv";
    private static final String FILE_EXTENSION = ".csv";
    private static final String DEFAULT_CHAR_ENCODING = "UTF-8";
    private ITableDataProvider m_tableDataProvider;
    private ITableRowsDataProvider m_tableRowsDataProvider;
    private String rowSelection;

}