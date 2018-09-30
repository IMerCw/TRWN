package poly.util;

import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ser.std.IterableSerializer;

import au.com.bytecode.opencsv.CSVWriter;
import poly.dto.consumer.CONSUMER_Search_Trend_WDateDTO;


public class ReadCSV {
	
	//검색어 워드 클라우드
	public void wirteWrdCldCsv(String realPathCSV, ArrayList<Map<String,String>> trndKywrdMap) {

		try {
            /**
             * csv 파일을 쓰기위한 설정
             * 설명
             * D:\\test.csv : csv 파일저장할 위치+파일명
             * EUC-KR : 한글깨짐설정을 방지하기위한 인코딩설정(UTF-8로 지정해줄경우 한글깨짐)
             * ',' : 배열을 나눌 문자열
             * '"' : 값을 감싸주기위한 문자
             **/
            CSVWriter cw = new CSVWriter(new OutputStreamWriter(
            		new FileOutputStream(realPathCSV), "UTF-8"),',', 
            		CSVWriter.NO_QUOTE_CHARACTER);
            try {
            	//header입력
            	cw.writeNext(new String[] {"word", "freq"});
            	
                for(Map<String, String> m : trndKywrdMap) {
                    //배열을 이용하여 row를 CSVWriter 객체에 write
                    cw.writeNext(new String[] { String.valueOf(m.get("word")),String.valueOf(m.get("freq"))});
                }  
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                //무조건 CSVWriter 객체 close
                cw.close();
            }  
        } catch (Exception e) {
            e.printStackTrace();
        }


	}
	
	// 검색어 트렌드 추이 csv쓰기
	public void wirteTrndCsv(String realPathCSV, Map<String, String> trndKywrdMap, List<CONSUMER_Search_Trend_WDateDTO> trndKywrdWDate) {
		
		try {
			/**
			 * csv 파일을 쓰기위한 설정
			 * 설명
			 * D:\\test.csv : csv 파일저장할 위치+파일명
			 * EUC-KR : 한글깨짐설정을 방지하기위한 인코딩설정(UTF-8로 지정해줄경우 한글깨짐)
			 * ',' : 배열을 나눌 문자열
			 * '"' : 값을 감싸주기위한 문자
			 **/
			CSVWriter cw = new CSVWriter(new OutputStreamWriter(
					new FileOutputStream(realPathCSV), "UTF-8"),',', 
					CSVWriter.NO_QUOTE_CHARACTER);
			try {
				String firstKywrd = trndKywrdMap.get("first");
				String secndKywrd = trndKywrdMap.get("second");
				String thirdKywrd = trndKywrdMap.get("third");
				
				String thrrKyWrd[] = new String[] {firstKywrd, secndKywrd,thirdKywrd};
				
				
				cw.writeNext(new String[] {"date", firstKywrd, secndKywrd , thirdKywrd});
				String kywrdArr[] = null;
				
				String thingsToWrite = "";
				
				for(CONSUMER_Search_Trend_WDateDTO m : trndKywrdWDate) {
					kywrdArr = m.getTrend_words().split(",");
					
					for(String kywrd : kywrdArr) {
						String tmpKywrd;
						tmpKywrd = kywrd.split(":")[0];
						
						if(tmpKywrd.equals(thrrKyWrd[0])) {
							thingsToWrite += kywrd.split(":")[1];
						} else {
							thingsToWrite += "0";
						}
					}
					//배열을 이용하여 row를 CSVWriter 객체에 write
					cw.writeNext(new String[] { String.valueOf(m.getTrend_date()), });
				}  
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				//무조건 CSVWriter 객체 close
				cw.close();
			}  
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
}
