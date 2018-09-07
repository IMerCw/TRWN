package poly.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import poly.dto.consumer.CONSUMER_DissInfoDTO;
import poly.dto.consumer.CONSUMER_WeatherDTO;
import poly.dto.seller.SELLER_DissInfoDTO;
import poly.dto.seller.SELLER_WeatherDTO;

public class OpenAPI {
	
	public static List<CONSUMER_WeatherDTO> getWeatherData(Coord coord) throws IOException, JSONException {
		Calendar baseTimeDate = getLastBaseTime();
		String baseTimeDateStr = new SimpleDateFormat("yyyyMMddHHmmss").format(baseTimeDate.getTime());
		String baseDate = baseTimeDateStr.substring(0,8);
		String baseTime = baseTimeDateStr.substring(8,12);
		
		String urlstr = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData"
			  + "?ServiceKey=" //API KEY입력
			  + "NM1oJvYCcGILHPKU0R8dmv9P%2BvAxnAXIoSLH29uHh4TFUkRZdD9iqZF7HnKPYCQHBM1eM29GDwkz5of%2BiHtT0g%3D%3D"
			  + "&base_date="+baseDate //기준 년, 월, 일
			  + "&base_time="+baseTime	//기준 시각
			  + "&nx="+coord.getSx() + "&ny="+coord.getSy()	//좌표
			  + "&_type=json";	//데이터 타입
		

        String jsonText = readJsonFromUrl(urlstr);
        JSONObject jsonObject = new JSONObject(jsonText);
        JSONObject responseJson = jsonObject.getJSONObject("response");
        JSONObject headerJson = responseJson.getJSONObject("header");
        String resultMsg = (String) headerJson.get("resultMsg");

        //API요청 OK
        if(resultMsg.equals("OK")) {
        	
        	List<CONSUMER_WeatherDTO> weatherDTOs = new ArrayList<CONSUMER_WeatherDTO>();
        	JSONObject bodyJson = responseJson.getJSONObject("body");
            JSONObject itemsJson = bodyJson.getJSONObject("items");
            JSONArray itemJson = itemsJson.getJSONArray("item");
            
            for(int i = 0; i < itemJson.length(); i++) {
            	JSONObject itm = (JSONObject) itemJson.get(i);
            	CONSUMER_WeatherDTO weatherDTO = new CONSUMER_WeatherDTO();
            	weatherDTO.setBaseDate(itm.get("baseDate").toString());
            	weatherDTO.setBaseTime(itm.get("baseTime").toString());
            	weatherDTO.setCategory(itm.get("category").toString());
            	weatherDTO.setFcstDate(itm.get("fcstDate").toString());
            	weatherDTO.setFcstTime(itm.get("fcstTime").toString());
            	weatherDTO.setFcstValue(itm.get("fcstValue").toString());
            	weatherDTO.setNx(itm.get("nx").toString());
            	weatherDTO.setNy(itm.get("ny").toString());
            	weatherDTOs.add(weatherDTO);
            }
            
            
            return weatherDTOs;
        } else {
        	return null;
        }
        
	}

		
	//식중독 예방 정보 json파일 deserialization
	public static CONSUMER_DissInfoDTO getDissInfo(String url) throws IOException, JSONException {
		CONSUMER_DissInfoDTO dissInfoDTO = new CONSUMER_DissInfoDTO();
		String jsonText = readJsonFromUrl(url);
        		
		JSONObject jsonObject = new JSONObject(jsonText);
		JSONObject responseJson = jsonObject.getJSONObject("response");
		JSONObject bodyJson = responseJson.getJSONObject("body");
		JSONArray itemsJson = bodyJson.getJSONArray("items");
		JSONObject itm = (JSONObject) itemsJson.get(0);
		dissInfoDTO.setDt(itm.getString("dt"));
		dissInfoDTO.setCnt(itm.get("cnt").toString());
		dissInfoDTO.setRisk(itm.get("risk").toString());
		dissInfoDTO.setDissRiskXpln(itm.getString("dissRiskXpln"));
		
		return dissInfoDTO; 
	}
	
	
	//url에서 json파일 읽기
	public static String readJsonFromUrl(String url) throws IOException, JSONException {
		
	    InputStream is = new URL(url).openStream();
	    try {
	      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
	      String jsonText = readAll(rd);

	      return jsonText;
	    } finally {
	      is.close();
	    }
	}

	
	//json파일 읽어오기
	private static String readAll(Reader rd) throws IOException {
		StringBuilder sb = new StringBuilder();
	    int cp;
	    while ((cp = rd.read()) != -1) {
	      sb.append((char) cp);
	    }
	    return sb.toString();
	}
	
	//현재시각에 맞는 예측 시간을 반환
	private static Calendar getLastBaseTime() {
		Calendar calBase = Calendar.getInstance();
		int t = calBase.get(Calendar.HOUR_OF_DAY);

		if (t < 2) {

		calBase.add(Calendar.DATE, -1);
		calBase.set(Calendar.HOUR_OF_DAY, 23);

		} else {

		calBase.set(Calendar.HOUR_OF_DAY, t - (t + 1) % 3);

		}
		
		return calBase;
	}
	
	//SELLER WEATHER 
	public static List<SELLER_WeatherDTO> getWeatherSeller(Coord coord) throws IOException, JSONException {
		Calendar baseTimeDate = getLastBaseTime();
		String baseTimeDateStr = new SimpleDateFormat("yyyyMMddHHmmss").format(baseTimeDate.getTime());
		String baseDate = baseTimeDateStr.substring(0,8);
		String baseTime = baseTimeDateStr.substring(8,12);
		
		String urlstr = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData"
			  + "?ServiceKey=" //API KEY입력
			  + "NM1oJvYCcGILHPKU0R8dmv9P%2BvAxnAXIoSLH29uHh4TFUkRZdD9iqZF7HnKPYCQHBM1eM29GDwkz5of%2BiHtT0g%3D%3D"
			  + "&base_date="+baseDate //기준 년, 월, 일
			  + "&base_time="+baseTime	//기준 시각
			  + "&nx="+coord.getSx() + "&ny="+coord.getSy()	//좌표
			  + "&_type=json";	//데이터 타입
		

        String jsonText = readJsonFromUrl(urlstr);
        JSONObject jsonObject = new JSONObject(jsonText);
        JSONObject responseJson = jsonObject.getJSONObject("response");
        JSONObject headerJson = responseJson.getJSONObject("header");
        String resultMsg = (String) headerJson.get("resultMsg");

        //API요청 OK
        if(resultMsg.equals("OK")) {
        	
        	List<SELLER_WeatherDTO> weatherDTOs = new ArrayList<SELLER_WeatherDTO>();
        	JSONObject bodyJson = responseJson.getJSONObject("body");
            JSONObject itemsJson = bodyJson.getJSONObject("items");
            JSONArray itemJson = itemsJson.getJSONArray("item");
            
            for(int i = 0; i < itemJson.length(); i++) {
            	JSONObject itm = (JSONObject) itemJson.get(i);
            	SELLER_WeatherDTO weatherDTO = new SELLER_WeatherDTO();
            	weatherDTO.setBaseDate(itm.get("baseDate").toString());
            	weatherDTO.setBaseTime(itm.get("baseTime").toString());
            	weatherDTO.setCategory(itm.get("category").toString());
            	weatherDTO.setFcstDate(itm.get("fcstDate").toString());
            	weatherDTO.setFcstTime(itm.get("fcstTime").toString());
            	weatherDTO.setFcstValue(itm.get("fcstValue").toString());
            	weatherDTO.setNx(itm.get("nx").toString());
            	weatherDTO.setNy(itm.get("ny").toString());
            	weatherDTOs.add(weatherDTO);
            }
            
            
            return weatherDTOs;
        } else {
        	return null;
        }
        
	}
	
	//식중독 예방 정보 json파일 deserialization seller
		public static SELLER_DissInfoDTO getDissInfoSel(String url) throws IOException, JSONException {
			SELLER_DissInfoDTO dissInfoDTO = new SELLER_DissInfoDTO();
			String jsonText = readJsonFromUrl(url);
	        		
			JSONObject jsonObject = new JSONObject(jsonText);
			JSONObject responseJson = jsonObject.getJSONObject("response");
			JSONObject bodyJson = responseJson.getJSONObject("body");
			JSONArray itemsJson = bodyJson.getJSONArray("items");
			JSONObject itm = (JSONObject) itemsJson.get(0);
			dissInfoDTO.setDt(itm.getString("dt"));
			dissInfoDTO.setCnt(itm.get("cnt").toString());
			dissInfoDTO.setRisk(itm.get("risk").toString());
			dissInfoDTO.setDissRiskXpln(itm.getString("dissRiskXpln"));
			
			return dissInfoDTO; 
		}

	
	
}
