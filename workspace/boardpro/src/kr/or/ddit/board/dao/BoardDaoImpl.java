package kr.or.ddit.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReplyVO;
import kr.or.ddit.mybatis.config.MybatisUtil;

public class BoardDaoImpl implements IBoardDao {
	
	// 싱글톤
	private static IBoardDao dao;
	
	// 생성자 만들어서 생성자 못만들게 하기
	private BoardDaoImpl() {}
	
	// 인스턴스 만들기?
	public static IBoardDao getDao() {
		if(dao == null) dao = new BoardDaoImpl();
		
		return dao;
	}

	@Override
	public List<BoardVO> selectBoardList(Map<String, Object> map) {
		
		// 1. 선언
		List<BoardVO> list = null;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			list = sql.selectList("board.selectBoardList", map);
			// 자 이 list를 봐봐. list에 담겠다. 타입은 BoardVO.
			// sql문을 실행하려는 명령이잖아. 그러니까 sqlsession인 변수 sql을 사용했고,
			// 여러개 값을 가져오니까 selectList 했고, 자 그럼 이게 sql문 실행해서 db에서 가져오겠다인데
			// db에서 값 출력하는게 뭐야? 쿼리지. 쿼리 어디 써뒀어? mapper xml에 써놨지.
			// config에서 설정을 해뒀고, board.xml 만들어서 거기안에 mapper 태그 해서 만들었잖아.
			// 매퍼라는게 xml이 매퍼가 아니고, xml은 파일 양식이고,
			// 그 안에서 mapper 라는 태그를 사용해서, 이 매퍼 전체는 namespace라는 것으로 이름을 지어줬고,
			// 그래서 namespace를 쓰면 그 매퍼 전체 세트를 불러오는거고
			// 그 안에서 각각의 mapper에다가 id를 줬지.
			// html에서 하는것처럼.
			// 그래서 그렇게 mapper id를 사용해서 불러. 그러면 그 쿼리가 실행이 되는거지.
			// 그럼 map은 왜 줌? map이 하이튼 뭐 담고있고 그거 주는건데 이거 알아야하네.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return list;
	}

	// board.xml에서 게시글 개수 찾기
	@Override
	public int countBoard(Map<String, Object> map) {
		// 1. 선언
		int list = 0;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			list = sql.selectOne("board.countBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return list;
	}

	// reply.xml에서 글 집어넣기
	@Override
	public int insertReply(ReplyVO vo) {
		// 1. 선언
		int list = 0;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			list = sql.insert("reply.insertReply", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return list;
	}

	// reply.xml에서 댓글 전체 목록 가져오기
	@Override
	public List<ReplyVO> selectByReply(int bonum) {
		
		// 1. 선언
		List<ReplyVO> list = null;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			list = sql.selectList("reply.selectByReply", bonum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return list;
	}

	@Override
	public int insertBoard(BoardVO vo) {
		// 1. 선언
		int cnt = 0;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			cnt = sql.insert("board.insertBoard", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return cnt;
	}

	@Override
	public int updateHit(int num) {
		// 1. 선언
		int cnt = 0;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			cnt = sql.update("board.updateHit", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return cnt;
	}

	@Override
	public int deleteBoard(int num) {
		// 1. 선언
		int cnt = 0;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			cnt = sql.delete("board.deleteBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return cnt;
	}

	@Override
	public int updateBoard(BoardVO vo) {
		// 1. 선언
		int cnt = 0;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			cnt = sql.update("board.updateBoard", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return cnt;
	}

	@Override
	public int updateReply(ReplyVO vo) {
		// 1. 선언
		int cnt = 0;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			cnt = sql.update("reply.updateReply", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return cnt;
	}

	@Override
	public int deleteReply(int num) {
		// 1. 선언
		int cnt = 0;
		SqlSession sql = null;
		
		// 2. 실행
		try {
			sql = MybatisUtil.getSqlSession();
			cnt = sql.delete("reply.deleteReply", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		// 3. 리턴
		return cnt;
	}

}
