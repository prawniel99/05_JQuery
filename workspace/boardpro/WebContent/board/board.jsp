<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

  <!-- bootstrap -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- 외부 스크립트 -->
  <!-- jquery -->
  <script src="../js/jquery-3.7.1.js"></script>
  
  <script src="../js/board.js"></script>
  <script src="../js/jquery.serializejson.min.js"></script>

	<style>
		html, body {padding:-10; margin:-10; height:100%; width: 100%;   }
		
		body *{
		  box-sizing:   border-box;
		}
		
		body{
		  min-width : 1000px;
		}
		/* #result{
		  width : 100%;
		  padding : 1px;
		} */
		.container{
		   margin : 5px;
		   max-width : 99%;
		}
		.p12{
		  display: flex;
		  flex-direction:  row;
		}
		p{
		   border  : 1px dotted lightgray;
		   padding : 5px;
		   margin  :2px;
		}
		.p1{
		   flex:  70%;
		   word-break:keep-all; /* 줄바꿈: 단어단위로  */
		}
		.p2{
		   flex : 30%;
		   text-align:  right;
		}
		
		.card-body{
		   display:  flex;
		   flex-direction:  column;
		}
		input[name=reply]{
		   height : 55px;
		   vertical-align: top;
		}
		textarea {
			width : 70%;
		}
		
		nav {
		  margin: 2%;
		}
		
		nav a{
		 visibility: hidden;
		}
		#pagelist{
		   margin-left : 10%;
		}
		
		.card-header:hover{
		  background : #0078FF;
		}
		
		.reply-body{
		  border : 1px dotted orange;
		  background : #efdada;
		  margin : 2px;
		  padding : 2px;
		}
		
		.modal label{
		  width : 100px;
		  height : 30px;
		}
		
		span.pa{
		 display : none;/* listPageServer에서 password  를 안보이도록*/
		}
		
		#modifyform{
		  display: none;
		}
		#btnok, #btnreset{
		  height : 40px;
		  vertical-align: bottom;
		}
	</style>


<%

	// 로그인 상태
	MemberVO vo = (MemberVO)session.getAttribute("loginok");

	String ss = null;
	
	Gson gson = new Gson();
	if(vo != null) ss = gson.toJson(vo);
	/*
		ss = {"mem_id" : "a001" , "mem_pass" : "asdfasdf" , "mem_name" : "김은대"}
		이런식으로 만들어서 가져온거지
	*/
	
	

%>



	<script>
		//JSP 실행 순서가  Java =>  => HTML => javascript
		
		//자바스크립트 객체 빈걸로 만들 수 있고, 동적으로 속성 추가하여 변경되도록 할 수 있음
		reply = {};
		
		uvo = <%= ss %>
		currentPage = 1;
		mypath = '<%= request.getContextPath()%>';
		
		
		$(function(){
			// js 파일의 함수를 호출
			$.listPageServer();
			
			// 다음 버튼 이벤트
			// $('#next') // 이거 안됨. 처음부터 만들어진게 아니라, 추가로 만들어진거라서 안됨
			// deligate 방식으로 만들어야 함
			$(document).on('click', '#next', function(){
				// 나열되어 있는 페이지 번호들의 마지막 값을 가져온다
				// $() 이걸로 가져온건 string이 되기 때문에 정수로 바꾸고 더하기 1
				currentPage = parseInt($('.pageno').last().text()) + 1;
				$.listPageServer();
			})
			// 위에꺼는 처음이니까 page가 무조건 1이지만, 다음 버튼 이벤트는 이게 계속 바뀌니까 계산을 해줘야 하는거
			
			// 이번 버튼 이벤트
			$(document).on('click', '#prev', function(){
				// 나열되어 있는 페이지 번호들의 마지막 값을 가져온다
				// $() 이걸로 가져온건 string이 되기 때문에 정수로 바꾸고 더하기 1
				// currentPage = parseInt($('.pageno').first().text()) - 1; // parseInt는 더하기 할때만 필요함
				currentPage = $('.pageno').first().text() - 1;
				$.listPageServer();
			})
			
			// 페이지 번호 클릭 이벤트
			$(document).on('click', '.pageno', function(){
				// 클릭한 페이지에서 가져오는거니까 this이다. 읭?
				currentPage = $(this).text();
				$.listPageServer();
			})
			
			// 검색어 입력 후 검색버튼 클릭 이벤트
			$(document).on('click', '#search', function(){
				currentPage = 1;
				$.listPageServer();
			})
		})
		
		// 수정, 삭제, 댓글쓰기, 댓글리스트(제목, 등록), 댓글수정, 댓글삭제 (클릭한게 this가 됨)
		$(document).on('click', '.action', function(){
			
			target = $(this); // 이렇게 해서 this가 뭔지 담아준다. 다른곳에서도 쓰게.
			
			vname = $(this).attr('name');
			vidx = $(this).attr('idx');
			
			if (vname == "reply") {
				// alert(vidx + "번 글에 댓글을 답니다");
				// 비로그인 시 댓글 등록 불가능
				if(uvo == null) {
					alert("로그인 하세요");
					return;
				}
				
				// 입력한 댓글내용을 가져온다
				vcont = $(this).prev().val().trim();
				
				// 저장할 데이터 수집 renum bonum cont
				// 위에서 만들어둔 빈 스크립트 객체 reply, 동적으로 속성 추가하기
				reply.bonum = vidx;
				reply.name = uvo.mem_name;
				reply.cont = vcont;
				
				// 전송 - board.js의 함수를 호출
				$.replyWriteServer();
				
				// 댓글 리스트 가져오기 // 비동기니까 데이터도 안가져왔는데 출력부터 해버릴려고 할 수 있음
				// 그래서 ajax에서 해야함
				
			} else if (vname == "modify") {
				alert(vidx + "번 글을 수정합니다");
			} else if (vname == "delete") {
				alert(vidx + "번 글을 삭제합니다");
			} else if (vname == "title") {
				// vidx에 관련된 댓글 리스트 가져오기
				// 함수 호출
				$.replyListServer();
				
				// 조회수 증가하기
			}
		
		})
	</script>

</head>
<body>

 <div id="modifyform">
<textarea rows="5" cols="50"></textarea>
<input type="button" value="확인" id="btnok">
<input type="button" value="취소" id="btnreset">
</div>
 
  <br>
  <!--  <input type="button" data-bs-toggle="modal" data-bs-target="#wModal"  id="write" value="글쓰기">  -->
<!--  <input type="button" id="write" value="글쓰기"> -->
  <BR>
  <br>
   <nav class="navbar navbar-expand-sm navbar-dark bg-primary">
  <div class="container-fluid">
  <input type="button" id="write" value="글쓰기">
    <a class="navbar-brand" href="javascript:void(0)">Logo</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mynavbar">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
      </ul>
      <form class="d-flex">
      
      <select class="form-select" id="stype">
		  <option value="">전체</option>
		  <option value="writer">작성자</option>
		  <option value="subject">제목</option>
		  <option value="content">내용</option>
	  </select>
      
        <input class="form-control me-2" type="text" id="sword" placeholder="Search">
        <button id="search" class="btn btn-primary" type="button">Search</button>
      </form>
    </div>
  </div>
</nav>
   
   

   <!-- 리스트 3개씩을 출력 -->
   <div id="result"></div>
   
   <br>
   <br>
   
   <!-- 페이지정보를 출력  -->
   <div id="pagelist"></div>
   
   
<!------- 글쓰기   The Modal  ------- -->
<div class="modal" id="wModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">게시글 작성하기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
       
       <form name="wfrom" id="wform">
            <label>이름</label>
            <input type="text" class="txt" id="writer" name="writer"> <br> 
            
            <label>제목</label>
            <input type="text" class="txt" id="subject" name="subject"> <br> 
            
            <label>메일</label>
            <input type="text"  class="txt" id="mail" name="mail"> <br> 
            
            <label>비밀번호</label>
            <input type="password"  class="txt" id="password"   name="password"> <br> 
            
            <label>내용</label>
            <br>
            <textarea rows="5" cols="40"  class="txt" id="content"  name="content"></textarea>
            <br>
            <br>
            <input type="button" value="전송" id="send">
        </form>
       
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
   
  
  
<!----- 글 수정  The Modal    ----->
<div class="modal" id="uModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">게시글 수정하기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
       
       <form name="ufrom" id="uform">
       
            <input type="hidden" id="unum" name="num">
            <label>이름</label>
            <input type="text" class="txt" id="uwriter" name="writer"> <br> 
            
            <label>제목</label>
            <input type="text" class="txt" id="usubject" name="subject"> <br> 
            
            <label>메일</label>
            <input type="text"  class="txt" id="umail" name="mail"> <br> 
            
            <label>비밀번호</label>
            <input type="password"  class="txt" id="upassword"   name="password"> <br> 
            
            <label>내용</label>
            <br>
            <textarea rows="5" cols="40"  class="txt" id="ucontent"  name="content"></textarea>
            <br>
            <br>
            <input type="button" value="전송" id="usend">
        </form>
       
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
  
   
</body>
</html>











