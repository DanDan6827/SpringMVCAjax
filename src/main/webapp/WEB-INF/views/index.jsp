<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div{text-align: center;}
	table{width: 500px; margin: 0 auto;}
	table,th,td{
	border: 1px solid skyblue;
	text-align: center;
	border-collapse: collapse;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
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
						table+="<table>";
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
	
</body>
</html>