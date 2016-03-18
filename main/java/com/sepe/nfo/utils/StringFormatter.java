package com.sepe.nfo.utils;

public class StringFormatter {

	public static int UNIX_FILE_NAME_FORMATTER = 1;

	public String format(String s, int formatType)
	{
		Formattter f = getFormattter(formatType);
		return f.format(s);
	}

	private Formattter getFormattter(int formatType)
	{
		UnixFileNameFormatter u = new UnixFileNameFormatter();
		if (u.isFormattter(formatType))
			return u;

		u = null;

		return null;
	}

	class Formattter {
		int formatType = -1;
		protected String[] replaceThisList = new String[] { "á", "é", "í", "ó",
				"ú", "Á", "É", "Í", "Ó", "Ú", " .", ". ", "ñ", " ", "/", "\\" };
		protected String[] replaceWithList = new String[] { "a", "e", "i", "o",
				"u", "A", "E", "I", "O", "U", ".", ".", "ny", "", "-", "-" };

		protected String format(String s)
		{
			return s;
		}
	}

	class UnixFileNameFormatter extends Formattter {
		protected UnixFileNameFormatter() {

		}

		protected boolean isFormattter(int formatType)
		{
			if (formatType == StringFormatter.UNIX_FILE_NAME_FORMATTER)
				return true;
			else
				return false;
		}

		protected String format(String s)
		{
			for (int i = 0; i < replaceThisList.length; i++)
			{
				String rThis = replaceThisList[i];
				String rWith = replaceWithList[i];
				s = s.replace(rThis, rWith);
			}
			return s;
		}
	}
}
