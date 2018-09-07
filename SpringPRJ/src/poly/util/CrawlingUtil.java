package poly.util;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class CrawlingUtil {

	public static String getFestivalHTML() throws Exception {
		String URL = "http://www.cheftruck.kr/bbs/board.php?bo_table=carnival";
		Document doc = Jsoup.connect(URL).get();// jsoup 얻어온 경과 html 전체 문서

		// System.out.println(doc.data());
		// System.out.println(doc.body());
		//System.out.println(doc.toString().length());
		// System.out.println("test : " +doc.body().getElementsByClass("root").text());

		// 상세 2327줄 title="Forum"
		Elements elem = doc.select("div.table-responsive table.table.div-table.list-pc.bg-white"); // element
													
		/*for (int i = 0; i < elem.size(); i++) {
			System.out.println("elem test" + i + ": " + elem.eq(i).text());
		}*/
		//System.out.println("");
		//System.out.println("select : " + elem.html());
		return elem.html();
	}
	// connection : jsoup의 connect 혹은 설정 메소드들을 이용해 만들어지는 객체 . 연결을 하기 위한 정보를 담고 있다 .
	// response : jsoup가 url에 접속해 얻어온 경과 . Document와 다르게 status코드 , status 메시지나
	// charset 같은 메시지와 쿠기등을 가지고 있다.

	// Jsoup로 하는 작업은 크게 보았을 때 Connection 객체를 통해 URL에 접속하고(혹은 로컬 파일/문자열), Response
	// 객체에서 세션ID같은 쿠키와
	// HTML Document를 얻어낸 후,Document의 Element들을 파싱하는 과정으로 나누어진다고 볼 수 있다.

}
