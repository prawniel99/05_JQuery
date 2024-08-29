package kr.or.ddit.member.dao;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;

public interface IMemberDao {
	
    // 멤버리스트 가져오기
    public List<MemberVO> selectAllMember();
    
}
