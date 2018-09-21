package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import poly.dto.admin.ADMIN_Banner_PopDTO;
import poly.dto.admin.ADMIN_ImageDTO;
import poly.service.ADMIN_IBannerService;
import poly.service.ADMIN_IImageService;
import poly.util.ADMIN_UtilFile;


@Controller
public class ADMIN_BannerController {
	public Logger log = Logger.getLogger(this.getClass());
	 
	@Resource(name="ADMIN_BannerService")
	private ADMIN_IBannerService bannerService;
	
	@Resource(name="ADMIN_ImageService")
	private ADMIN_IImageService imgService;
	
/*----------------------------------------------------------------------------------------*/
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / HH:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
/*배너관리----------------------------------------------------------------------------------------*/	
	
	//배너 리스트
	@RequestMapping(value="admin/banner/banner_main", method=RequestMethod.GET)
	public String banner_main(HttpServletRequest request, Model model) throws Exception{
		String cmd = request.getParameter("cmd");
		if(cmd==null) {
			cmd="banner_list";
		}
		if(cmd.equals("banner_list")) {
			List<ADMIN_Banner_PopDTO> bnDTOarr = bannerService.getBanner_List();
			List<ADMIN_ImageDTO> imgDTOarr = new ArrayList<ADMIN_ImageDTO>();
			for(ADMIN_Banner_PopDTO bnDTO : bnDTOarr) {
				imgDTOarr.add(imgService.getImageInfo(bnDTO.getFile_id()));
			}
			model.addAttribute("bnDTOarr", bnDTOarr);
			model.addAttribute("imgDTOarr", imgDTOarr);
		}else if(cmd.equals("banner_search_list")){
			ADMIN_Banner_PopDTO bnDTO = new ADMIN_Banner_PopDTO();
			bnDTO.setOption(request.getParameter("option"));
			bnDTO.setValue(request.getParameter("value"));
			List<ADMIN_Banner_PopDTO> bnDTOarr = bannerService.getBanner_List_Search(bnDTO);
			List<ADMIN_ImageDTO> imgDTOarr = new ArrayList<ADMIN_ImageDTO>();
			for(ADMIN_Banner_PopDTO bnDTO2 : bnDTOarr) {
				imgDTOarr.add(imgService.getImageInfo(bnDTO2.getFile_id()));
			}
			model.addAttribute("option", request.getParameter("option"));
			model.addAttribute("value", request.getParameter("value"));
			model.addAttribute("bnDTOarr", bnDTOarr);
			model.addAttribute("imgDTOarr", imgDTOarr);
		}else if(cmd.equals("banner_edit")) {
			ADMIN_Banner_PopDTO bnDTO = bannerService.getBanner_Info(Integer.parseInt(request.getParameter("banner_seq")));
			ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
			if(bnDTO.getFile_id().equals("-1")) {
				imgDTO.setFile_orgname("파일없음");
			}else {
				imgDTO = imgService.getImageInfo(bnDTO.getFile_id());
			}
			model.addAttribute("bnDTO", bnDTO);
			model.addAttribute("imgDTO", imgDTO);
		}
		
		//게시판 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));
		
		//페이지 커맨드
		model.addAttribute("cmd", cmd);
		
		return "/admin/banner/banner_main";
	}
	
	//배너등록
	@RequestMapping(value="admin/banner/banner_create", method=RequestMethod.POST)
	public String banner_create(@RequestParam("uploadFile") MultipartFile uploadFile, MultipartHttpServletRequest request, Model model) throws Exception{
		ADMIN_Banner_PopDTO bnDTO = new ADMIN_Banner_PopDTO();
		ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
		bnDTO.setBanner_name(request.getParameter("banner_name"));
		bnDTO.setBanner_loc(request.getParameter("banner_loc"));
		bnDTO.setBanner_regdate(getDate());
		bnDTO.setExp_yn(Integer.parseInt(request.getParameter("exp_yn")));
		
		if(!uploadFile.isEmpty()) {
//	      UtilFile 객체 생성
	        ADMIN_UtilFile utilFile = new ADMIN_UtilFile();
	        
//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
	        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
	        imgDTO.setUser_seq(0);
	        imgDTO.setFile_path(uploadPath);
//	      해당 경로만 받아 db에 저장
	        imgService.Image_Add(imgDTO);
	        String file_id = imgService.getFile_Seq();
	        //System.out.println("RewardController reAddProCtrl n : " + n);
	        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
	        bnDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
		}else {
			bnDTO.setFile_id("-1");
		}
		bannerService.banner_Create(bnDTO); 
		
		return banner_main(request, model);
	}
		
	//배너수정
	@RequestMapping(value="admin/banner/banner_edit", method=RequestMethod.POST)
	public String banner_edit(@RequestParam("uploadFile") MultipartFile uploadFile, MultipartHttpServletRequest request, Model model) throws Exception{
		ADMIN_Banner_PopDTO bnDTO = new ADMIN_Banner_PopDTO();
		ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
		
		bnDTO.setBanner_seq(Integer.parseInt(request.getParameter("banner_seq")));
		bnDTO.setBanner_name(request.getParameter("banner_name"));
		bnDTO.setBanner_loc(request.getParameter("banner_loc"));
		bnDTO.setExp_yn(Integer.parseInt(request.getParameter("exp_yn")));
		
		//이미지 변경 체크
		if(!uploadFile.isEmpty()) { //업로드된 파일 확인
//	      UtilFile 객체 생성
	        ADMIN_UtilFile utilFile = new ADMIN_UtilFile();
	        
//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
	        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
	        imgDTO.setUser_seq(0);
	        imgDTO.setFile_path(uploadPath);
//	      해당 경로만 받아 db에 저장
	        imgService.Image_Add(imgDTO);
	        String file_id = imgService.getFile_Seq();
	        //System.out.println("RewardController reAddProCtrl n : " + n);
	        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
			
	        bnDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
		}else { //업로드된 파일 없을때
			if(request.getParameter("org_file_id")!="-1"){//변경이 없을경우
				System.out.println(request.getParameter("org_file_id"));
				bnDTO.setFile_id(request.getParameter("org_file_id"));
			}else {
				bnDTO.setFile_id("-1");
			}
		}
		
		bannerService.banner_Edit(bnDTO);
		
		return banner_main(request, model);
	}
	
	//배너삭제
	@RequestMapping(value="admin/banner/banner_delete", method=RequestMethod.GET)
	public String banner_delete(HttpServletRequest request, Model model) throws Exception{
		String ArrBanner_Seq = request.getParameter("ArrBanner_Seq");
		if(ArrBanner_Seq!=null) {
			String[] array = ArrBanner_Seq.split(",");
			for(int i=0; i<array.length; i++) {
				bannerService.banner_Delete(Integer.parseInt(array[i]));
			}
		}
		
		return banner_main(request, model);
	}
	
}





