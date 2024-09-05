/**
 * 
 */

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
							<p class="p3">
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
									조회수: <span class="hi">0</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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













