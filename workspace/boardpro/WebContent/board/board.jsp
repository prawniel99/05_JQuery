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
		mypath = '<%=request.getContextPath()%>'; // 이렇게 mypath로 간단하게 만들어두고 해놓고 여기저기서 다 씀.
		
		
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
			
			// 이전 버튼 이벤트
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
					$(this).prev().val("");
					
					// 댓글 리스트 가져오기 // 비동기니까 데이터도 안가져왔는데 출력부터 해버릴려고 할 수 있음
					// 그래서 ajax에서 해야함
					
				} else if (vname == "modify") {
					alert(vidx + "번 글을 수정합니다");
					
					// 원글의 내용을 가져온다
					// 수정버튼을 기준으로 공통조상 찾기
					vcard = $(this).parents('.card');
					vtitle = $(vcard).find('a').text().trim();
					vname = $(vcard).find('.wr').text().trim();
					vmail= $(vcard).find('.em').text().trim();
					vcont= $(vcard).find('.p3').html().trim(); // <br> 태그가 포함
					// 수정후 새로 가져가서 출력은 title, mail, cont
					
					vcont = vcont.replaceAll(/<br>/g, "");
					
					// 모달창에 출력한다
					$('#uwriter').val(vname);
					$('#usubject').val(vtitle);
					$('#umail').val(vmail);
					$('#ucontent').val(vcont);
					$('#unum').val(vidx);
					
					// 이름 수정 불가
					$('#uwriter').prop('readonly', true);
					
					// 모달창 실행
					$('#uModal').modal('show');
					
					// 전송버튼 클릭 별도로 작성
					
					
				} else if (vname == "delete") {
					// alert(vidx + "번 글을 삭제합니다");
					
					// 함수 호출. board.js에 있는거.
					$.deleteBoardServer();
					
				} else if (vname == "title") {
					// vidx에 관련된 댓글 리스트 가져오기
					// 함수 호출
					$.replyListServer();
					
					// 조회수 증가하기 - board.js 함수 호출
					vhit = $(this).attr('aria-expanded');
					// if(vhit) // 이렇게 하면 boolean타입 true false 하는건데, 요거는 문자열이라서 이렇게 하면 안됨
					if(vhit == "true") {
						$.updateHitServer();
						// 화면수정. 여기서 해버리면, 비동기라서 문제가 있을 수 있음.
					}
				} else if (vname == "r_modify") {
					alert(vidx + "댓글을 수정합니다")
					
					
					// 댓글 수정폼이 열려있는지 검사
					// 만약 열려 있다면 body로 반납하고 body에서 수정폼을 다시 가져온다
					// 반납시에는 원래 내용을 rp3에 그대로 출력
					// 이거는 원래는 필요 없었는데, 댓글 수정창 연 상태로 다른 댓글수정 누르니까 내용 사라지는 것 때문에 추가로 만드는 것
					if($('#modifyform').css('display') != 'none') {
						// 'display', 'none'이렇게 하면 display를 none으로 한 값을 가져오는것이고,
						// != 이렇게 해줘야, 저게 none이면, 이 되는거
						// 어쨌든 이러면 수정폼이 어딘가에 열려 있다는 말
						replyReset();
					}
					
					// 버튼(this)를 기준으로 rp3을 찾는다
					vp3 = $(this).parents('.reply-body').find('.rp3');
					
					// 원래 댓글 내용을 가져온다 - <br>태그가 포함되어있음
					// 원래 내용을 보관하고 있어야 한다.
					modifycont = vp3.html().trim();
					
					// <br>태그를 \n으로 변경
					// 댓글 수정 했다가 '취소'를 누를수도 있기 때문에 원래 내용을 가지고 있어야한다.
					mcont = modifycont.replaceAll(/<br>/g, "\n");
					
					// 수정폼의 textarea에 출력
					$('#modifyform textarea').val(mcont);
					
					// 수정폼을 rp3으로 이동 - body의 수정폼은 없어진다
					$(vp3).empty().append($('#modifyform')); // 위에 나오는건 modifyform 앞에 # 없어서. 왜 그렇게 되지?
					// 이거 $(vp3)에 달러괄호 빼면 이상해짐. 달러괄호 아직도 뭔지 잘 모르네.
					
					// 수정폼을 보이게 한다
					$('#modifyform').show();
					
				} else if (vname == "r_delete") {
					alert(vidx + "댓글을 삭제합니다")
					
					// js함수 호출
					$.deleteReply();
				}
			})
			// action 이벤트 끝
			
			// 댓글수정 폼에서 취소버튼 클릭
			$('#btnreset').on('click', function() {
				replyReset();
			})
			
			replyReset = function() {
				// 수정폼을 기준으로 rp3
				vrp3 = $('#modifyform').parent();
				
				// 수정폼을 body로 이동 - append
				$('#modifyform').appendTo($('body'));
				
				// 수정폼을 안보이도록 설정
				$('#modifyform').hide();
				
				// 원래 내용을 modifycont(댓글 수정 클릭시) 다시 rp3으로 출력
				$(vrp3).html(modifycont);
			}
			
			// 댓글수정 폼에서 확인버튼 클릭
			$('#btnok').on('click', function() {
				// 새롭게 입력된(수정내용)을 가져온다 - 서버로 전송할 내용(db에 저장) - 엔터가 포함되어 있다.
				modicont = $('#modifyform textarea').val().trim();
				
				// 엔터를 <br>태그로 바꾼다 - 화면에 변경할 내용 - db저장 성공 후 success 콜백함수에서 실행해야한다. 안그럼 바뀌지도 않았는데 변경됨.
				modiout = modicont.replaceAll(/\n/g, "<br>");
				
				// 수정폼을 기준으로 rp3을 검색
				vp3 = $('#modifyform').parent();
				// $(vp3).html(modiout); // 화면변경 - success콜백에서 실행
				
				// 수정폼을 body로 보냄 - 안보이도록 설정
				$('body').append($('#modifyform'));
				$('#modifyform').hide();
				
				// 서버로 전송할 data를 수집
				reply.cont = modicont;
				reply.renum = vidx;
				
				// js함수를 호출
				$.replyUpdateServer();
				
				
			})
			
			// 수정 모달창에서 전송 버튼 클릭하면. update니까 u 인거다
			$('#usend').on('click', function(){
				// 입력한 모든 값을 가져온다
				udata = $('#uform').serializeJSON();
				console.log(udata);
				
				// 모달창에 입력된 내용 지우기
				$('#uform .txt').val("");
				
				// 모달창 닫기
				$('#uModal').modal('hide');
				
				// 서버로 전송한다 - js함수 호출 - 동기방식은 가져와야하고, 비동기는 안가져와도 된다.. 흐음.. 동기 비동기..
				$.updateBoardServer();
				
				// 화면 수정 - 서버로 전송 - db수정이 완료 된 후에 실행 - 비동기 실행시 success 콜백에서 해야한다.
			})
			
			
			// 글쓰기 버튼 이벤트 모달창
			$('#write').on('click', function(){
				
				if(uvo == null) {
					alert("로그인 하세요");
					return; // 얘 return은 어디로 감?
				}
				
				$('#writer').val(uvo.mem_name); // 모달 이름칸에 이름 넣기
				
				$('#writer').prop('readonly', true); // 모달 이름 수정 불가 설정 // true 줘야함!
				
				$('#wModal').modal('show'); // 모달 보이게 하기
			})
			// 글쓰기 모달창 끝
			
			// 글쓰기 입력 후 전송 버튼 클릭
			$('#send').on('click', function(){
				// 입력한 모든 내용 가져오기
				fdata1 = $('#wform').serialize(); // 이 방법도 있고 // 직렬화, 문자열로 쭉 나열하기 // writer=%EA%B9%80%EC%9D%80%EB%8C%80&subject=asd&mail=asd&password=asd&content=asd
				fdata2 = $('#wform').serializeArray(); // 이 방법도 있고 // 직렬화 하는데 배열로 만들기 // 0: {name : 'writer', value : '김은대'} 1: {name : 'subject', value : 'asd'} 
				// 위 두가지 방법은 script파일인 board.js 필요 없음
				fdata3 = $('#wform').serializeJSON(); // 이 방법도 있음 // 직렬화 하는데 JSON으로 만들기 // {writer: '김은대', subject: 'asd', mail: 'asd', password: 'asd', content: 'asd'}
				// 직렬화는 key=valuekey=valuekey=valuekey=value 이렇게 나오고
				// 배열(Array)은 인덱스: {키 : 벨류} 인덱스: {키 : 벨류} 인덱스: {키 : 벨류} 이렇게 나오고
				// 제이슨(JSON)은 {키: '벨류', 키: '벨류', 키: '벨류', 키: '벨류'} 이렇게 나오네. 제이슨이 좋구나. 
				
				console.log(fdata1);
				console.log(fdata2);
				console.log(fdata3);
				
				// 글쓰기 함수 호출
				$.boardWriteServer();
				// location.href = "main"; // 이렇게 메인으로 갈 수 있긴 한데, 이게 ajax 비동기라서 boardWriteServer 얘가 끝나든 않든, 성공하든 실패하든, 그냥 감. 그럼 안됨.
				// $.listPageServer(); // 이것도 위에거 글쓰기 실행시켜놓고 결과와 상관없이 리스트 출력해버릴 수 있음. 그래서 안됨.
				// 그래서 비동기는 기다려야 할 경우, 콜백 함수로 해야하니까, success에 넣어줘야 함. 여기서 하는게 아니라, board.js로 가서,
				// 거기서 boardWriteServer의 success 안에다가, 성공하면 페이지를 출력하거나 메인페이지로 간다 이런거 추가해야 하는거
				
				// 모달창 닫기. 근데 내용도 지워야 함
				$('#wModal').modal('hide');
				
				// 모달창 내용 지우기
				$('#wModal .txt').val("");
			})

			
			
			
			
			
			
			
			
			
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
	<br>
	<br>
	<nav class="navbar navbar-expand-sm navbar-dark bg-primary">
		<div class="container-fluid">
			<!--<input type="button" id="write" value="글쓰기" data-bs-toggle="modal" data-bs-target="#wModal">-->
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
	<div id="result"></div> <br><br>

		<!-- 페이지정보를 출력 -->
		<div id="pagelist"></div>

			<!------- 글쓰기 The Modal --------->
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

			<!-- name은 바꾸면 안되고, class txt는 한번에 지우기용 -->
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











