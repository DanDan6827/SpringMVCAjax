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
	
	$("#btn1").click(function() {
		$("#result").empty();
		$.ajax({
			url:"exam.do",
			method:"get",
			dataType:"text",
			success: function(data) {
				$("#result").append(data);
			},
			error: function() {
				alret("읽기실패");
			}
			
		});
	});
	$("#btn2").click(function() {
		$("#result").empty();
		$.ajax({
			url:"text.do",
			method:"get",
			dataType:"text",
			success: function(data) {
				var table = "<table>";
				table += "<thead>";
				table+= "<tr><th>번호</th><th>이름</th><th>나이</th><th>주소</th></tr>"
				table += "</thead>";
				table += "<tbody>";
				var person = data.split("/");
				for(var k in person){
					table +="<tr>";
					var p_sell = person[k].split(",");
					for (var k2 in p_sell) {
						table += "<td>"+p_sell[k2]+"</td>";
					}
					table +="</tr>";
				}
				table += "</tbody></table>";
			$("#result").append(table);
			},
			
			error: function() {
				alret("읽기실패");
			}
			
		});
	});
	//태그이름불러오기
	$("#btn3").click(function() {
		$("#result").empty();
		$.ajax({
			url:"xml01.do",
			method:"get",
			dataType:"xml",
			success: function(data) {
				var table = "<table>";
				table += "<thead>";
				table+= "<tr><th>이름</th><th>가격</th></tr>"
				table += "</thead>";
				table += "<tbody>";
				$(data).find("product").each(function() {
					table +="<tr>"
					table+="<td>"+$(this).find("name").text()+"</td>";
					table+="<td>"+$(this).find("price").text()+"</td>";
					table +="</tr>"
				});
				table += "</tbody></table>";
			$("#result").append(table);
			},
			
			error: function() {
				alret("읽기실패");
			}
			
		});
	});
	//속성불러오기
	$("#btn4").click(function() {
		$("#result").empty();
		$.ajax({
			url:"xml02.do",
			method:"get",
			dataType:"xml",
			success: function(data) {
				var table = "<table>";
				table += "<thead>";
				table+= "<tr><th>이름</th><th>가격</th></tr>"
				table += "</thead>";
				table += "<tbody style='background-color:tomato'>";
				$(data).find("product").each(function() {
					table +="<tr>"
					table+="<td>"+$(this).attr("name")+"</td>";
					table+="<td>"+$(this).attr("price")+"</td>";
					table +="</tr>"
				});
				table += "</tbody></table>";
			$("#result").append(table);
			},
			error: function() {
				alert("읽기실패");
			}
			
		});
	});
	$("#btn5").click(function() {
		$("#result").empty();
		$.ajax({
			url:"xml03.do",
			method:"get",
			dataType:"xml",
			success: function(data) {
				var table = "<table>";
				table += "<thead>";
				table+= "<tr><th>이름</th><th>가격</th></tr>"
				table += "</thead>";
				table += "<tbody style='background-color:yellow'>";
				$(data).find("product").each(function() {
					table +="<tr>"
					table+="<td>"+$(this).text()+"</td>";
					table+="<td>"+$(this).attr("price")+"</td>";
					table +="</tr>"
				});
				table += "</tbody></table>";
			$("#result").append(table);
			},
			error: function() {
				alert("읽기실패");
			}
			
		});
	});
	
	$("#btn6").click(function() {
		$("#result").empty();
		$.ajax({
			url:"xml04.do",
			method:"get",
			dataType:"xml",
			success: function(data) {
				var table = "<table>";
				table += "<thead>";
				table+= "<tr><th>지역</th><th>온도</th><th>날씨</th><th>표기</th></tr>"
				table += "</thead>";
				table += "<tbody>";
				$(data).find("local").each(function() {
					table +="<tr>"
					table+="<td>"+$(this).text()+"</td>";
					table+="<td>"+$(this).attr("ta")+"</td>";
					table+="<td>"+$(this).attr("desc")+"</td>";
					table+="<td><img src='http://www.kma.go.kr/images/icon/NW/NB"+$(this).attr("icon")+".png'></td>";
					table +="</tr>"
				});
				table += "</tbody></table>";
			$("#result").append(table);
			},
			error: function() {
				alert("읽기실패")
			}
			
		});
	});
	
	$("#btn7").click(function() {
		$("#result").empty();
		$.ajax({
			url:"xml05.do",
			method:"get",
			dataType:"html",
			success: function(data) {
				$("#result").append(data);
			},
			error: function() {
				alert("읽기실패")
			}
			
		});
	});
	$("#btn8").click(function() {
		$("#result").empty();
		$.ajax({
			url:"json01.do",
			method:"get",
			dataType:"json",
			success: function(data) {
				var table = "<table>";
				table += "<thead>";
				table+= "<tr><th>종류</th><th>가격</th></tr>"
				table += "</thead>";
				table += "<tbody>";
				$.each(data, function() {
					table+="<tr>";
					table+="<td>"+this["name"]+"</td><td>"+this["price"]+"</td>";
					table+="</tr>";
				});
				table += "</tbody></table>";
			$("#result").append(table);
			},
			error: function() {
				alert("읽기실패")
			}
			
		});
	});
	
	$("#btn9").click(function() {
		$("#result").empty();
		$.ajax({
			url:"json02.do",
			method:"get",
			dataType:"json",
			success: function(data) {
				var table = "<table>";
				table += "<thead>";
				table+= "<tr><th>도서관이름</th><th>주소</th><th>전화번호</th></tr>"
				table += "</thead>";
				table += "<tbody>";
				$.each(data, function() {
					var row = this["row"];
					$.each(row, function() {
					table+="<tr>";
					table+="<td>"+this["LBRRY_NAME"]+"</td>";
					table+="<td>"+this["ADRES"]+"</td>";
					table+="<td>"+this["TEL_NO"]+"</td>";
					table+="</tr>";
					});
				});
				table += "</tbody></table>";
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
	<h2>Ajax 예제</h2>
	<hr>
	<button id="btn1">ajax텍스트예제</button>
	<button id="btn2">텍스트2</button>
	<button id="btn3">xml01</button>
	<button id="btn4">xml02</button>
	<button id="btn5">xml03</button>
	<button id="btn6">외부xml01</button>
	<button id="btn7">외부xml02</button>
	<button id="btn8">json연습</button>
	<button id="btn9">json외부</button>
	<br>
	<hr>
	
	<div id="result"></div>
	
</body>
</html>