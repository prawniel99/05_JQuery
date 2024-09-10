package kr.or.ddit.board.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReplyVO;

public interface IBoardDao {
	
	// 글 리스트 가져오기
	public List<BoardVO> selectBoardList(Map<String, Object> map);
	
	// 글 개수 구하기
	public int countBoard(Map<String, Object> map);

	// 글쓰기
	public int insertBoard(BoardVO vo);
	
	// 글삭제
	public int deleteBoard(int num);
	
	// 글수정
	public int updateBoard(BoardVO vo); 
	
	// 조회수 증가
	public int updateHit(int num);
	
	// 댓글쓰기
	public int insertReply(ReplyVO vo);
	
	// 댓글수정
	public int updateReply(ReplyVO vo);
	
	// 댓글삭제
	public int deleteReply(int num);
	
	// 댓글리스트
	public List<ReplyVO> selectByReply(int bonum);
	
}
