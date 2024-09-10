package kr.or.ddit.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.dao.BoardDaoImpl;
import kr.or.ddit.board.dao.IBoardDao;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageVO;
import kr.or.ddit.board.vo.ReplyVO;

public class BoardServiceImpl implements IBoardService {
	
	// 싱글톤
	private static IBoardService service;
	// 자기 스스로 객체를 먼저 만들고, 외부에서 getService 하면 다 먼저 만든 그 객체로 만드는건가
	// 그렇게 객체를 한개로 유지하는건가? 그런거 같긴한데.
	public static IBoardService getService() {
		if(service == null) service = new BoardServiceImpl();
		
		return service;
	}
	
	// dao 객체가 필요하다
	private IBoardDao dao;
	// 왜 필요하냐고? service에서 받아온 데이터를 dao한테 넘겨주면서 실행시켜야 하니까.
	// dao를 불러야 하니까 dao 객체가 필요한거지
	
	// 생성자. boardserviceimpl은 객체를 생성하면 dao 객체를 자동으로 생성하도록 만드는거.
	private BoardServiceImpl() {
		dao = BoardDaoImpl.getDao();
	}

	@Override
	public PageVO pageInfo(int page, String stype, String sword) {
		
		PageVO pvo = new PageVO();
		
		// 전체 글 개수 가져오기
		// map설정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stype", stype);
		map.put("sword", sword);
		// 여기서는 값이 있는지 없는지 판단하지 않고 무조건 보냄
		
		// 전체 글 개수 가져오기
		int count = this.countBoard(map);
		
		// 전체 페이지 수 구하기
		int perList = PageVO.getPerList();
		int totalPage = (int)Math.ceil((double)count / perList); // 더블로 바꿔서 두개 나누고, Math.ceil로 올려주고, 정수로 바꾸고
		
		
		// 마지막 페이지(예, 7)에서 마지막 데이터를 지웠을때
		// page변수는 7(마지막페이지) -totalPage = 6으로 바뀜
		if(page > totalPage) page = totalPage;
		// 이게 핵심. 이거 없으면 그냥 계속 초기 값으로 계산을 하게 됨.
		
		
		// start, end
		int start = (page - 1) * perList + 1;
		int end = start + perList - 1;
		
		if(count < end) end = count; // 마지막껄 넘어가면 안되니까, 값 맞춰주는거
		
		// startPage, endPage 1 2 / 3 4 / 5 6 / ..
		int perPage = PageVO.getPerPage();
		int startPage = ((page - 1) / perPage * perPage) + 1;
		int endPage = startPage + perPage - 1;
		if(endPage > totalPage) endPage = totalPage;
		
		pvo.setStart(start);
		pvo.setEnd(end);
		pvo.setStartPage(startPage);
		pvo.setEndPage(endPage);
		pvo.setTotalPage(totalPage);
		
		return pvo;
	}

	@Override
	public List<BoardVO> selectBoardList(Map<String, Object> map) {
		return dao.selectBoardList(map);
	}

	@Override
	public int countBoard(Map<String, Object> map) {
		return dao.countBoard(map);
	}

	@Override
	public int insertReply(ReplyVO vo) {
		return dao.insertReply(vo);
	}

	@Override
	public List<ReplyVO> selectByReply(int bonum) {
		return dao.selectByReply(bonum);
	}

	@Override
	public int insertBoard(BoardVO vo) {
		return dao.insertBoard(vo);
	}

	@Override
	public int updateHit(int num) {
		return dao.updateHit(num);
	}

	@Override
	public int deleteBoard(int num) {
		return dao.deleteBoard(num);
	}

	@Override
	public int updateBoard(BoardVO vo) {
		return dao.updateBoard(vo);
	}

	@Override
	public int updateReply(ReplyVO vo) {
		return dao.updateReply(vo);
	}

	@Override
	public int deleteReply(int num) {
		return dao.deleteReply(num);
	}
}
