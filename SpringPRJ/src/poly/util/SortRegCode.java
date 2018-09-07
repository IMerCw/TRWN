package poly.util;

public class SortRegCode {
	//질병예방API 용, DB저장용 코드 변환
	//현재의 법정동 코드 최신화 업데이트 안되어있음
	public static String chgToRegCode(String address) {
		String myRegCode;
		
		String sidoName = address.substring(0, 2);
		System.out.println(sidoName);
		switch(sidoName) {
			case "서울":	myRegCode = "11";	break;
			case "부산": myRegCode = "26";	break;
			case "대구": myRegCode = "27";	break;
			case "인천":	myRegCode = "28";	break;
			case "광주":	myRegCode = "29";	break;
			case "대전":	myRegCode = "30";	break;
			case "울산":	myRegCode = "31";	break;
			case "경기":	myRegCode = "41";	break;
			case "강원":	myRegCode = "42";	break;
			case "충북":	myRegCode = "43";	break;
			case "충남":	myRegCode = "44";	break;
			case "전북":	myRegCode = "45";	break;
			case "전남":	myRegCode = "46";	break;
			case "경북":	myRegCode = "47";	break;
			case "경남":	myRegCode = "48";	break;
			case "제주":	myRegCode = "49";	break;
			default :	myRegCode = "99";
		}
		
		return myRegCode;
	}


}
