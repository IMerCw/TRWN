/* Coord.java */

package poly.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

public class UtilTime {
	
	//오늘 날짜("yyyy.MM.dd / hh:mm:ss")
	public static String getDateYMDhms() {
		Calendar cal = Calendar.getInstance(Locale.KOREA);
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss"); //년,월,일,시간,분,초
		/*SimpleDateFormat sdf1 = new SimpleDateFormat("M월 d일");*/
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	public static String getDateYYMMDD(String a) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); //년,월,일,시간,분,초
		try {
			cal.setTime(formatter.parse(a));
			String date = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
			
			return date;
		} catch (ParseException e1) {
		    e1.printStackTrace();
		    return null;
		}
	}
	
	//오늘 날짜("M월d일")
	public static String getDateMD() {
		Calendar cal = Calendar.getInstance();
		/*SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");*/ //년,월,일,시간,분,초
		SimpleDateFormat sdf1 = new SimpleDateFormat("M월 d일");
		String date = sdf1.format(cal.getTime());
				
		return date;
	}
	
	//오늘 요일()
	public static String getDateDD() {
		
		Calendar calendar = Calendar.getInstance();


		int iDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK); //요일을 구한다

		String strDayOfWeek = "";
		
		switch (iDayOfWeek) {
		case 1:
			strDayOfWeek = "일요일";
			break;
		case 2:
			strDayOfWeek = "월요일";
			break;
		case 3:
			strDayOfWeek = "화요일";
			break;
		case 4:
			strDayOfWeek = "수요일";
			break;
		case 5:
			strDayOfWeek = "목요일";
			break;
		case 6:
			strDayOfWeek = "금요일";
			break;
		case 7:
			strDayOfWeek = "토요일";
			break;

		}
		
		String date = "";
		date = strDayOfWeek;
		return date;
		
	}
	
	public static String SetupRegDate(String regDate) {
		//현 날짜 YYYY.MM.DD / hh:mm:ss
		String todayNow =  getDateYMDhms();
		String todayArr[] = todayNow.split("/");
		String todayDate[] = todayArr[0].split("\\. ");
		
		String resultDate = null;
		String regDateArr[] = regDate.split("/");
		String regDateyymmdd[] = regDateArr[0].split("\\. ");
		String regDateTime[] = regDateArr[1].split(":");
		
		
		for(int i = 0; i < 3; i++) {
			
			if(!todayDate[i].equals(regDateyymmdd[i])) {
				resultDate = regDateyymmdd[0].substring(2) + "." + regDateyymmdd[1] + "." + regDateyymmdd[2];
				return resultDate;
			}
		}
		
		resultDate = regDateTime[0] + ":" + regDateTime[1];
		
		return resultDate; 
	}
}