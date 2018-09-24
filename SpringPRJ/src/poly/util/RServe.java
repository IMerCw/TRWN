package poly.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

import poly.dto.consumer.CONSUMER_FtReviewDTO;
import poly.dto.consumer.CONSUMER_RcmmndFtDTO;

public class RServe {

	public List<CONSUMER_RcmmndFtDTO> usrCossim(List<CONSUMER_FtReviewDTO> mainUserRvDTO, List<CONSUMER_FtReviewDTO> compUsersRvDTO) throws REXPMismatchException{
	    
        RConnection connection = null;
        
        try {
            connection = new RConnection();
            
            //추천 대상이 되는 벡터 생성
            String mainUsr = "c(";
            String ftSeqs = "c(";
            for(int i = 0; i < mainUserRvDTO.size(); i++) {
            	
            	if(i == mainUserRvDTO.size()-1) {
            		mainUsr += mainUserRvDTO.get(i).getRev_point();
            		mainUsr += ")";
            		ftSeqs += mainUserRvDTO.get(i).getFt_seq();
            		ftSeqs += ")";
            	}
            	
            	else {
            		mainUsr += mainUserRvDTO.get(i).getRev_point();
            		mainUsr += ",";
            		ftSeqs += mainUserRvDTO.get(i).getFt_seq();
            		ftSeqs += ",";
            	}
            	
            }
            
            //추천 비교 벡터 생성
            String targetFtSeqs = "c(";
            String targetUserSeq = "c(";
            String targetRevPoint  = "c(";
            
            for(int j = 0; j < compUsersRvDTO.size(); j++) {
            	
            	if(j == compUsersRvDTO.size()-1 ) {
            		targetRevPoint += compUsersRvDTO.get(j).getRev_point();
            		targetRevPoint += ")";
            		targetFtSeqs += compUsersRvDTO.get(j).getFt_seq();
            		targetFtSeqs += ")";
            		targetUserSeq += compUsersRvDTO.get(j).getUser_seq();
            		targetUserSeq += ")";
            	}
            	
            	else {
            		targetRevPoint += compUsersRvDTO.get(j).getRev_point();
            		targetRevPoint += ",";
            		targetFtSeqs += compUsersRvDTO.get(j).getFt_seq();
            		targetFtSeqs += ",";
            		targetUserSeq += compUsersRvDTO.get(j).getUser_seq();
            		targetUserSeq += ",";
            	}
            	
            }
            //라이브러리
            connection.eval("library(devtools)");
            connection.eval("library(RCurl)");
            connection.eval("library(lsa)"); 
            
            //추천 대상 벡터 병합
            connection.eval("targetFtSeq <- " + ftSeqs); //푸드트럭 목록
            connection.eval("mainUsr <- " + mainUsr); //리뷰 점수 목록
            connection.eval("mainVec <- cbind(targetFtSeq, mainUsr)");
            
            //비교 대상 벡터 생성
            connection.eval("targetFtSeq <- " + targetFtSeqs); //푸드트럭 목록
            connection.eval("targetUserSeq <- " + targetUserSeq);  // 유저 목록
            connection.eval("targetRevPoint  <-" + targetRevPoint); //리뷰 점수 목록
            
            //비교 대상 벡터 병합
            connection.eval("targetVec <- cbind(" + targetFtSeqs + ", " + targetRevPoint +")");
            connection.eval("targetList <- split.data.frame(targetVec, " + targetUserSeq + ")");
            
            //UserSeq 범주화 후 리스트와 갯수 가져오기
            connection.eval("factorUsrSeq <- factor(targetUserSeq)");
            connection.eval("userSeqList <- levels(factorUsrSeq)");
            connection.eval("userSeqLen <- length(userSeqList)");
            
            //대상 벡터 병합 후 Userseq기준으로 리스트 나누기 
            connection.eval("targetVec <- cbind(targetFtSeq,targetRevPoint)");
            connection.eval("TargetList <- split.data.frame(targetVec, targetUserSeq)");
            //UserSeq 칼럼 제거
            connection.eval("for(i in 1:userSeqLen) { TargetList[[i]] <- TargetList[[i]][,-3] } ");

            
            //리스트를 하나로 병합
            connection.eval("targetdf <- Reduce(function(x,y) merge(x,y, by='targetFtSeq', all=T), TargetList)");
            connection.eval("targetdf <- na.omit(targetdf)"); //결측치 제거
            
            //최종 전처리
            connection.eval("resultMat <- merge(mainVec, targetdf, by='targetFtSeq')"); 
            connection.eval("resultMat <- resultMat[-1]"); //ftSeq 제거
            
          
            //lsa 패키지 코사인 유사도 함수 호출
            connection.eval("result <- cosine(data.matrix(resultMat))"); 
            
            //첫번째 행만 가져오기 
            connection.eval("cossimResult <- result[2:ncol(result)]"); 
            
            
            int userSeqsLen = connection.eval("length(userSeqList)").asInteger(); //비교 대상 유저 목록 
            
            String cossimResult;
            String userSeqList;

    		List<CONSUMER_RcmmndFtDTO> rftDTOArr = new ArrayList<>();
    		CONSUMER_RcmmndFtDTO rftDTO = null;
    		for(int i = 1; i <= userSeqsLen; i++) {
    			rftDTO = new CONSUMER_RcmmndFtDTO();
            	rftDTO.setRcmmndRating(connection.eval("cossimResult[" + i + "]").asString()); //결과 값
            	rftDTO.setUserSeq(connection.eval("userSeqList[" + i + "]").asString()); //결과 값
            	rftDTOArr.add(rftDTO);
            }
            
            connection.close();
            
            return rftDTOArr;
            
        } catch (RserveException e) {
            e.printStackTrace();
            return null;
        } finally {
            connection.close();
        }
	}
}
