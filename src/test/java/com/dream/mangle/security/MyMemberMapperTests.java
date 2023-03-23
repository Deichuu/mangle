package com.dream.mangle.security;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.dream.mangle.domain.AuthorityVO;
import com.dream.mangle.domain.MemberVO;
import com.dream.mangle.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/mybatis-context.xml",
 "file:src/main/webapp/WEB-INF/spring/security-context.xml",
 "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@Log4j
public class MyMemberMapperTests {
 //사용자 패스워드 암호화
 @Setter(onMethod_ = @Autowired)
 private PasswordEncoder pwencoder;
 
 @Setter(onMethod_ = @Autowired)
 private MemberMapper MemberMapper;
// 회원 등록 테스트: 테스트(1)
// @Test
// public void testInsertMyMember() {
// 
// MemberVO myMember = new MemberVO();
// 
// for(int i = 0; i < 10; i++) {
// myMember.setUserPW(pwencoder.encode("pw" + i));
// if(i < 5) {
// myMember.setUserEmail("user" + i);
// myMember.setUserName("일반사용자" + i);
// myMember.setUserMobile("0101212111"+i);
// 
// } else if (i < 7) {
// myMember.setUserEmail("artist" + i);
// myMember.setUserName("작가" + i);
// myMember.setUserMobile("0101212111"+i);
// 
// } else {
// myMember.setUserEmail("admin" + i);
// myMember.setUserName("관리자" + i);
// myMember.setUserMobile("0101212111"+i);
// }
// 
// log.info(myMember); 
// MemberMapper.insertMember(myMember);
// } //for-End
// }
 
 //회원 권한 등록 테스트: 테스트(2)
 @Test
 public void testInsertMyMemAuthority() {
 AuthorityVO myAuthority = new AuthorityVO();
 
 for(int i = 0; i < 10; i++) {
 if(i < 5) {
 myAuthority.setUserEmail("user" + i);
 myAuthority.setAuthority("USER");
 
 } else if (i < 7) {
 myAuthority.setUserEmail("artist" + i);
 myAuthority.setAuthority("ILLUSTRATOR");
 
 } else {
 myAuthority.setUserEmail("admin" + i);
 myAuthority.setAuthority("ADMIN");
 
 }
 log.info(myAuthority);
 MemberMapper.insertMemberAuthority(myAuthority);
 } //for-End
// 
// myAuthority.setUserEmail("admin99");
// myAuthority.setAuthority("ROLE_MEMBER");
// MemberMapper.insertMemberAuthority(myAuthority);
// 
// myAuthority.setUserEmail("admin99");
// myAuthority.setAuthority("ROLE_USER");
// MemberMapper.insertMemberAuthority(myAuthority);
// 
// myAuthority.setUserEmail("admin91");
// myAuthority.setAuthority("ROLE_MEMBER");
// MemberMapper.insertMemberAuthority(myAuthority);
 }
// 
// //회원 정보 조회 테스트: 테스트(3)
// @Test
// public void testRead() {
// MemberVO myMember = MemberMapper.selectMember("test1@goott.com");
// log.info(myMember);
// 
// myMember.getAuthorityList().forEach(authorityVO -> log.info(authorityVO));
// }
}
