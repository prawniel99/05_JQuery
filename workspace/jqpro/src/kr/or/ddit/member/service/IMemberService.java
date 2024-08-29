package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public interface IMemberService {

    // 멤버리스트 가져오기
    public List<MemberVO> selectAllMember();
    
    // id 중복검사
    public String idCheck(String id);
    
    // 우편번호 찾기
    public List<ZipVO> selectByDong(String dong);
    
    // 저장 가입하기
    public int insertMember(MemberVO vo);
    
}
