package com.sepe.nfo.components;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import com.documentum.fc.client.IDfSysObject;
import com.documentum.fc.common.DfException;
import com.documentum.fc.common.DfId;
import com.documentum.fc.common.DfLogger;
import com.documentum.web.common.ArgumentList;
import com.documentum.web.common.SessionState;
import com.documentum.web.form.control.Button;
import com.documentum.web.form.control.Checkbox;
import com.documentum.web.form.control.FileBrowse;
import com.documentum.web.form.control.Label;
import com.documentum.web.form.control.Text;
import com.documentum.web.form.control.databound.Datagrid;
import com.documentum.web.formext.action.ActionService;
import com.documentum.web.formext.action.CallbackDoneListener;
import com.documentum.web.formext.component.Component;
import com.documentum.webcomponent.library.contenttransfer.importcontent.ImportContentContainer;
import com.sepe.nfo.utils.StringFormatter;
import com.sepe.nfo.utils.Utils;

@SuppressWarnings("serial")
public class ImportFileComponent extends Component  
{
	private IDfSysObject m_folderObj = null;
	private MyAttributes m_callerAttComponent = null;
	public static final String COMPONENT_NAME = "nfoimportfile";
	private boolean m_keepLabelSaved = false;

	public static final String RETURN_COMPONENT_VALUE = "RETURN_COMPONENT_VALUE";
	public static final String DOCUMENTO_MEJOR_SITUACION_FLAG = "-DOCUMENTO_MEJOR_SITUACION-";

	public void onInit(ArgumentList a)
	{
		try
		{
			m_folderObj = (IDfSysObject) getDfSession().getObject(new DfId(a.get("objectId")));

			if (SessionState.getAttribute("myattributescomp") != null)
			{
				m_callerAttComponent = (MyAttributes) SessionState.getAttribute("myattributescomp");
				m_callerAttComponent.initDocsDataGrid(
						((Datagrid) getControl("dgrNewDocsList",Datagrid.class)), null, true, false);
			}
		}
		catch (DfException e)
		{
			DfLogger.error(this,e.getMessage(),null,null);
		}
	}

	/**
	 * En este metodo nos aseguramos de que los mensajes no se queden permanentemente en la pantalla, sino sólo después del primer refresco de pantalla.
	 */
	public void onRender()
	{
		super.onRender();
		do2();
	}

	private void refreshNewDocsDataGrid()
	{
		try
		{
			m_callerAttComponent.initDocsDataGrid(
					((Datagrid) getControl("dgrNewDocsList",
							Datagrid.class)), null, true, true);
		}
		catch (DfException e)
		{
			DfLogger.error(this,e.getMessage(),null,null);
		}
	}

	public void onUpLoadFile(Button b, ArgumentList a)
	{
		try
		{
			FileBrowse f = (FileBrowse) getControl("fselect", FileBrowse.class);
			String localFilePath = f.getValue();
			String extension = localFilePath.substring(localFilePath
					.lastIndexOf(".") + 1);
			String fileName = localFilePath.substring(localFilePath
					.lastIndexOf("\\") + 1);
			String txtName = ((Text) getControl("txtname", Text.class))
					.getValue();

			if (!txtName.trim().equalsIgnoreCase(""))
				fileName = txtName;

			File fileUploaded = f.getFile();
			if (localFilePath.trim().equalsIgnoreCase("")
					|| fileUploaded == null)
			{
				DfLogger.error(this, "fichero no seleccionado", null,null);
				return;
			}

			String contentType = Utils.getContentTypeFromDosExtension(extension);

			String folderId = m_folderObj.getObjectId().toString();

			IDfSysObject d = (IDfSysObject) getDfSession().newObject("dm_document");
			fileName = (new StringFormatter()).format(fileName,	StringFormatter.UNIX_FILE_NAME_FORMATTER);

			d.setObjectName(fileName);
			if (esDocumentoMejorSituacion())
				d.setSubject(DOCUMENTO_MEJOR_SITUACION_FLAG);

			d.setContentType(contentType);
			d.appendFile(fileUploaded.getAbsolutePath());
			d.link(folderId);
			d.save();

			f.setValue(""); // para borrar la etiqueta "cambiar"

			refreshNewDocsDataGrid();

			DfLogger.info(this, "fichero agregado", null,null);

			setReturnValue("RETURN_COMPONENT_VALUE", RETURN_COMPONENT_VALUE);

		}
		catch (DfException e)
		{
			DfLogger.error(this, e.getMessage(), null,null);
		}
	}

	private boolean esDocumentoMejorSituacion()
	{
		Checkbox chk = (Checkbox) getControl("chkmejorsituacion",Checkbox.class);
		return chk.getValue();
	}
	
	public void onImportFiles(Button b, ArgumentList a)
	{
		ArgumentList aa = new ArgumentList();
		try
		{
			aa.add("objectId", m_folderObj.getObjectId().toString());
			aa.add("docbaseType", "dm_document");
			aa.add("multiselect", "true");
			ActionService.execute("import", aa, getContext(), this,
					new CallbackDoneListener(this, "onReturnFromImport"));
		}
		catch (DfException e)
		{
			DfLogger.error(this, e.getMessage(), null,null);
		}
	}

	@SuppressWarnings("unchecked")
	public void onReturnFromImport(String strAction, boolean bSuccess, Map map)
			throws DfException
	{
		ArrayList hmNewObjectIds = (ArrayList) map
				.get(ImportContentContainer.NEW_OBJECT_IDS);
		if (hmNewObjectIds != null)
		{
			for (Iterator iter = hmNewObjectIds.iterator(); iter.hasNext();)
			{
				String objectId = (String) iter.next();
				IDfSysObject sObj = (IDfSysObject) getDfSession().getObject(
						new DfId(objectId));
				System.out.println("importado " + objectId + " en "
						+ sObj.getFolderId(0));
			}
		}
	}

	public void do1(Exception e)
	{
		m_keepLabelSaved = true; // ponemos esta variable a true para que el
		// mensaje no se borre en el metodo
		// onRender().
		if (e != null)
			e.printStackTrace();
	}

	public void do2()
	{
		Label l = getMsgLabel();
		if (m_keepLabelSaved)
		{
			m_keepLabelSaved = false;
		}
		else
			l.setVisible(false);
	}

	public Label getMsgLabel()
	{
		Label l = (Label) getControl("lblmsg");
		if (l == null)
		{
			l = (Label) getControl("lblmsg",Label.class);
		}
		return l;
	}
}
