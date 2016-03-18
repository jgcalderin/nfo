package com.sepe.nfo.components;

import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.documentum.fc.client.IDfSysObject;
import com.documentum.fc.common.DfException;
import com.documentum.fc.common.DfId;
import com.documentum.web.common.AccessibilityService;
import com.documentum.web.common.ArgumentList;
import com.documentum.web.common.WrapperRuntimeException;
import com.documentum.web.common.reporting.ITableDataProvider;
import com.documentum.web.common.reporting.ITableRowsDataProvider;
import com.documentum.web.common.reporting.Row;
import com.documentum.web.form.Form;
import com.documentum.web.formext.component.Component;
import com.sepe.nfo.utils.ReportUtils;

/**
 * Esta es la clase que genera el Informe Completo
 *
 */
public class InformeCompleto extends Component 
{
	private static final long serialVersionUID = 1L;
	
	public static final String CTRL_COL_SELECTOR = "ctrlColSelector";
    private static final String MIME_TYPE = "application/pdf";
    private static final String FILE_EXTENSION = ".pdf";
    private static final String DEFAULT_CHAR_ENCODING = "UTF-8";
    //TODO: esta plantilla esta pendiente de hacer
    private static final String REPORT_TEMPLATE_PATH = "/inem/sappweb/genDocs/apps/disw/nfo/plantillas/plantilla.jasper";
    private ITableDataProvider m_tableDataProvider;
    private ITableRowsDataProvider m_tableRowsDataProvider;
    private String rowSelection;
    List<IDfSysObject> misfichas = new ArrayList<IDfSysObject>();
    
	public InformeCompleto()
    {
        m_tableDataProvider = null;
        m_tableRowsDataProvider = null;
        rowSelection = null;
    }
    
	@Override
	public void onInit(ArgumentList arg) 
	{
        super.onInit(arg);
        rowSelection = arg.get("selection");
        Form caller = getCallerForm();
        if(!(caller instanceof ITableDataProvider) && AccessibilityService.isAllAccessibilitiesEnabled() && caller != null && caller.getId().equalsIgnoreCase("menubar"))
        {
            caller = caller.getCallerForm();
        }
        if(!(caller instanceof ITableDataProvider))
        {
            throw new WrapperRuntimeException("Caller component does not support providing external data");
        }
        if(rowSelection != null && !(caller instanceof ITableRowsDataProvider))
        {
            throw new WrapperRuntimeException("Caller component does not support providing row selection as external data");
        }
        
        m_tableDataProvider = (ITableDataProvider)caller;
        m_tableRowsDataProvider = (ITableRowsDataProvider)caller;
        
        /*** TODO ESTO NO HACE FALTA - START **/

        /**
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
        **/
        
        /*** TODO ESTO NO HACE FALTA - END **/

        List<String> columnas = new ArrayList<String>();
        columnas.add("r_object_id");
        		
        Iterator<Row> rows = null;
        if(rowSelection == null)
            rows = m_tableDataProvider.rowIterator(columnas);        	
        else
            rows = m_tableRowsDataProvider.rowIterator(columnas,rowSelection);
	
        try
        {
            while (rows.hasNext())
            {
            	Row row = rows.next();
            	String objectid = row.getCell("r_object_id").getValue().toString();
            	IDfSysObject mificha = (IDfSysObject) getDfSession().getObject(new DfId(objectid));
            	misfichas.add(mificha);
            }
        }
        catch(DfException e)
        {
            throw new WrapperRuntimeException("Error al generar informe completo:" + e.getMessage());
        }
	}

    public boolean onCommitChanges()
    {
		URL jasperResURL = this.getClass().getResource(REPORT_TEMPLATE_PATH);
        try
        {
    		//Generamos el informe:
        	byte[] informe = ReportUtils.generateReport(misfichas, jasperResURL);
        	//Lo visualizamos:
        	ReportUtils.viewReport(informe, this, DEFAULT_CHAR_ENCODING);
        	return true;
        }
        catch(Exception e)
        {
            throw new WrapperRuntimeException("Error al generar informe completo:" + e.getMessage());
        }
    }
}
