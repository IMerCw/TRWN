package poly.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.util.CmmUtil;

//import com.sun.java.util.jar.pack.Package.Class.Method;

/*import trwn.util.EmailSender;
*/
@Controller
public class CMMN_MainController {
	private Logger log = Logger.getLogger(this.getClass());
	/*로그를 찍고 파일로 남깁니다 .*/
	String msg = "";
	String url = "";
	
	/*@Autowired
	private EmailSender emailSender;*/
	
	//트럭 왔냠 메인 페이지
	@RequestMapping(value="cmmn/main")
	public String main(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info("Access trwn/main");
		session.invalidate();
		log.info("Terminate trwn/main");
		
		return "/cmmn/main";
	}
}
	
	


