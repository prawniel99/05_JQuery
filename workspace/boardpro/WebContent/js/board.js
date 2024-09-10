/**
 * 여기서는 ajax 비동기 함수만 모으는 중
 */

// 댓글 수정
$.replyUpdateServer = function() {
	$.ajax({
		url : `${mypath}/UpdateReply.do`,
		data : JSON.stringify(reply),
		contentType : 'application/json',
		method : 'post',
		success : res => {
			alert(res.flag);
			// ok면 화면을 수정
			$(vp3).html(modiout);
		},
		error : xhr => {
			alert("Error : " + xhr.status);
		},
		dataType : 'json'
	})
}


// 댓글 삭제
$.deleteReply = function() {
	$.getJSON( // key 없이 value만 쓰고, 중괄호도 없다
		`${mypath}/DeleteReply.do`,
		// data : {renum : vidx},
		{renum : vidx},
		// type : 'get' // 이미 타입 get임
		res=> {
			alert(res.flag);
			// ok이면 현 화면에서 reply-body 지우기 - remove()
			$(target).parents('.reply-body').remove();
		}/*,
		xhr => {
			alert("Error: " + xhr.status)
		}*/ // getJSON은 오류가 없음.
		// 아하 $.post 이거랑 $.getJSON 이거랑 같은 개념이구나. 단축형
	)
}



// 게시글 수정
$.updateBoardServer = function() {
	// $.post(url, data, success, dataType); // 이 단축형으로 보내려고 하니까, contentType 넣는게 없어서 여기선 안됨
	$.ajax({
		url : `${mypath}/UpdateBoard.do`,
		data : JSON.stringify(udata),
		type : 'post', // json.stringify 이거는 post만 가능. get은 왜 불가능할까?
		contentType : 'application/json; charset=utf-8',
		success : res => {
			alert(res.flag);
			// ok이면 화면수정
			// servlet 새로 만들었으면 서버 껐다가 다시 키기
			// 화면 수정 = modal에 입력한 내용 가져와서 본문에 출력
			
			// modal에 입력한 내용 가져오기
			// vwr = $('#uwriter').val();
			// vno = $('#unum').val(); // 이 셋은 수정 불필요
			//vp = $('#upassword').val();
			vs = $('#usubject').val();
			vm = $('#umail').val();
			vc = $('#ucontent').val();
			
			// 이렇게도 가능함
			// 이렇게 하면 모달창 내용 지우기랑 모달창 닫기를, jsp에 #usend 함수에 그대로 둘 수 있음.
			// 바로 위에 $('#') 이거랑 다르게, 할 수 있음.
			// jsp에서 내용을 지웠기 때문에 위에 val 써서 데이터를 가져왔어야 하는건데,
			// 아래 방법으로 하면 jsp에서 내용 안지워도 됨. 근데 지워야 하는거 아녀?
			// vsub = udata.subject;
			// vm = udata.mail;
			// vc = udata.content;
			
			// 원글 본문의 내용을 변경
			$(vcard).find('a').text(vs);
			$(vcard).find('.em').text(vm);
			
			vc = vc.replaceAll(/\n/g, "<br>"); // 줄내림 n으로 되어있는거를 다 <br>로 바꾸라는 말
			$(vcard).find('.p3').html(vc);
			
			// 모달창 내용 지우기
			$('#uform .txt').val("");
			
			// 모달창 닫기
			$('#uModal').modal('hide');
			
		},
		error : xhr => {
			alert("Error: " + xhr.status);
		},
		dataType : 'json'
	})
}


// 게시글 삭제
$.deleteBoardServer = function() {
/*	$.ajax({
		url : 
		data : 
		type : 
		success : res => {
			
		},
		error : xhr => {
			
		},
		dataType : 'json'
	})*/
	// $.get( url, data, success, dataType);
	// $.post( url, data, success, dataType);
	// $.getJSON( url, data, success); 이런것도 가능함
/*	$.get(
		`${mypath}/DeleteBoard.do`,
		{num : vidx},
		runftion(res) {
			
		},
		'json'
	)*/
	$.getJSON(
		`${mypath}/DeleteBoard.do`,
		{num : vidx},
		function(res) {
			// alert(res.flag);
			// currentPage = 1;
			$.listPageServer();
			// 삭제 성공시 list로
/*			if(flag == "ok") {
				$.listPageServer();
			} else {
				alert("실패");
			}*/
		}
	)
}

// 게시글 쓰기
$.boardWriteServer = function() {
	
	// 이렇게도 가능
	// data : "id=" + idvalue + "&name=" + namevalue
	// type : 'get / type : 'post'
	// contentType : 'aaplication/x-www-form-urlencode'
	
	// data : {id : idvalue , name : namevalue}
	// type : 'get / type : 'post'
	// contentType : 'application/x-www-form-urlencode'
	
	$.ajax({
		url : `${mypath}/InsertBoard.do`,
		data : JSON.stringify(fdata3), // 자, board.jsp에서 보면, fdata3 선언 해줬고, 얘는 serializeJSON을 해서 JSON 형태로 직렬화 해서 보낸 데이터야. 오케?
		type : 'post',
		contentType : 'application/json', // 그리고 JSON형태로 직렬화 한 데이터니까, contentType을 application/json으로 알려준거지.
		// 근데 그럼, get이나 post는 type으로 했는데, 여기는 그게 없는거구나. 최신으로는 type 대신 method를 쓴다고 하니까, contentType이랑 겹치지 않겠네
		success : res => {
			// 성공했으면 ok 띄우는거
			// alert(res.flag);
			
			// 리스트 페이지 혹은 메인페이지로 이동
			
			// 메인페이지로 이동하기
			// location.href = "main"
			// location.href = `${mypath}/start/index.jsp`; // ${} 이거 뭐냐고.. getcontextpath는 또 어디고..
			
			// 리스트 페이지로 이동하기
			$.listPageServer();
		},
		error : xhr => {
			alert("Error: " + xhr.status);
		},
		dataType : 'json'
	})
}



// 조회수 증가하기
$.updateHitServer = function() {
	$.ajax({
		url : `${mypath}/UpdateHit.do`, // servlet 또 만들겠다는거지. html, jsp 에서 화면을 만들고, js로 함수를 만들고,
										// servlet, java 에서 기능을 수행하는 건데, 이거는 controller에 만드는 것, 기능의 시작은 컨트롤러
		data : {num : vidx},
		type : 'get',
		success : res => {
			// alert(res.flag);
			// ok이면 화면을 수정 (이미 ok)
			vhi = $(target).parents('.card').find('.hi');
			
			// 화면 조회수의 값을 가져온다 // trim은 혹시나 여백이 있을 수 있으니
			hivalue = parseInt(vhi.text().trim()) + 1;
			
			// 화면의 조회수 부분을 수정 // 그니까 가져와서 하나 올리고, 그걸 다시 가져온 거기에 대입시키는거
			vhi.text(hivalue);
		},
		error : xhr => {
			alert("Error: " + xhr.status);
		},
		dataType : 'json'
	})
}



// 댓글 리스트 가져오기
$.replyListServer = function() {
	$.ajax({
		url : `${mypath}/ReplyList.do`,
		data : {bonum : vidx}, // {bonum : reply.bonum}
		type : 'get', // contentType 이 application/json 일때는 post 무조건인거, dataType 말고.
		success : res => {
			// alert(res);
			console.log(res);
			
			rcode = "";
			
			// 댓글 리스트 res 출력
			$.each(res, function(i,v){
				cont = v.cont;
				cont = cont.replaceAll(/\n/g, "<br>");
				
				rcode += `<div class="reply-body">
							<div class="p12">
								<p class="p1">
									작성자: <span class="rwr">${v.name}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									날짜: <span class="rda">${v.redate}</span>
							    </p>
							    <p class ="p2">`
								if(uvo != null && uvo.mem_name == v.name){
									rcode += `<input idx="${v.renum}" type="button" value="댓글수정" name="r_modify" class="action">
									<input idx="${v.renum}" type="button" value="댓글삭제" name="r_delete" class="action">`
								}
								rcode += `</p>
							</div>
							<p class="rp3">
								${cont}
							</p>
						</div>`;
				
				// $(this).parents('.card') // 이렇게 하고싶은데 this가 애매해서 안됨
				// target변수는 제목, 등록 을 클릭할때 this를 받은 변수
				// car 헤더를 찾으려고 하니까, 삼촌이라서 바로 못감. 그래서 조상으로 간 다음에, 다시 card-body로 내려감.
			})
			$(target).parents('.card').find('.reply-body').remove();
			$(target).parents('.card').find('.card-body').append(rcode);
		},
		error : xhr => {
			alert("error: " + xhr.status);
		},
		dataType : 'json'
	})
}



// 댓글 쓰기 요청 - 응답 - 출력
$.replyWriteServer = function() {
	$.ajax({
		// 이것들 순서 바꿔도 작동 문제 없음.
		url : `${mypath}/InsertReply.do`,
		data : JSON.stringify(reply),
		contentType : 'application/json',
		type : 'post',
		success : res => {
			// alert(res.flag);
			// flag가 ok면 댓글 리스트가 출력되도록 해야지
			$.replyListServer();
		},
		error : xhr => {
			alert("error: " + xhr.status);
		},
		dataType : 'json'
	})
}






// 게시글 리스트 요청 - 응답 - 출력
$.listPageServer = function() {
	/* stype = $("#stype option:selected") id가(#) stype인 것의 옵션 중 선택된 것.의 값().을 앞뒤 공백 제거해서 대입시켜라(=) stype이라는 변수에 */
	stype = $("#stype option:selected").val().trim();
	sword = $('#sword').val().trim();
		
	datas = {page : currentPage , stype : stype , sword : sword};
		
	/* $.ajax({}) 이 중괄호{} 안에는 뭘 넣고 대괄호() 안에는 뭘 넣냐고, 얘넨 뭐냐고 */
	$.ajax({
		/* 이거 ${} 이거 안에는 변수 넣기. 변수밖에 안됨? 어제 뭐 하니까 안됐던거는 왜 안됨 */
		url : `${mypath}/BoardList.do`,
		type : 'post',
		data : JSON.stringify(datas), /* 이거 데이터 보내는거잖아, stringify해서 보내기, 직렬화 해서 datas를 보내기, 근데 datas는 형식인데? */
		contentType : 'application/json',
		success : res =>{
			console.log(res);
			
			code = `<div class="container mt-3">`;
			code += `<div id="accordion">`;
			$.each(res.datas, function(i, v){
				// 지금부터 엄청 복잡하다.
				// 내용 가져온다 - 엔터로 저장되어 있는것을 <br>로 바꾸기 위해서
				cont = v.content;
				cont = cont.replaceAll(/\n/g, "<br>")
				code += `<div class="card">
					<div class="card-header">
						<a class="btn action" idx="${v.num}" name="title" data-bs-toggle="collapse" href="#collapse${v.num}">
							${v.subject}
						</a>
					</div>
					<div id="collapse${v.num}" class="collapse" data-bs-parent="#accordion">
						<div class="card-body">
							<div class="p12">
								<p class="p1">
									작성자: <span class="wr">${v.writer}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									이메일: <span class="em">${v.mail}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									조회수: <span class="hi">${v.hit}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									날짜: <span class="da">${v.wdate}</span>
								</p>
								<p class ="p2">`
								if(uvo != null && uvo.mem_name == v.writer){
									code += `<input idx="${v.num}" type="button" value="수정" name="modify" class="action">
									<input idx="${v.num}" type="button" value="삭제" name="delete" class="action">`
								}
								code += `</p>
							</div>
							<p class="p3">
								${cont}
							</p>
							<p class="p4">
								<textarea rows="" cols="60"></textarea>
								<input idx="${v.num}" type="button" value="등록" name="reply" class="action">
							</p>
						</div>
					</div>
				</div>`;
				// input에 준 idx 속성은 임의로 준것. 주면 뭐 되는데?
			})
			code += `</div></div>`;
			
			// 리스트 출력
			$('#result').html(code);
			
			// page 정보 출력
			vpage = $.pageList(res.sp, res.ep, res.tp);
			$('#pagelist').html(vpage);
		},
		error : xhr =>{
			alert("오류: " + xhr.status);
		},
		dataType : 'json'
	}) // ajax 끝
} // $.listPageServer 끝 $는 이름임 $.ajax 이런 기능이 아니라 이름임



$.pageList = function(sp, ep, tp) {
	
	// 이전
	pager = "";
	pager += '<ul class="pagination">';
	if(sp > 1) {
		pager += `<li class="page-item"><a id="prev" class="page-link" href="#">Previous</a></li>`;
	}
	
	// currentPage = 7(마지막페이지) 마지막 페이지의 모든 데이터 삭제할 경우
	// currentPage의 값이 새로 구한 totalPage(tp)로 변경되어야 한다
	if(currentPage > tp) currentPage = tp;
	
	// 페이지 번호
	for(i = sp; i <= ep; i++) {
		if(currentPage == i) {
			pager += `<li class="page-item active"><a class="page-link pageno" href="#">${i}</a></li>`;
		} else {
			pager += `<li class="page-item"><a class="page-link pageno" href="#">${i}</a></li>`;
		}
	}
	
	// 다음
	if(ep < tp) {
		pager += `<li class="page-item"><a id="next" class="page-link" href="#">Next</a></li>`;
	}
	
	pager += "</ul>";
	return pager;
}













