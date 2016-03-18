package com.sepe.nfo.components;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.documentum.fc.client.IDfACL;
import com.documentum.fc.client.IDfCollection;
import com.documentum.fc.client.IDfDocument;
import com.documentum.fc.client.IDfFolder;
import com.documentum.fc.client.IDfQuery;
import com.documentum.fc.client.IDfSysObject;
import com.documentum.fc.common.DfException;
import com.documentum.fc.common.DfId;
import com.documentum.fc.common.DfLogger;
import com.documentum.web.common.ArgumentList;
import com.documentum.web.common.SessionState;
import com.documentum.web.form.Control;
import com.documentum.web.form.Form;
import com.documentum.web.form.IReturnListener;
import com.documentum.web.form.control.Button;
import com.documentum.web.form.control.Link;
import com.documentum.web.form.control.Tab;
import com.documentum.web.form.control.databound.Datagrid;
import com.documentum.web.form.control.databound.TableResultSet;
import com.documentum.web.formext.component.Prompt;
import com.documentum.web.formext.config.ConfigService;
import com.documentum.web.formext.control.docbase.DocbaseAttributeValue;
import com.documentum.web.formext.control.docbase.DocbaseObject;
import com.documentum.web.formext.control.docbase.FindDirtyAttributeValue;
import com.documentum.web.util.DfcUtils;
import com.documentum.webcomponent.library.attributes.Attributes;
import com.sepe.nfo.utils.Utils;

public class MyAttributes extends Attributes implements IReturnListener {

	private static final long serialVersionUID = 1L;
	private List<String> mIdiomasAttributeValue = null;
	private List<String> mClasesAEAttributeValue = null;
	private List<String> mOfimaticaAttributeValue = null;
	private String mObjectId = null;
	private String[] m_docsdatagridcolumns = new String[] { "object_name", "r_object_id", "r_content_size", "formato", "url" };
	private String m_objectIdToDelete;
	
	@Override
	public void onInit(ArgumentList args) 
	{
		super.onInit(args);
		//guardamos el componente en sesion para poder usarlo en el componente CapacidadesIdiomasDocbaseRepeatingAttribute
		SessionState.setAttribute("myattributescomp", this);

		mObjectId = args.get("objectId");
		refreshDocsDataGrid();
	}

	/** DIFERENCIAS **/
	public void launchMyDiferencias(Link l, ArgumentList arg)
	{
		setComponentPage("diferencias");
	}

	public void onOKDiferencias(Button b, ArgumentList arg)
	{
		setComponentPage("start");
	}
	
	public void onCancelDiferencias(Button b, ArgumentList arg)
	{
		//TODO: limpiar todos los controles de atributos de la pagina para cancelar cambios:
		//((DocbaseAttributeValue)getControl("subject",DocbaseAttributeValue.class)).clearDirty();
		setComponentPage("start");
	}
	
	/** COBERTURA **/
	public void launchMyCobertura(Link l, ArgumentList arg)
	{
		setComponentPage("cobertura");
	}

	public void onOKCobertura(Button b, ArgumentList arg)
	{
		setComponentPage("start");
	}
	
	public void onCancelCobertura(Button b, ArgumentList arg)
	{
		//TODO: limpiar todos los controles de atributos de la pagina para cancelar cambios:
		//((DocbaseAttributeValue)getControl("subject",DocbaseAttributeValue.class)).clearDirty();
		setComponentPage("start");
	}

	
	/** IDIOMAS **/
	public void launchEditarIdiomas(Link l, ArgumentList arg)
	{
		setComponentPage("editaridiomas");
	}
	
	public void onOKEditarIdiomas(Button b, ArgumentList arg)
	{
		setComponentPage("tab2");
	}
	
	public void onCancelEditarIdiomas(Button b, ArgumentList arg)
	{
		setComponentPage("tab2");
	}

	/*** OFITI **/
	public void launchEditarOfiTI(Link l, ArgumentList arg)
	{
		setComponentPage("editarofiti");
	}
	
	public void onOKEditarOfiTI(Button b, ArgumentList arg)
	{
		setComponentPage("tab2");
	}
	
	public void onCancelEditarOfiTI(Button b, ArgumentList arg)
	{
		setComponentPage("tab2");
	}
	
	/*** TITULACIONES **/
	public void launchEditarTitulaciones(Link l, ArgumentList arg)
	{
		setComponentPage("editartitulaciones");
	}
	
	public void onOKEditarTitulaciones(Button b, ArgumentList arg)
	{
		setComponentPage("tab4");
	}
	
	public void onCancelEditarTitulaciones(Button b, ArgumentList arg)
	{
		setComponentPage("tab4");
	}
	
	/*** CERTIFICADOS ***/
	public void launchEditarCertificados(Link l, ArgumentList arg)
	{
		setComponentPage("editarcertificados");
	}
	
	public void onOKEditarCertificados(Button b, ArgumentList arg)
	{
		setComponentPage("tab3");
	}
	
	public void onCancelEditarCertificados(Button b, ArgumentList arg)
	{
		setComponentPage("tab3");
	}
	
	
	/*********************************************************************/
	
	public void setIdiomasAttributeValue(List<String> list)
	{
		mIdiomasAttributeValue  = list;
	}
	
	public List<String> getIdiomasAttributeValue() throws DfException
	{
		if (mIdiomasAttributeValue !=null)
			return mIdiomasAttributeValue;
		else
		{
			DocbaseObject docbaseobj = (DocbaseObject) getControl("obj",DocbaseObject.class);
			int size = docbaseobj.getDfObject().getValueCount("do_nfop_ctra_idioma");
			List<String> ret = new ArrayList<String>();
			for (int i=0;i<size;i++)
			{
				ret.add(docbaseobj.getDfObject().getRepeatingString("do_nfop_ctra_idioma", i));
			}
			return ret;
		}
	}
	
	public void setClasesAEAttributeValue(List<String> list) 
	{
		mClasesAEAttributeValue = list;
	}
	
	public List<String> getClasesAEAttributeValue() throws DfException
	{
		if (mClasesAEAttributeValue !=null)
			return mClasesAEAttributeValue;
		else
		{
			DocbaseObject docbaseobj = (DocbaseObject) getControl("obj",DocbaseObject.class);
			int size = docbaseobj.getDfObject().getValueCount("do_nfop_aer_titulaciones");
			List<String> ret = new ArrayList<String>();
			for (int i=0;i<size;i++)
			{
				ret.add(docbaseobj.getDfObject().getRepeatingString("do_nfop_aer_titulaciones", i));
			}
			return ret;
		}
	}
	
	public List<String> getOfimaticaAttributeValue() throws DfException
	{
		if (mOfimaticaAttributeValue !=null)
			return mOfimaticaAttributeValue;
		else
		{
			DocbaseObject docbaseobj = (DocbaseObject) getControl("obj",DocbaseObject.class);
			int size = docbaseobj.getDfObject().getValueCount("do_nfop_ctra_ofiti");
			List<String> ret = new ArrayList<String>();
			for (int i=0;i<size;i++)
			{
				ret.add(docbaseobj.getDfObject().getRepeatingString("do_nfop_ctra_ofiti", i));
			}
			return ret;
		}
	}
	
	/*********************************************************************/

	public void onClickTab(Tab t,ArgumentList arg)
	{
		if (t.getName().equalsIgnoreCase("tab1"))
			setComponentPage("start");
		else
			setComponentPage(t.getName());
	}
	
	@Deprecated
	public String[] getCompetenciasParaIdioma(String idioma,String attname)
	{
		String value = findDirtyAttributeValue(idioma,"????");
		if (value != null)
		{
			//El valor ha cambiado, se ha editado el idioma.
			//El vector devuelto tiene que tener 5 posiciones.
			String ret[] = new String[]{"-","-","-","-","-"};
			String values[] = value.split(",");
			for (int i=0;i<values.length;i++)
			{	
				if (i == 5) break;
				String s = values[i].trim().equals("")?"-":values[i];
				ret[i] = s;
			}
			return ret;
		}
		else
		{
			//El idioma no se ha editado, por lo que sacamos los valores de la BBDD: 
			DocbaseObject dobj = (DocbaseObject)getControl("obj",DocbaseObject.class);
			String c1="-",c2="-",c3="-",c4="-",c5="-";
			try{c1 = 	dobj.getDfObject().getRepeatingString(attname,0);}catch(DfException e){}
			try{c2 = 	dobj.getDfObject().getRepeatingString(attname,1);}catch(DfException e){}
			try{c3 = 	dobj.getDfObject().getRepeatingString(attname,2);}catch(DfException e){}
			try{c4 = 	dobj.getDfObject().getRepeatingString(attname,3);}catch(DfException e){}
			try{c5 = 	dobj.getDfObject().getRepeatingString(attname,4);}catch(DfException e){}
			c1 = c1==null?"-":c1;c2 = c2==null?"-":c2;c3 = c3==null?"-":c3;c4 = c4==null?"-":c4;c5 = c5==null?"-":c5;
			return new String[]{c1,c2,c3,c4,c5};
		}
	}
	
	public String[] getRepeatingValue(String attname) throws DfException
	{
		return getRepeatingValue(attname,",");
	}
	
	public String[] getRepeatingValue(String attname,String separator) throws DfException
	{
		String values = findDirtyAttributeValue(attname,separator);
		if (values != null)
			return values.split(separator);
		else
		{
			//El atributo no se ha editado, por lo que sacamos los valores de la BBDD: 
			DocbaseObject dobj = (DocbaseObject)getControl("obj",DocbaseObject.class);
			return dobj.getDfObject().getAllRepeatingStrings(attname, separator).split(separator);
		}
	}
	
	public String[] getURLsFromTitulos(String[] titulos)
	{
		String url[] = new String[titulos.length];
		for (int i=0;i<titulos.length;i++)
		{
			String t = titulos[i];
			try 
			{
				IDfSysObject cert = (IDfSysObject)getDfSession().getObjectByQualification("do_nfop_lv_cert_prof WHERE titulo = '" + t + "'");
				if (cert == null) continue;
				url[i] = cert.getString("url");
			} 
			catch (DfException e) 
			{
				url[i] = "<error al recuperar la url del certificado";
			}
		}
		return url;
	}
	
	//Si el control docbaseattributevalue indicado ha sido editado, devolvemos el nuevo valor,
	//de lo contrario devolvemos null
	private String findDirtyAttributeValue(String docbaseattributevaluecontrolname,String separator)
	{
		FindDirtyAttributeValue f = new FindDirtyAttributeValue("obj");
		this.visitDepthFirst(f);
		Iterator<DocbaseAttributeValue> it = f.getAttributeValues();
		while (it.hasNext())
		{
			DocbaseAttributeValue value = it.next();
			if (value.getName().equalsIgnoreCase(docbaseattributevaluecontrolname))
			{
				if (value.isRepeating())
				{
					return this.vectoToSeparatedString(value.getValues(), separator);
				}
				else
					return value.getValue();
			}
		}
		return null;
	}
	
	@Deprecated
	private int getValuePosition(String repeatingvalue,String findme,String separatedBy)
	{
		if (separatedBy == null) separatedBy = ",";
		String[] s = repeatingvalue.split(separatedBy);
		for (int i=0;i<s.length;i++)
		{
			if (s[i].equalsIgnoreCase(findme)) return i;
		}
		return -1;
	}
	
	public String[] paddArray(String[] array, int lenght,String padchar)
	{
		if (array == null) array = new String[]{padchar};
		
		String ret[] = new String[lenght];
		for (int i=0;i<ret.length;i++)
		{
			ret[i] = padchar;
		}
		
		for (int i=0;i<array.length;i++)
		{	
			if (i == lenght) break;
			String s = array[i].trim().equals("")?"-":array[i];
			ret[i] = s;
		}
		return ret;
	}
	
	public String pad(String s, int max,String padchar)
	{
	  StringBuffer padded = new StringBuffer(s);
	  while (padded.length() < max)
	    padded.append(padchar);
	  return padded.toString();
	}
	
	private String vectoToSeparatedString(Vector<String> v, String separator)
	{
		Iterator<String> values = v.iterator();
		StringBuffer ret = new StringBuffer();
		int count = 1;
		while (values.hasNext())
		{	if (count>1)
				ret.append(separator + values.next());
			else
				ret.append(values.next());
			count++;
		}
		return ret.toString();
	}
	/************************************************************************************************/
	/**
	 * Este método es llamado por el link de agregar fichero. Invoca al componente invesdocimportfile.
	 * @throws DfException 
	 */
	public void onAddFile(Control ctrl, ArgumentList arg) throws DfException
	{
		ArgumentList a = new ArgumentList();
		a.add("objectId",mObjectId);
		a.add("component", ImportFileComponent.COMPONENT_NAME);
		String folderName = getDfSession().getObject(new DfId(mObjectId)).getString("object_name");
		a.add("foldername", folderName);
		setComponentNested("dialogcontainer", a,getContext(), this);
	}
	
	/**
	 * Evento lanzado al pulsar en el link "borrar" del datagrid de la pestaña de Documentos
	 */
	public void onClickDeleteFile(Link c, ArgumentList a)
	{
		setFileIdToDelete(a.get("objectId"));

		ArgumentList args = new ArgumentList();
		args.add(Prompt.ARG_TITLE, "¿Confirma que desea borrar el fichero?");
		args.add(Prompt.ARG_MESSAGE,"¿Confirma que desea borrar el fichero?");
		args.add(Prompt.ARG_ICON, Prompt.ICON_WARNING);
		args.add(Prompt.ARG_BUTTON, new String[] { Prompt.OK, Prompt.CANCEL });
		setComponentNested("prompt", args, getContext(), this);
	}
	
	/**
	 * Este método rellena el datagrid de ficheros de la pestaña Documentos. Es public porque es invocado también desde el componente invesdocimportfile.
	 */
	public void initDocsDataGrid(Datagrid datagrid, String folderId, boolean _throw, boolean _completePath) throws DfException
	{
		TableResultSet resultSet = new TableResultSet(m_docsdatagridcolumns);

		if (folderId == null)
			folderId = mObjectId;

		String rootFolderPath = ((IDfFolder) getDfSession().getObject(new DfId(folderId))).getFolderPath(0);

		if (rootFolderPath == null)
			return;

		IDfCollection col = null;
		try
		{
			StringBuffer buf = new StringBuffer(256);
			buf.append("select title,object_name,r_object_id,a_content_type,r_content_size from dm_document where folder('");
			buf.append(rootFolderPath.replace("'", "''") + "',descend)");

			IDfQuery query = DfcUtils.getClientX().getQuery();
			query.setDQL(buf.toString());
			col = query.execute(getDfSession(), IDfQuery.READ_QUERY);
			while (col.next())
			{
				String formato = Utils.getDosExtensionFromContentType(col.getString("a_content_type"));
				String objectName = null;
				objectName = col.getString("object_name");

				String objectId = col.getString("r_object_id");
				IDfDocument cObj = ((IDfDocument) getDfSession().getObject(new DfId(objectId)));
				String cObjFolderPath = ((IDfFolder) getDfSession().getObject(cObj.getFolderId(0))).getFolderPath(0);
				if (cObjFolderPath.startsWith(rootFolderPath))
					cObjFolderPath = cObjFolderPath.substring(rootFolderPath.length());

				if (_completePath)
					objectName = cObjFolderPath + "/" + objectName;

				double contentSizeBytes = new Double(col.getString("r_content_size"));
				double contentSizeKBytes = contentSizeBytes / 1024;
				int contentSizeKBytesInt = (new Double(contentSizeKBytes)).intValue() + 1;

				// 08-03-2011: añadimos el campo URL:
				String url = ConfigService.getConfigLookup().lookupString("application.docsurlbase", this.getContext()) + objectId;
				resultSet.add(new String[] { objectName, objectId, (new Integer(contentSizeKBytesInt)).toString() + " KB", formato, url });
			}

			datagrid.getDataProvider().setDfSession(getDfSession());
			datagrid.getDataProvider().setResultSet(resultSet, null);

		}
		catch (DfException e)
		{
			if (_throw)
				throw e;
			else
				DfLogger.error(this, "error al poblar datagrid de docs:" + e.getMessage(), null, null);
		}
		finally
		{
			if (col != null)
				try
				{
					col.close();
				}
				catch (DfException e)
				{
					e.printStackTrace();
				}
		}
	}

	@Override
	public void onReturn(Form arg0, Map map) 
	{
		// VOLVEMOS DE PROMPT DE BORRAR DOCUMENTO
		if (map != null && map.get("button") != null && map.get("button").equals("ok"))
		{
			try
			{
				IDfSysObject sObj = (IDfSysObject) getDfSession().getObject(new DfId(getFileIdToDelete()));
				sObj.destroyAllVersions();
				refreshDocsDataGrid();
				return;
			}
			catch (DfException e)
			{
				DfLogger.error(this, "error al borrar el fichero",null,null);
			}
		}
		
		if (map != null && map.get(ImportFileComponent.RETURN_COMPONENT_VALUE) != null)
			refreshDocsDataGrid();
	}
	
	private void refreshDocsDataGrid()
	{
		try
		{
			String folderId = mObjectId;
			initDocsDataGrid(((Datagrid) getControl("dgrDocsList", Datagrid.class)), folderId, false, true);
		}
		catch (DfException e)
		{
			DfLogger.error(this, "error al refrescar datagrid de docs:" + e.getMessage(), null, null);
		}
	}
	
	protected String getFileIdToDelete()
	{
		return m_objectIdToDelete;
	}

	public void setFileIdToDelete(String _objectId)
	{
		m_objectIdToDelete = _objectId;
	}

	public void setOfimaticaAttributeValue(List<String> data)
	{
		mOfimaticaAttributeValue = data;		
	}

	@Override
	public boolean onCommitChanges() 
	{

		boolean b = super.onCommitChanges();
		if (b == false) return false;
		
		//le damos permiso de escritura a los administradores, para que puedan modificar
		//y generar informes de fichas que han creado otros:
		DocbaseObject dobj = (DocbaseObject)getControl("obj",DocbaseObject.class);
		try
		{
			IDfACL miacl = getDfSession().getACL(dobj.getDfObject().getString("owner_name"),dobj.getDfObject().getString("acl_name"));
			miacl.grant("gr_nfo_admin", IDfACL.DF_PERMIT_DELETE, IDfACL.DF_XPERMIT_CHANGE_PERMIT_STR);
			miacl.save();
		}
		catch(DfException e)
		{
			//Ignoramos error DM_ACL_E_NOT_OWNER
			if (!e.getMessage().contains("[DM_ACL_E_NOT_OWNER]"))
				DfLogger.error(this,"error al cambiar la acl del objeto:" + e.getMessage(), null, null);
		}
		
		return b;
	}
}
