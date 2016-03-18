package com.sepe.nfo.utils;

import java.util.ArrayList;

import com.documentum.fc.client.DfQuery;
import com.documentum.fc.client.IDfCollection;
import com.documentum.fc.client.IDfQuery;
import com.documentum.fc.client.IDfSession;
import com.documentum.fc.common.DfException;
import com.documentum.web.formext.session.SessionManagerHttpBinding;


public class Utils {

	@SuppressWarnings("unchecked")
	public static synchronized String getContentTypeFromDosExtension(String _dosExtension) throws DfException
	{
		String query = "select name from dm_format where lower(dos_extension) = '"
				+ _dosExtension.toLowerCase()
				+ "' or lower(name) = '"
				+ _dosExtension.toLowerCase() + "'";

		ArrayList ret = executeSingleStringQuery(query, "name");

		if (!ret.isEmpty())
			return (String) ret.get(0);

		return null;
	}
	
	@SuppressWarnings("unchecked")
	public static synchronized ArrayList executeSingleStringQuery(String query,
			String attName) throws DfException
	{
		ArrayList ret = new ArrayList();
		IDfSession sess = SessionManagerHttpBinding.getSessionManager()
				.getSession(SessionManagerHttpBinding.getCurrentDocbase());
		IDfQuery dfQuery = new DfQuery();
		dfQuery.setDQL(query);
		IDfCollection col = dfQuery.execute(sess, IDfQuery.DF_QUERY);
		try
		{
			while (col.next())
				ret.add(col.getString(attName));
		}
		catch (DfException e)
		{
			throw e;
		}
		finally
		{
			if (col != null)
				col.close();
		}

		return ret;
	}
	
	@SuppressWarnings("unchecked")
	public static synchronized String getDosExtensionFromContentType(
			String _contentType) throws DfException
	{
		String query = "select dos_extension from dm_format where lower(name) = '"
				+ _contentType.toLowerCase() + "'";

		ArrayList ret = executeSingleStringQuery(query, "dos_extension");

		if (!ret.isEmpty())
			return (String) ret.get(0);

		return null;
	}
}
