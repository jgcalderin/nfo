package com.sepe.nfo.components;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import net.sf.jasperreports.engine.JRException;

import org.apache.pdfbox.exceptions.COSVisitorException;
import org.apache.pdfbox.util.PDFMergerUtility;

import com.documentum.fc.client.DfQuery;
import com.documentum.fc.client.IDfCollection;
import com.documentum.fc.client.IDfQuery;
import com.documentum.fc.client.IDfSysObject;
import com.documentum.fc.common.DfException;
import com.documentum.fc.common.DfId;
import com.documentum.fc.common.DfLogger;
import com.documentum.web.common.ArgumentList;
import com.documentum.web.form.Control;
import com.documentum.web.form.Form;
import com.documentum.web.form.IControlListener;
import com.documentum.web.form.control.Button;
import com.documentum.web.form.control.Label;
import com.documentum.web.formext.component.Component;
import com.sepe.nfo.utils.ReportUtils;

/**
 * Esta es la clase que genera el Informe de Necesidades
 *
 */
public class InformeNecesidades extends Component implements IControlListener
{

	private static final long serialVersionUID = 1L;
	private IDfSysObject miFicha;
	private String message = "Generando informe....";
	private String ultimoInformeObjectId = null;
	private boolean buttonvisible = true;
    private static final String REPORT_TEMPLATE_PATH = "/inem/sappweb/genDocs/apps/disw/nfo/plantillas/plantilla.jasper";

	public String getInformeObjectId() 
	{
		return ultimoInformeObjectId;
	}

	@Override
	public void onInit(ArgumentList args) 
	{
		addControlListener(this);
		super.onInit(args);
		
		try 
		{
			miFicha = (IDfSysObject) getDfSession().getObject(new DfId(args.get("objectId")));
			ByteArrayOutputStream informe = generateReport(miFicha);
			ultimoInformeObjectId = guardarInforme(informe);
			message = "Se ha generado el informe correctamente. ¿Desea visualizarlo?";
			Button b = (Button)getControl("visualizar",Button.class);
			b.setVisible(true);//no funciona
		} 
		catch (JRException e) 
		{
			DfLogger.error(this, e.getMessage(), null,null);
			message = "Error al generar el informe: " + e.getMessage();
			buttonvisible = false;
		} catch (IOException e) 
		{
			DfLogger.error(this, e.getMessage(), null,null);
			message = "Error al generar el informe: " + e.getMessage();
			buttonvisible = false;
		} 
		catch (DfException e) 
		{
			if (e.getMessage().contains("DM_SYSOBJECT_E_LINK_PERMIT2"))
			{
				message = "No tiene permisos para generar el informe de esta ficha";
				DfLogger.error(this, e.getMessage(), null,null);
			}
			buttonvisible = false;
		} catch (COSVisitorException e) 
		{
			DfLogger.error(this, e.getMessage(), null,null);
			message = "Error al generar el informe: " + e.getMessage();
			buttonvisible = false;
		}		
	}

	private String guardarInforme(ByteArrayOutputStream informe) throws DfException
	{
		//Guardamos el informe. Si existe uno ya, lo borramos y lo generamos de nuevo:
		IDfSysObject sobj = (IDfSysObject) getDfSession().getObjectByQualification(
				"dm_document where object_name='informe.pdf' and folder(ID('" + miFicha.getObjectId().toString() + "'))");
		if (sobj != null)
		{
			try
			{
				sobj.destroy();
			}
			catch(DfException e)
			{
				DfLogger.error(this,"error al borrar informe de " + miFicha.getObjectName() + ": " + e.getMessage(), null, null);
			}
		}
		IDfSysObject informeObj = (IDfSysObject) getDfSession().newObject("dm_document");
		informeObj.setContentType("pdf");
		informeObj.link(miFicha.getObjectId().toString());
		informeObj.setContent(informe);
		informeObj.setObjectName("informe.pdf");
		informeObj.save();
		return informeObj.getObjectId().toString();
	}
	
	public ByteArrayOutputStream generateReport(IDfSysObject miFicha) throws JRException, IOException, DfException, COSVisitorException 
	{
		
		List<IDfSysObject> misfichas = new ArrayList<IDfSysObject>();
		URL jasperResURL = this.getClass().getResource(REPORT_TEMPLATE_PATH);
		
		ByteArrayOutputStream bous = new ByteArrayOutputStream();
		misfichas.add(miFicha);
		byte[] informe = ReportUtils.generateReport(misfichas, jasperResURL);
		mergePDF(informe,bous); //le anyadimos el documento de mejor situacion
		return bous;		
	}
	
	private void mergePDF(byte[] pdf1, ByteArrayOutputStream bous) throws COSVisitorException, IOException, DfException
	{
		PDFMergerUtility ut = new PDFMergerUtility();
		ut.addSource(new ByteArrayInputStream(pdf1));
		ByteArrayInputStream pdfmejorSituacion = getPDFMejorSituacion();
		if (pdfmejorSituacion != null)
			ut.addSource(pdfmejorSituacion);
		ut.setDestinationStream(bous);
		ut.mergeDocuments();
	}
		
	private ByteArrayInputStream getPDFMejorSituacion() throws DfException
	{
		String docObjectId = null;
		IDfQuery dfQuery = new DfQuery();
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT r_object_id FROM dm_document ");
		sb.append("WHERE FOLDER(ID('" + miFicha.getObjectId() + "')) ");
		sb.append("AND subject = '" + ImportFileComponent.DOCUMENTO_MEJOR_SITUACION_FLAG + "'");
		dfQuery.setDQL(sb.toString());
		IDfCollection col = dfQuery.execute(getDfSession(), IDfQuery.DF_QUERY);
		try
		{
			if (col.next())
				docObjectId = col.getString("r_object_id");
			col.close();
			if (docObjectId != null)
			{
				IDfSysObject midocumento = (IDfSysObject) getDfSession().getObject(new DfId(docObjectId));
				return midocumento.getContent();				
			}
			return null;
		}
		catch (DfException e)
		{
			throw e;
		}
	}

	@Override
	public void onControlInitialized(Form arg0, Control c) 
	{
		if (c != null && c.getName() != null && c.getName().equalsIgnoreCase("lblmsg"))
		{
			Label l = (Label)c;
			l.setLabel(message);
		}
		else if (c != null && c.getName() != null && c.getName().equalsIgnoreCase("visualizar"))
		{
			Button b = (Button)c;
			b.setVisible(buttonvisible);
		}
	}
}
