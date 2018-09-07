package poly.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class timeFormat {
	public static String TimeToString(String currdate) throws ParseException {

		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currdate);
		
		String newstring = new SimpleDateFormat("yyyy-MM-dd").format(date);
		return newstring;
	
	}

}
