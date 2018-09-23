package poly.util;

import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import au.com.bytecode.opencsv.CSVWriter;


public class ReadCSV {

	public void wirteTrendCsv(String realPathCSV, ArrayList<Map<String,String>> trndKywrdMap) {

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
}
