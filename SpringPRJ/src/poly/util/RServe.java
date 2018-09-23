package poly.util;

import java.util.List;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

import poly.dto.consumer.CONSUMER_FtReviewDTO;

public class RServe {

	public void test(List<CONSUMER_FtReviewDTO> mainUserRvDTO, List<CONSUMER_FtReviewDTO> compUsersRvDTO){
	    
        RConnection connection = null;
        
        try {
            connection = new RConnection();
            
         /*   //추천 대상이 되는 벡터 생성
            String mainUsr = "c(";
            String ftSeq = "c(";
            for(int i = 0; i < mainUserRvDTO.size(); i++) {
            	if(i == mainUserRvDTO.size()) {
            		mainUsr += mainUserRvDTO.get(i).getRev_point();
            		mainUsr += ")";
            		ftSeq += mainUserRvDTO.get(i).getFt_seq();
            		ftSeq += ")";
            	}
            	else {
            		mainUsr += mainUserRvDTO.get(i).getRev_point();
            		mainUsr += ",";
            		ftSeq += mainUserRvDTO.get(i).getFt_seq();
            		ftSeq += ",";
            	}
            	
            }
            //추천 비교 벡터 생성
            String mainUsr = "c(";
            String ftSeq = "c(";
            for(int i = 0; i < mainUserRvDTO.size(); i++) {
            	if(i == mainUserRvDTO.size()) {
            		mainUsr += mainUserRvDTO.get(i).getRev_point();
            		mainUsr += ")";
            		ftSeq += mainUserRvDTO.get(i).getFt_seq();
            		ftSeq += ")";
            	}
            	else {
            		mainUsr += mainUserRvDTO.get(i).getRev_point();
            		mainUsr += ",";
            		ftSeq += mainUserRvDTO.get(i).getFt_seq();
            		ftSeq += ",";
            	}
            	
            }
            
            */
            
            connection.eval("meanVal=mean()");
            double mean = connection.eval("meanVal").asDouble();
            System.out.println("The mean of given vector is=" + mean);
            
            
            
            connection.eval("aa <- '한글'");
            System.out.println(connection.eval("aa").asString());
            
            
            connection.close();
        } catch (RserveException e) {
            e.printStackTrace();
        } catch (REXPMismatchException e) {
            e.printStackTrace();
        } finally {
            connection.close();
        }
	}
}
