package com.sepe.nfo.utils;

import java.io.IOException;
import java.io.Writer;
import java.util.Iterator;
import java.util.List;

import com.documentum.web.common.reporting.Cell;
import com.documentum.web.common.reporting.ITableDataProvider;
import com.documentum.web.common.reporting.ITableRowsDataProvider;
import com.documentum.web.common.reporting.MetaData;
import com.documentum.web.common.reporting.Row;

//Referenced classes of package com.documentum.web.common.reporting:
//         Row, ITableDataProvider, ITableRowsDataProvider, Cell, 
//         MetaData, ColumnInfo

public class HTMLFormatter
{

 public HTMLFormatter(ITableDataProvider tableDataProvider)
 {
     m_tableDataProvider = null;
     m_tableRowsDataProvider = null;
     m_tableDataProvider = tableDataProvider;
 }

 public HTMLFormatter(ITableDataProvider tableDataProvider, ITableRowsDataProvider tableRowsDataProvider)
 {
     m_tableDataProvider = null;
     m_tableRowsDataProvider = null;
     m_tableDataProvider = tableDataProvider;
     m_tableRowsDataProvider = tableRowsDataProvider;
 }

 public void save(Writer writer, List columnNames)
     throws IOException
 {
     save(writer, columnNames, "UTF-8");
 }

 public void save(Writer writer, List columnNames, String charEncoding)
     throws IOException
 {
     save(writer, columnNames, charEncoding, null);
 }

 public void save(Writer writer, List columnNames, String charEncoding, String rowSelection)
     throws IOException
 {
	 formatHTML_START(writer, columnNames, charEncoding);
	 formatHeaderRow(writer, columnNames, charEncoding);
     format(writer, columnNames, charEncoding, rowSelection);
	 formatHTML_END(writer, columnNames, charEncoding);
 }

 private void format(Writer writer, List columnNames, String charEncoding, String rowSelection)
     throws IOException
 {
     Iterator rows = null;
     if(rowSelection == null)
         rows = m_tableDataProvider.rowIterator(columnNames);
     else
         rows = m_tableRowsDataProvider.rowIterator(columnNames, rowSelection);
     int noOfColumns = columnNames.size();
     while(rows.hasNext())
     {
    	 writer.write("<tr>");
    	 Row row = (Row)rows.next();
         for(int i = 0; i < noOfColumns; i++)
         {
             Cell column = row.getCell((String)columnNames.get(i));
             writer.write("<td>" + encodeString((String)column.getValue()) + "</td>");
             if(i == noOfColumns - 1)
                 continue;
         }
    	 writer.write("</tr>");
     }

     writer.flush();
 }

 private void formatHTML_START(Writer writer, List columnNames, String charEncoding)
 throws IOException
{
     writer.write("<html><head><meta charset=\"UTF-8\"></head><table border=\"1\">");
     writer.flush();
}

 private void formatHTML_END(Writer writer, List columnNames, String charEncoding)
 throws IOException
{
     writer.write("</table></html>");
     writer.flush();
}

 private void formatHeaderRow(Writer writer, List columnNames, String charEncoding)
     throws IOException
 {
     MetaData metaData = m_tableDataProvider.getMetaData();
     int noOfColumns = columnNames.size();
     for(int i = 0; i < noOfColumns; i++)
     {
         writer.write("<th>" + encodeString(metaData.getColumnInfo((String)columnNames.get(i)).getLabel()) + "</th>");
         if(i == noOfColumns - 1)
             continue;
     }

     writer.flush();
 }

 private String encodeString(String s)
 {
     String retStr = s;
     if(retStr.contains("\n"))
     {
         retStr = retStr.replaceAll("\n", "<br>");
     }
     return retStr;
 }

 private ITableDataProvider m_tableDataProvider;
 private ITableRowsDataProvider m_tableRowsDataProvider;
 private static final String DEFAULT_CHAR_ENCODING = "UTF-8";
}