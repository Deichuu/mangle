package com.dream.mangle.test_datasource;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)//데이터소스 테스트할때는 이 파일.
@ContextConfiguration({"file:src\\main\\webapp\\WEB-INF\\spring\\mybatis-context.xml"})
//빈 구성파일 액세스. 지금은 하나만 적지만 세개 적을수도.
//테스트에 이 두 줄이 반드시 들어간다. 톰캣이 없어도 돌아가게끔
@Log4j//로그로 남긴다.
public class DataSourceTests {
	
	private DataSource dataSource ;
	
	@Autowired//자동 주입
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;//생성자 방법으로 주입할 수는 없다. 따라서 junit 테스트할때 setter방식으로 테스트하자.
	}
//	
//	@Setter(onMethod_ = @Autowired)//롬복. 위의 세 줄을 대체합니다. 컴파일될때 위의 세줄처럼 바뀝니다.
//	private DataSource dataSource ;	//주입받을 빈의 아이디와 같아서 자동으로 주입된다.
//
//	//반드시 한번에 하나만 테스트해라. 테스트 할 각각의 메소드는 다 @테스트를 붙여준다.
	@Test
	public void testConnection() {
		try {
			Connection con = dataSource.getConnection();
			log.info(con);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
//	@Setter(onMethod_ = {@Autowired})
//	private SqlSessionTemplate sqlSession;
	
//	//{}안에 두개 이상 어노테이션 작성 가능
//	
//	@Test
//	public void testMyBatis() {
//		//templete까지 쓸때
//		Connection con = sqlSession.getConnection();
//		log.info(sqlSession);
//	}
	
//	@Setter(onMethod_ = @Autowired)
//	private SqlSessionFactory sqlSessionFactory;
//	
//	@Test
//	public void testMyBatis2() {
//		//factory
//		SqlSession sqlSession = sqlSessionFactory.openSession();
//		
//		log.info(sqlSession);
//	}
	
}
