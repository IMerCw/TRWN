package poly.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import poly.dto.consumer.CONSUMER_Ft_InfoDTO;
import poly.dto.consumer.CONSUMER_Menu_InfoDTO;

//truck리스트를 정렬하는 함수입니다.
public class SortTruck {
	
	// 가까운 거리의 푸드트럭부터 순서대로 MenuDTO 반환하는 함수 -- 매개변수: 푸드트럭DTO, 메뉴DTO, 현재 위치
	public static List<CONSUMER_Menu_InfoDTO> getMenuDTO(List<CONSUMER_Menu_InfoDTO> menuDTO, List<CONSUMER_Ft_InfoDTO> ftDTO, String []currentLoc) {
		
		List<CONSUMER_Ft_InfoDTO> newFtList = findTruckBySeq(menuDTO, ftDTO); // ftList중 메뉴DTO에 있는 것만 가져오기  
		List<CONSUMER_Ft_InfoDTO> adjList = getAdjTrucks(newFtList, currentLoc); //가까운 트럭을 정렬
		adjList = sortFtClose(adjList); //매겨진 순서대로 트럭 정렬
		List<CONSUMER_Menu_InfoDTO> sortedMenuDTO = findTruckBySeqToMenuDTO(menuDTO, adjList); //순서화된 adjList를 이용해 menuDTO를 정렬
		
		return sortedMenuDTO;
	}
	
	// ftList중 메뉴DTO에 있는 것만 가져오기
	public static List<CONSUMER_Ft_InfoDTO> findTruckBySeq(List<CONSUMER_Menu_InfoDTO> menuDTO, List<CONSUMER_Ft_InfoDTO> ftDTO) {
		List<CONSUMER_Ft_InfoDTO> newList = new ArrayList<CONSUMER_Ft_InfoDTO>(); //반환 할 새로운 리스트 선언
		Set<Integer> menuDTOFtSeq = new HashSet<Integer>(); // ft_seq를 저장할 해쉬 셋 선언
		
		for(int i = 0; i < menuDTO.size(); i++) {
			menuDTOFtSeq.add(menuDTO.get(i).getFt_seq());
		}
		
		// Displaying the values after iterating through the set
        for(int j = 0; j <ftDTO.size(); j++) {
        	for (Iterator<Integer> iterator = menuDTOFtSeq.iterator(); iterator.hasNext();) {
        		System.out.println("ftDTO is" + ftDTO.get(j).getFt_seq());
        		
        		if(iterator.next() == ftDTO.get(j).getFt_seq()) {
					newList.add(ftDTO.get(j));
					System.out.println("new DTO has been added to newList: " + ftDTO.get(j).getFt_seq());
				}
        	} 
			
        }
        
		System.out.println("newList size is " + newList.size());
		
		return newList;
	}
	
	public static List<CONSUMER_Menu_InfoDTO> findTruckBySeqToMenuDTO(List<CONSUMER_Menu_InfoDTO> menuDTO, List<CONSUMER_Ft_InfoDTO> ftDTO) {
		List<CONSUMER_Menu_InfoDTO> newList = new ArrayList<CONSUMER_Menu_InfoDTO>();
		
		for(int i = 0; i < ftDTO.size(); i++) {
			for(int j = 0; j < menuDTO.size(); j++) {
				if(ftDTO.get(i).getFt_seq() == menuDTO.get(j).getFt_seq()) {
					newList.add(menuDTO.get(j));
					System.out.println("new DTO has been added to newList: " + menuDTO.get(j).getFt_seq());
				}
			}
		}
		
		System.out.println("newList size is " + newList.size());
		return newList;
	}
	
	
	//푸드트럭과 현재 위치의 거리 계산을 위한 함수

	////Static 함수로 선언하여 객체선언 필요없이 사용 가능하도록 설정, 
	////DB에서 받아온 기존의 푸드트럭들 정보가 담긴 FtList 변수와 현재 위치가 담긴 currentLoc 어레이 변수를 파라미터로 받음
	public static List<CONSUMER_Ft_InfoDTO> getAdjTrucks(List<CONSUMER_Ft_InfoDTO> ftList, String []currentLoc) {
		//String 에서 double로 형 변환
		double currentLocLat = Double.parseDouble(currentLoc[0]);
		double currentLocLon = Double.parseDouble(currentLoc[1]);
		
		List<CONSUMER_Ft_InfoDTO> FtListInOrder = new ArrayList<CONSUMER_Ft_InfoDTO>(); //리턴할 새로운 리스트
		for(int i = 0; i < ftList.size(); i++) {
			//각각의 트럭들 또한 형 변환이 필요
			double truckPositionLat = Double.parseDouble(ftList.get(i).getGps_x());
			double truckPositionLon = Double.parseDouble(ftList.get(i).getGps_y());
			
			//킬로미터 단위로 거리 반환 후 변수에 따로 저장
			double truckDistance = distance(currentLocLat,currentLocLon,truckPositionLat,truckPositionLon, "kilometer"); 
			ftList.get(i).setFt_dist_order(truckDistance); //현재 인덱스가 i인 객체에 거리 값을 저장함
			FtListInOrder.add(ftList.get(i)); //새로운 리스트에 저장
			
		}
		
		return FtListInOrder;
	}
	
	////거리 계산 수학식 모델
	private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
			
			double theta = lon1 - lon2;
			double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
			
			dist = Math.acos(dist);
			dist = rad2deg(dist);
			dist = dist * 60 * 1.1515;
			
			if (unit == "kilometer") {
				dist = dist * 1.609344;
			} else if(unit == "meter"){
				dist = dist * 1609.344;
			} 

			return (dist);
		}
		

		////// This function converts decimal degrees to radians
	private static double deg2rad(double deg) {
			return (deg * Math.PI / 180.0);
	}
		
		////// This function converts radians to decimal degrees
	private static double rad2deg(double rad) {
			return (rad * 180 / Math.PI);
	}

	//Ft_InfoDTO의 ft_dist_order에 미리 계산된 순서를 정렬하는 함수
	public static List<CONSUMER_Ft_InfoDTO> sortFtClose(List<CONSUMER_Ft_InfoDTO> ftList) {
		
		CONSUMER_Ft_InfoDTO tempDTO = new CONSUMER_Ft_InfoDTO(); //swap을 위한 임시 변수 설정
		System.out.println("sortFtClose start!!"); 
		
		for(int i = 0; i < ftList.size()-1; i++) {
			
			for(int j = i+1; j < ftList.size(); j++) {
				double pivot = ftList.get(i).getFt_dist_order();
				double later = ftList.get(j).getFt_dist_order();
				
				if(pivot > later) {
					tempDTO = ftList.get(i);
					ftList.set(i, ftList.get(j));
					ftList.set(j, tempDTO);
				}
			}
		}
		
		return ftList;
	}
}
