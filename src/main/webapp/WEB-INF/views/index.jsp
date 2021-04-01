<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	/* div{text-align: center;} */
	.table{width: 500px; margin: 0 auto;}
	table,th,td{
	border: 1px solid skyblue;
	text-align: center;
	border-collapse: collapse;
	}
	#box{position: relative; width: 500px; height: 500px;}
	.o{position: absolute; height: 30px; width: 150px; z-index: 9;}
	.menu{position: absolute; width: 300px; margin-left: 300px;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {

	$(document).on('click','button',function() {
		$('.menu').css('display','none');
	    $(this).next().css('display','');
	});
	// $.ajax({
	//	url -서버주소
	//	method - 전달방식(get,post)
	//	data -보내는 정보(파라미터)
	//	dataType - 받는정보(html,xml,json,text)
	//	success - 성공했을때 실행
	//	error - 실패했을때 실행
	//   });

 	$(document).on('click','#btn',function() {
 		var save = $(this);
 		var tbody = save.parent().parent().parent();
 		var tr = tbody.children();
 		var q = tr.eq(2).text();
 		var a = tr.eq(4).text();
 		alert("질문 :"+q);
 		alert("답변 :"+a);
	});
	$("#btn6").click(function() {
		$("#result").empty();
		$.ajax({
			url:"xml04.do",
			method:"get",
			dataType:"xml",
			success: function(data) {	
				var search = $("#search").val();
				var table = "";
				if (($(data).text()).indexOf(search)!=-1) {
					$(data).find("item").each(function() {
						if(($(this)/* .find("mainCategory") */.text()).indexOf(search)!=-1){
							table+="<form id='post' method='post'>"
						table+="<table class='table'>";
					table+= "<tbody>";
					table+="<tr><td><h2>카테고리</h2>"+$(this).find("mainCategory").text()+"</td></tr>";
					table+="<tr><td colspan='2'><h2>질문</td></tr>";
					table+="<tr><td>"+$(this).find("question").text()+"</td></tr>";
					table+="<tr><td colspan='2'><h2>답변</td></tr>";
					table+="<tr><td>"+$(this).find("answer").text()+"</td></tr>";
					table+="<tr><td><input type='button' id='btn' value='저장' /></td></tr>";
				table += "</tbody></table>";
				table+="</form>"
				table +="<br><br>";
						} 
					});
				}else{
					table+="<table>"
					table+= "<tbody>";
					table+="<tr><td><h2>관련된 자료가없습니다.</h2></td></tr>";
				table += "</tbody></table>";
				table +="<br><br>";
				}
				
			$("#result").append(table);
			},
			error: function() {
				alert("읽기실패")
			}
			
		});
	});
	
})	
</script>
</head>
<body>
	<h2>API 테스트</h2>
	<hr>
	<!-- <button id="btn1">ajax텍스트예제</button>
	<button id="btn2">텍스트2</button>
	<button id="btn3">xml01</button>
	<button id="btn4">xml02</button>
	<button id="btn5">xml03</button> -->
	<form id="myform" method="post">
		<input type="text" placeholder="검색어를 입력해주세요" id="search">
	<button id="btn6" type="button">검색</button>
	</form>
	<!-- <button id="btn7">외부xml02</button>
	<button id="btn8">json연습</button>
	<button id="btn9">json외부</button> -->
	<br>
	<hr>
	<div id="result"></div>
	<hr>
	<div id="box">
	<button id="m1" class="o" style="float: left;">메뉴1</button>
	<div class="menu" style="display: block;">
	<table class="tab" style="width: 300px; float: left;">
	<caption><h2>회원정보목록</h2></caption>
	<thead><tr><th>이름</th><th>아이디</th><th>닉네임</th></tr></thead>
	<tr><td>홍길동1</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동2</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동3</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동4</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동5</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동6</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동7</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동8</td><td>adfs12</td><td>gogo</td></tr>
	</table>
	</div>
	<button id="m2" class="o" style="float: left;margin-top: 30px;">메뉴2</button>
	<div class="menu" style="display: none;">
	<table class="tab" style="width: 300px; float: left;">
	<caption><h2>제한회원 정보목록</h2></caption>
	<thead><tr><th>이름</th><th>아이디</th><th>닉네임</th></tr></thead>
	<tr><td>홍길동2</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동3</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동4</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동41</td><td>adfs12</td><td>gogo</td></tr>
	<tr><td>홍길동22</td><td>adfs12</td><td>gogo</td></tr>
	</table>
	</div>
	</div>

</body>
</html>