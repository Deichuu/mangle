package com.dream.mangle.test_datasource;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dream.mangle.domain.OrderVO;
import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.mapper.DeliveryMapper;
import com.dream.mangle.mapper.OrderMapper;
import com.dream.mangle.mapper.ProductMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
//import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/mybatis-context.xml")
@Log4j
public class MyBoardMapperTests {
	
    @Setter(onMethod_ = @Autowired)
    private OrderMapper mapper;
    
//    @Test
//    public void testInsertMyMemAuthority() {
//    
//    	List<ProductVO> list = myBoardMapper.selectProdList("1");
//    	
//	    	for(int i = 0; i < 10; i++) {
//	    		
//		    	ProductVO prod = new ProductVO();
//		    	String prodCode = prod.getProdCode();
//		    	prod.setProdCode(prodCode+"-R");
//	    	
//	    	}
//    	}
    //오더데이터 입력
    @Test
    public void testOrder() {
    	OrderVO orderVO = new OrderVO();
    	for(int i = 1; i<13; i++) {
    		
    		for(int j = 1; j<28; j++) {
    			LocalDate date = LocalDate.of(2022, i, j);
    			String datetime = date+"12";
    		}
    	}
    	
    	
    }
  
}
