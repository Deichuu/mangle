package com.dream.mangle.controller;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dream.mangle.domain.AuthorityVO;
import com.dream.mangle.domain.MemberVO;
import com.dream.mangle.service.MemberService;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Controller
@RequestMapping("/member")
public class MemberController {
	private MemberService service;
	
	private final JavaMailSender mailSender;
	
	@GetMapping("/signInUp")
	public void getSignInUp() {
		System.out.println("로그인/회원가입 페이지 호출");
	}
	
	@GetMapping("/accessForbidden")
	public void test() {
		
	}
	
	@GetMapping("/searchEP")
	public void getSearch() {
		
	}
	
	@PostMapping("/registerMember")
	public void registerMember(MemberVO member, RedirectAttributes m) {
		System.out.println("member(Controller): " + member);
		
		if(service.insertMember(member)) {
			m.addFlashAttribute("y");
		}else {
			m.addFlashAttribute("n");
		}
		AuthorityVO authorityVO = new AuthorityVO(member.getUserEmail(), "USER");
		
		service.insertMemberAuthority(authorityVO);
	}
	
	@PostMapping("/emailCheck")
	@ResponseBody
	public ResponseEntity<String> emailCheck(String userEmail, RedirectAttributes m) {
		String result = "";
		if(service.selectUseremail(userEmail) == 0) {
			result = "y";
		}else {
			result = "n";
		}
				
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PostMapping("/mobileCheck")
	@ResponseBody
	public ResponseEntity<String> mobileCheck(String userMobile, RedirectAttributes m) {
		String result = "";
		if(service.selectUsermobile(userMobile) == 0) {
			result = "y";
		}else {
			result = "n";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping("/emailAuth")
	public String emailAuth(String userEmail) {
		Random random = new Random();
		int ranNum = random.nextInt(888888) + 111111;
		
		String setFrom = "goott_test@naver.com";
		String toMail = userEmail;
		String title = "Mangle a Dream의 회원가입 인증 이메일입니다.";
		String content = "홈페이지 방문을 축하합니다. <br><br> 인증번호는 "+ranNum +" 입니다. 해당 인증번호를 인증번호 확인란에 넣어주세요.";
		

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper;			
			helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		
		return Integer.toString(ranNum);
	}
	
	
	//회원 조회: 회원 권한도 함께 조회됨 (스프링 시큐리티도 사용함), userEmail을 사용한 특정회원 조회
	@PreAuthorize("(isAuthenticated() && principal.username == #userEmail)")
	@GetMapping("/myPage")
	public void getMyPage(String userEmail, Model model) {
		model.addAttribute("myPage", service.selectMemberService(userEmail));
		
	}
	
	
	//회원정보수정(기존비번 일치여부)
	@PreAuthorize("isAuthenticated() && principal.username == #member.userEmail")
	@PostMapping("/checkPw")
	@ResponseBody
	public ResponseEntity<String> checkPw(MemberVO member, RedirectAttributes rat){
		String result="";
		if(service.checkPwService(member)) {
			result="y";
		} else {
			result="n";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	
	//회원정보 수정 --> 비밀번호 수정
	@PreAuthorize("isAuthenticated() && principal.username == #member.userEmail")
	@PostMapping("/myPw")
	@ResponseBody
	public ResponseEntity<String> getNewPw(@ModelAttribute MemberVO member) {
		String result="";
		if(service.updatePwService(member)) {
			result="y";
		} else {
			result="n";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
		
	}
	
	
	//회원정보 수정 --> 폰번호 수정
	@PreAuthorize("isAuthenticated() && principal.username == #member.userEmail")
	@PostMapping("/myMobile")
	@ResponseBody
	public ResponseEntity<String> getNewMobile(@ModelAttribute MemberVO member) {
		String result="";
		if(service.updateMobileService(member)) {
			result="y";
		} else {
			result="n";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
		
	}

	//회원 탈퇴
	@PreAuthorize("isAuthenticated() && principal.username == #userEmail")
	@PostMapping("/bye")
	public String deleteMem(String userEmail) {
		service.deleteMemberService(userEmail);
		
		return "redirect:/shop/index"; //나중에 메인홈피 주소 추가되면 여기에 추가하기
	}

	@PostMapping("/resetPw")
	public String resetPW(String userEmail) {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
                'u', 'v', 'w', 'x', 'y', 'z'};

        String str = "";

        int idx = 0;
        for (int i = 0; i < 6; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
        }
        MemberVO member = new MemberVO();
        
        member.setUserEmail(userEmail);
        member.setUserPW(str);
        getNewPw(member);
        
        String setFrom = "goott_test@naver.com";
		String toMail = userEmail;
		String title = "Mangle a Dream의 임시 비밀번호 안내입니다..";
		String content = "당신의 임시 비밀번호는 "+ str +" 입니다. 로그인 후 비밀번호를 변경해주세요.";
		

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper;			
			helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return "redirect:/login";
	}
}
