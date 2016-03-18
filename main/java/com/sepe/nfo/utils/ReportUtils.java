package com.sepe.nfo.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanArrayDataSource;
import net.sf.jasperreports.engine.util.JRLoader;

import org.apache.pdfbox.exceptions.COSVisitorException;

import com.documentum.fc.client.IDfSysObject;
import com.documentum.fc.common.DfException;
import com.documentum.web.common.WrapperRuntimeException;
import com.documentum.web.contentxfer.ContentTransferConfig;
import com.documentum.web.contentxfer.http.HttpTransportManager;
import com.documentum.web.formext.component.Component;
import com.sepe.nfo.reports.data.MasterBean;
import com.sepe.nfo.reports.data.OcupacionBean;

public class ReportUtils {

	public static synchronized byte[] generateReport(List<IDfSysObject> misFichas,URL plantilla) throws JRException, IOException, DfException, COSVisitorException 
	{
		JasperPrint jasperPrint = null;
		
		OcupacionBean[] ocupacionbeans = new OcupacionBean[misFichas.size()]; 
		for (int i=0;i<misFichas.size();i++)
		{
			IDfSysObject miFicha = misFichas.get(i);
			MasterBean masterbean = new MasterBean(miFicha);
			OcupacionBean ocupacionbean = new OcupacionBean();
			ocupacionbean.setActividades(masterbean.getActividades());
			ocupacionbean.setAerAnio(masterbean.getAerAnio());
			ocupacionbean.setAerDivision(masterbean.getAerDivision());
			ocupacionbean.setAerTotalContratos(masterbean.getAerTotalContratos());
			ocupacionbean.setAnio(masterbean.getAnio());
			ocupacionbean.setConoInformatica(masterbean.getConoInformatica());
			ocupacionbean.setConoAdminPublicas(masterbean.getConoAdminPublicas());
			ocupacionbean.setConoFinancieros(masterbean.getConoFinancieros());
			ocupacionbean.setConoIdiomas(masterbean.getConoIdiomas());
			ocupacionbean.setConoJuridicos(masterbean.getConoJuridicos());
			ocupacionbean.setConoGenericos(masterbean.getConocimientosGenericos());
			ocupacionbean.setNecesidades(masterbean.getNecesidades());
			ocupacionbean.setOcupacion(masterbean.getOcupacion());
			ocupacionbean.setSumaPorcentaje(masterbean.getSumaPorcentaje());
			ocupacionbean.setVacantes(masterbean.getVacantes());
			ocupacionbeans[i] = ocupacionbean; 
		}
		
		
		byte[] b =  new byte[4096];
		try 
		{
			System.setProperty("java.awt.headless", "true");

			JasperReport jasperReport = (JasperReport) JRLoader.loadObject(plantilla);
			jasperPrint = JasperFillManager.fillReport(
					jasperReport,
					new HashMap(), 
					new JRBeanArrayDataSource(ocupacionbeans));

			b = JasperExportManager.exportReportToPdf(jasperPrint);
			return b;
			/**
				//Para comprobar que se ha generado bien:
				FileOutputStream fos = new FileOutputStream("c://temp//mi.pdf");
				fos.write(b);
				fos.close();
			 */
		} 
		catch (JRException ex) 
		{
			throw ex;
		} 
	}
    public static synchronized void viewReport(byte[] informe,Component caller,String charencoding)
    {
        File tempFile;
        FileOutputStream fileOutputStream = null;

        try
        {
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy'.'MM'.'dd'-'HHmm'h.'ss's'");
	        String timestamp = sdf.format(new Date());
	        ContentTransferConfig ctConfig = ContentTransferConfig.getConfig();
	        File tempFolderAppServer = ctConfig.getServerContentLocation();
	        tempFile = File.createTempFile((new StringBuilder()).append("miinforme_").append(timestamp).append(".pdf").toString(), "", tempFolderAppServer);
	        fileOutputStream = new FileOutputStream(tempFile);
	        if(charencoding == null || charencoding.trim().length() == 0)
	        {
	        	charencoding = "UTF-8";
	        }
	        
            fileOutputStream.write(informe);
	        
	        HttpTransportManager manager = HttpTransportManager.getManager();
	        List ids = new ArrayList(1);
	        com.documentum.web.contentxfer.http.HttpTransportManager.Content content = new com.documentum.web.contentxfer.http.HttpTransportManager.Content(tempFile, (new StringBuilder()).append(caller.getString("MSG_FILENAME")).append(".pdf").toString(), "application/pdf", tempFile.getParent(), 2);
	        ids.add(manager.addOutgoing(content));
	        String contextPath = ((HttpServletRequest)caller.getPageContext().getRequest()).getContextPath();
	        manager.setClientDownloadEvent(ids, caller.getTopForm(), contextPath);
	        tempFile.deleteOnExit();
	    }
        catch(Exception e)
        {
            throw new WrapperRuntimeException("Error al visualizar informe:" + e.getMessage());
        }
        finally
        {
	        if(fileOutputStream != null)
	        {
	        	try {fileOutputStream.close();} catch (IOException e) {throw new WrapperRuntimeException("Error al cerrar el fichero temporal:" + e.getMessage());}
	        }        	
        }
    }
}
