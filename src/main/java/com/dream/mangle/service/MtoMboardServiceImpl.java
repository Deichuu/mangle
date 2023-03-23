package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.MtoMboardVO;
import com.dream.mangle.domain.UploadFileVO;
import com.dream.mangle.mapper.BoardAttachFileMapper;
import com.dream.mangle.mapper.MtoMboardMapper;

@Service
public class MtoMboardServiceImpl implements MtoMboardService{
	//매퍼 인터페이스 주입: 생성자를 이용한 자동 주입
		private MtoMboardMapper boardMapper ;
		
		private BoardAttachFileMapper boardAttachFileMapper ;
		
		public MtoMboardServiceImpl(MtoMboardMapper boardMapper, 
				                  BoardAttachFileMapper boardAttachFileMapper) {
			this.boardMapper = boardMapper ;
			this.boardAttachFileMapper = boardAttachFileMapper ;
		}

		
		//게시물 조회 - 목록
		@Override
		//public List<MyBoardVO> getBoardList() {
		public List<MtoMboardVO> getBoardList(PagingDTO boardPagingDTO) {
			//List<MyBoardVO> boardList = myBoardMapper.selectMyBoardList() ;
			//return boardList;
			return boardMapper.selectBoardList(boardPagingDTO) ;
		}
		
		
		@Override
		public long getTotalRowCnt(PagingDTO boardPagingDTO) {
			return boardMapper.selectTotalRowCnt(boardPagingDTO) ;
		}
		
		public List<MtoMboardVO> getReplyList(){
			return boardMapper.selectReplyList();
		}
		

		//게시물 등록 - selectKey 이용
		@Transactional
		@Override
		public Long registerBoard(MtoMboardVO board) {
			
			System.out.println("서비스로 전달된 MtoMboardVO: " + board);		
			boardMapper.insertBoardSelectKey(board) ;
			System.out.println("저장이된 뒤 다음 MtoMboardVO: " + board);		
			//log.info("등록된 게시물의 bno 값: " + myBoard.getBno());
			
			//첨부파일이 없는 경우, 메서드 종료
			if (board.getUploadFileList() == null || board.getUploadFileList().size() <= 0) {
				return board.getBno();
			}
			
			//첨부파일이 있는 경우, myBoard의 bno 값을 첨부파일 정보 VO에 저장 후, tbl_myAttachFiles 테이블에 입력
			board.getUploadFileList().forEach(
					
					attachFile -> {
						attachFile.setMtombno(board.getBno());
						boardAttachFileMapper.insertUploadFile(attachFile);
					}
			);
			
			return board.getBno();
		}

		
		//답글 등록 - selectKey 이용
		@Transactional
		@Override
		public Long registerReply(MtoMboardVO board) {
			System.out.println("서비스로 전달된 MtoMboardVO: " + board);		
			boardMapper.insertMtomReply(board) ;
			System.out.println("저장이된 뒤 다음 MtoMboardVO: " + board);		
			//log.info("등록된 게시물의 bno 값: " + myBoard.getBno());
			
			//첨부파일이 없는 경우, 메서드 종료
			if (board.getUploadFileList() == null || board.getUploadFileList().size() <= 0) {
				return board.getBno();
			}
			
			//첨부파일이 있는 경우, myBoard의 bno 값을 첨부파일 정보 VO에 저장 후, tbl_myAttachFiles 테이블에 입력
			board.getUploadFileList().forEach(
					
					attachFile -> {
						attachFile.setMtombno(board.getBno());
						boardAttachFileMapper.insertUploadFile(attachFile);
					}
			);
			
			return board.getBno();
		}
		
			
		//특정 게시물 조회(조회수 증가 고려)
		@Override
		public MtoMboardVO getBoard(long bno) {
			//log.info("서비스로 전달된 bno: " + bno);
			boardMapper.updateBviewsCnt(bno);
			return boardMapper.selectBoard(bno) ;
		}
		
		
		//특정 게시물 조회 시, 게시물의 첨부파일 정보를 조회
		@Override
		public List<UploadFileVO> getAttachFiles(long bno) {
			return boardAttachFileMapper.selectUploadFileList(bno) ;
		}
		
		
		//게시물 조회: 게시물 조회 페이지 -> 게시물 수정 페이지 호출(by bno), 조회수 변화 없음
	    //게시물 조회: 게시물 수정 후 -> 게시물 조회 페이지 호출(by bno), 조회수 증가 없음
		@Override
		public MtoMboardVO getBoardDetailModify(long bno) {
			return boardMapper.selectBoard(bno) ;
		}
		
		
		//특정 게시물 수정
		@Transactional
		@Override
		public boolean modifyBoard(MtoMboardVO board) {
			System.out.println("서비스로 전달된 MtoMboardVO: " + board);
			
			long bno = board.getBno() ;
			
			//게시물 변경 시, 기존 첨부파일이 삭제와 새로운 첨부파일 추가를 모두 고려하여, 기존 DB의 정보를 모두 삭제 후,
			//첨부파일 정보를 DB에 다시 추가하는 방식으로 처리합니다.
			//기존 DB 첨부파일 정보 삭제
		
			boolean boardModifyResult = boardMapper.updateBoard(board) == 1 ;

			if ((boardModifyResult && board.getUploadFileList() != null)) {
				boardAttachFileMapper.deleteBoardUploadFiles(bno);
				board.getUploadFileList().forEach(
						
						attachFile -> {
							attachFile.setMtombno(board.getBno());
							boardAttachFileMapper.insertUploadFile(attachFile);
						}
				);	
				
			}
			
			return boardModifyResult;
		}

		
		//특정 게시물 삭제 - 실제 삭제
		@Transactional
		@Override
		public boolean removeBoard(long bno) {
			boardAttachFileMapper.deleteBoardUploadFiles(bno);
			System.out.println("서비스로 전달된 bno: " + bno);
			return boardMapper.deleteBoard(bno) == 1;
		}

		
		//특정 게시물 삭제 요청 - 해당 글의 bdelFlag을 1로 수정
		@Transactional
		@Override
		public boolean setBoardDeleted(long bno) {
			System.out.println("서비스로 전달된 bno: " + bno);
			//myBoardAttachFileMapper.deleteBoardAllAttachFiles(bno);
			return boardMapper.updateBdelFlag(bno) == 1;
		}

		
		//게시물 삭제(관리자) – 사용자 삭제 요청된 게시물(bdelFlag = 1) 전체 삭제
//		@Override
//		public int removeAllDeletedBoard() {
	//
//			return boardMapper.deleteAllBoardSetDeleted() ;
//		}
}
