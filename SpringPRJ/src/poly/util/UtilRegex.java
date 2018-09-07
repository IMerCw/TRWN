package poly.util;

import java.util.regex.Pattern;

public class UtilRegex {
	public static boolean sidoPattern(String input) {
		String pattern = "([가-힣]+(시|도))|(서울|인천|대구|광주|부산|울산|제주|전남|전북|충남|충북|)";
		boolean result = Pattern.matches(pattern, input);
		if(result==true)
		{
			System.out.println(input+"는 패턴에 일치함.");
		}
		else
		{
			System.out.println("패턴 일치하지 않음.");
		}

		return result;
	}
	public static boolean sigunguPattern(String input) {
		String pattern = "([가-힣]+(시|군|구))";
		boolean result = Pattern.matches(pattern, input);
		if(result==true)
		{
			System.out.println(input+"는 패턴에 일치함.");
		}
		else
		{
			System.out.println("패턴 일치하지 않음.");
		}
		
		return result;
	}
	public static boolean dongPattern(String input) {
		String pattern  = "(([가-힣]+(\\d{1,5}|\\d{1,5}(,|.)\\d{1,5}|)+(읍|면|동|가|리))(^구|)((\\d{1,5}(~|-)\\d{1,5}|\\d{1,5})(가|리|)|))"
						+ "([ ](산(\\d{1,5}(~|-)\\d{1,5}|\\d{1,5}))|)|\r\n"
						+ "(([가-힣]|(\\d{1,5}(~|-)\\d{1,5})|\\d{1,5})+(로|길))";
						
        boolean result = Pattern.matches(pattern, input);
        if(result==true)
        {
            System.out.println(input+"는 패턴에 일치함.");
        }
        else
        {
            System.out.println("패턴 일치하지 않음.");
        }

		return result;
	}
}
