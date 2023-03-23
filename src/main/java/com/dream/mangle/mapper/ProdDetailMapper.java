package com.dream.mangle.mapper;

import com.dream.mangle.domain.ProdDetailVO;
import com.dream.mangle.domain.ProductVO;

public interface ProdDetailMapper {

	//상세그림 가져오려고
	public ProdDetailVO selectProdScript(String prodCode);
}
