package kr.or.ddit.board.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageVO;
import kr.or.ddit.board.vo.ReplyVO;

public interface IBoardService {

	// 페이지 정보 계산
	public PageVO pageInfo(int page, String stype, String sword);
	// 얘는 왜 맵 아니고 그냥? 왜냐하면 얘는 db 안가고 service에서 끝나니까. 오오?
	// 왜 그런지 이해 안됨.
	// 이해 되면 주석 정리할 것.
	// 과연..
	
	// 글 리스트 가져오기
	public List<BoardVO> selectBoardList(Map<String, Object> map);
	// stype, sword, start, end 이렇게 네가지 값을 가져와야 함
	// 근데 여기에는 그렇게 없기 때문에, 외부에서 가져오면 되는데, Map으로 가져오면 됨
	// 이거 내가 직접 생각 가능? 흠..
	
	// 글 개수 구하기
	public int countBoard(Map<String, Object> map);
	
	// 글쓰기
	public int insertBoard(BoardVO vo);
	
	// 글삭제
	public int deleteBoard(int num); // 번호 하나만 있으면 지울 수 있으니 int
	
	// 글수정
	public int updateBoard(BoardVO vo); // 여러가지 값이 필요하니까 BoardVO
	
	// 조회수 증가
	public int updateHit(int num); // 글 번호 하나만 있으면 가능하니까 int
	
	// 댓글쓰기
	public int insertReply(ReplyVO vo);
	
	// 댓글수정
	public int updateReply(ReplyVO vo); // 수정이나 작성은 전부 vo네.
	
	// 댓글삭제
	public int deleteReply(int num); // 이것도 숫자 하나만 있으면 지울 수 있으니.
	
	// 댓글리스트
	public List<ReplyVO> selectByReply(int bonum);
	
	
}























