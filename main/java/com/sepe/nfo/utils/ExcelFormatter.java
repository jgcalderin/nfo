package com.sepe.nfo.utils;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.documentum.web.common.reporting.Cell;
import com.documentum.web.common.reporting.ColumnInfo;
import com.documentum.web.common.reporting.ITableDataProvider;
import com.documentum.web.common.reporting.ITableRowsDataProvider;
import com.documentum.web.common.reporting.MetaData;
import com.documentum.web.common.reporting.Row;

//Referenced classes of package com.documentum.web.common.reporting:
//         Row, ITableDataProvider, ITableRowsDataProvider, Cell, 
//         MetaData, ColumnInfo

public class ExcelFormatter
{

private HSSFWorkbook mWorkbook = null;
private HSSFSheet mSheet = null;
private HSSFCellStyle mCellStyleBold = null; //texto en negrita
private List<ColumnBean> mExtendedColumnsList = null;
private String mCompetenciasIdiomas = null;

 public ExcelFormatter(ITableDataProvider tableDataProvider)
 {
	init(tableDataProvider,null);
 }

 public ExcelFormatter(ITableDataProvider tableDataProvider, ITableRowsDataProvider tableRowsDataProvider)
 {
	 init(tableDataProvider,tableRowsDataProvider);
 }
 
 private void init(ITableDataProvider tableDataProvider, ITableRowsDataProvider tableRowsDataProvider)
 {
     m_tableDataProvider = tableDataProvider;
     m_tableRowsDataProvider = tableRowsDataProvider;
     
     mWorkbook = new HSSFWorkbook();
     mSheet = mWorkbook.createSheet("NFO");
     
     //Inicializamos el estilo "negrita":
     HSSFFont boldfont = mWorkbook.createFont();
     boldfont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
     mCellStyleBold = mWorkbook.createCellStyle();
     mCellStyleBold.setFont(boldfont);
     
     mExtendedColumnsList = getExtendedColumnsList(m_tableDataProvider.getMetaData());
 }

 public void save(OutputStream os, List<String> columnNames)
     throws IOException
 {
     save(os, columnNames, "UTF-8");
 }

 public void save(OutputStream os, List<String> columnNames, String charEncoding)
     throws IOException
 {
     save(os, columnNames, charEncoding, null);
 }

 public void save(OutputStream os, List<String> columnNames, String charEncoding, String rowSelection)
     throws IOException
 {
	 formatHeaderRow(columnNames, charEncoding);
     format(columnNames, charEncoding, rowSelection);
     mWorkbook.write(os);
 }

 private void format(List<String> columnNames, String charEncoding, String rowSelection) throws IOException
 {
	 Iterator rows = null;
	 if(rowSelection == null)
	     rows = m_tableDataProvider.rowIterator(columnNames);
	 else
	     rows = m_tableRowsDataProvider.rowIterator(columnNames, rowSelection);
	 
	 int noOfColumns = mExtendedColumnsList.size();
	 
	 while(rows.hasNext())
	 {
		 Row row = (Row)rows.next();
		 String[] myrow = new String[noOfColumns];
		 for(int i = 0; i < noOfColumns; i++)
	     {
	    	 String colname = (String)mExtendedColumnsList.get(i).getColumnName();
	    	 Cell cell = row.getCell(colname);
	    	 String colvalue = null;
	    	 if (cell != null)
	    		 colvalue = (String)cell.getValue();
	    	 else if (colname.equals(COMPAUDICOLNAME))
	    	 {
	    		 //Para la primera capacidad, buscamos el valor del atributo:
	    		 Cell c = row.getCell("do_nfop_ctra_idioma_c");
	    		 colvalue = (String)c.getValue(); 
	    	 }
	         
	         myrow[i] = encodeString(colname,colvalue);
	         if(i == noOfColumns - 1)
	             continue;
	     }
	     newStringExcelRow(myrow,null,false);
	 }     
 }
 
 private void formatHeaderRow(List<String> columnNames, String charEncoding) throws IOException
 {
	 String[] headerlabels = new String[mExtendedColumnsList.size()];
	 
	 for(short i = 0; i < mExtendedColumnsList.size(); i++)
		 headerlabels[i] = mExtendedColumnsList.get(i).getColumnLabel();
	      
	 newStringExcelRow(headerlabels,mCellStyleBold,true);
 }

 /**
  * Si el usuario selecciona el atributo do_nfop_ctra_idioma_c, hay que agregar al excel las columnas de las capacidades
  * @param metadata
  * @return
  */
 private List<ColumnBean> getExtendedColumnsList(MetaData metadata)
 {
	 ArrayList<ColumnBean> extendedcolumnlist = new ArrayList<ColumnBean>();
	 Iterator<ColumnInfo> icolumns = metadata.getAllColumnInfo().iterator();
	 while (icolumns.hasNext())
	 {
		 ColumnInfo colinfo = icolumns.next();
		 ColumnBean columnbean = new ColumnBean(colinfo.getName(), colinfo.getLabel());
		 if (columnbean.getColumnName().equals("do_nfop_ctra_idioma_c"))
		 {
			 //Anyadimos 5:	
			 ColumnBean auditiva = new ColumnBean(COMPAUDICOLNAME, "Comprensión Auditiva");
			 ColumnBean lectura = new ColumnBean(COMPLECTURACOLNAME, "Comprensión de Lectura");
			 ColumnBean intoral = new ColumnBean(INTORALCOLNAME, "Interacción Oral");
			 ColumnBean exporal = new ColumnBean(EXPORALCOLNAME, "Expresión Oral");
			 ColumnBean escrito = new ColumnBean(ESCRITURACOLNAME, "Escritura");
			 extendedcolumnlist.add(auditiva);
			 extendedcolumnlist.add(lectura);
			 extendedcolumnlist.add(intoral);
			 extendedcolumnlist.add(exporal);
			 extendedcolumnlist.add(escrito);
		 }
		 else
			 extendedcolumnlist.add(columnbean);
	 }
	 	 
	 return extendedcolumnlist;
 }
 
 private void newStringExcelRow(String[] row, HSSFCellStyle rowstyle,boolean isHeader)
 {
	 HSSFRow excelrow = null;
	 if (isHeader)
		 excelrow = mSheet.createRow(0);
	 else
		 excelrow = mSheet.createRow(mSheet.getLastRowNum()+1);
     
	 int cellnum = 0;
     for (String cellvalue : row) 
     {
    	 HSSFCell excelcell = excelrow.createCell(cellnum++);
         excelcell.setCellValue(cellvalue);
         excelcell.setCellType(HSSFCell.CELL_TYPE_STRING);
         if (rowstyle != null)
        	 excelcell.setCellStyle(rowstyle);
     }
 }

 private String encodeString(String colname, String colvalue)
 {
     String retStr = colvalue;
     //aqui metemos las excepciones - START
     if (colname.equalsIgnoreCase("do_nfop_icua_vacantes_dias"))
     {
    	 if (retStr.equalsIgnoreCase("0"))
    		 return "";
     }
     else if (
    		 colname.equalsIgnoreCase("do_nfop_ctra_idioma")||
    		 colname.equalsIgnoreCase("do_nfop_ctra_ofiti")||
    		 colname.equalsIgnoreCase("do_nfop_ctra_ofiti_c"))
     {
    	 retStr = retStr.replaceAll(",", "\n");
    	 return retStr;
     }
     else if (colname.equalsIgnoreCase(COMPAUDICOLNAME))
     {
    	 mCompetenciasIdiomas  = retStr; 
    	 retStr = traverseStringVector(mCompetenciasIdiomas,",",0);
    	 retStr = retStr.replaceAll(",", "\n");
    	 return retStr;
     }
     else if (colname.equalsIgnoreCase(COMPLECTURACOLNAME))
     {
    	 retStr = traverseStringVector(mCompetenciasIdiomas,",",1);
    	 retStr = retStr.replaceAll(",", "\n");
    	 return retStr;
     }
     else if (colname.equalsIgnoreCase(INTORALCOLNAME))
     {
    	 retStr = traverseStringVector(mCompetenciasIdiomas,",",2);
    	 retStr = retStr.replaceAll(",", "\n");
    	 return retStr;
     }
     else if (colname.equalsIgnoreCase(EXPORALCOLNAME))
     {
    	 retStr = traverseStringVector(mCompetenciasIdiomas,",",3);
    	 retStr = retStr.replaceAll(",", "\n");
    	 return retStr;
     }
     else if (colname.equalsIgnoreCase(ESCRITURACOLNAME))
     {
    	 retStr = traverseStringVector(mCompetenciasIdiomas,",",4);
    	 retStr = retStr.replaceAll(",", "\n");
    	 return retStr;
     }
     //aqui metemos las excepciones - END
     

     return retStr;
 }
 
 /**
  * 
  * Devuelve en un string separado por comas los caracteres de la posicion <index> de cada uno de los elementos de svector 
  * @param svector: es un string de substrings del mismo tamanyo separados por <separator>, por ejemplo: ABC,EFG,JKL,PQR 
  * @param separator
  * @param pos: es el indice de cada elemento de svector que se va a usar para crear el vector traverse. Para el svector anterior,
  * y pos = 0 seria AEJP, y para pos = 1 seria BFKQ
  * @return
  */
 private String traverseStringVector(String svector,String separator, int pos)
 {
	 StringBuffer ret = new StringBuffer();
	 String[] filas = svector.split(separator);
	 for (int i=0;i<filas.length;i++)
	 {
		 if (i>0)
			 ret.append(separator);
		 try
		 {
			 ret.append(filas[i].substring(pos,pos+1));
		 }
		 catch(java.lang.StringIndexOutOfBoundsException e)
		 {
			 //ignoramos
		 }
	 }
	 return ret.toString();
 }
 
 private ITableDataProvider m_tableDataProvider;
 private ITableRowsDataProvider m_tableRowsDataProvider;
 private static final String DEFAULT_CHAR_ENCODING = "UTF-8";
 
 //COLUMNAS EXTRA QUE CREAMOS PARA TRATAR EL CASO COMPLEJO DEL ATRIBUTO IDIOMAS:
 private static final String COMPAUDICOLNAME = "COMPAUDICOLNAME";
 private static final String COMPLECTURACOLNAME = "COMPLECTURACOLNAME";
 private static final String INTORALCOLNAME = "INTORALCOLNAME";
 private static final String EXPORALCOLNAME = "EXPORALCOLNAME";
 private static final String ESCRITURACOLNAME = "ESCRITURACOLNAME";
}

class ColumnBean
{
	private String columnlabel = null;
	private String columnname = null;
	
	ColumnBean(String name, String label)
	{
		columnlabel = label;
		columnname = name;
	}
	
	public String getColumnLabel()
	{
		return columnlabel;
	}
	
	public String getColumnName()
	{
		return columnname;
	}
}