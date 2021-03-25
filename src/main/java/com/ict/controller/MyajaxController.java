package com.ict.controller;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
//java가 1.8이상이여야 사용가능
//일반 컨트롤러는 ModelAndView를 리턴
//RestController는 단순문자열=text,
//					json,xml 중 하나를 리턴.
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

//리턴이 String이면 문서의 타입이 기본적으로 "text/html"이다.
// 내용은 http://localhost:8090/접근URL로 볼 수 있다.
//자동으로 json이만들어진다.
@RestController
public class MyajaxController {
	
	@RequestMapping("exam.do")
	@ResponseBody//브라우저
	public String Hello() {
		String msg="<h2 style='color:red'>Hello World ICT CAMP</h2>";
		msg+="<h3>Hello World ICT CAMP</h3>";
		return msg;
	}
	@RequestMapping( value = "text.do",produces = "text/html; charset=utf-8")
	@ResponseBody//브라우저
	public String TextCommand() {
		StringBuffer sb = new StringBuffer();
		//원래는 DB나 파일을 읽어서 가져온 정보.
		sb.append("1,홍길동,24,서울/");
		sb.append("2,고길동,42,경기도/");
		sb.append("3,마이콜,28,아프리카/");
		sb.append("4,둘리,300,한반도/");
		sb.append("5,희동이,4,독도");
		return sb.toString();
	}
	@RequestMapping( value = "xml01.do",produces = "text/xml; charset=utf-8")
	@ResponseBody//브라우저
	public String xml01Command() {
		StringBuffer sb = new StringBuffer();
		//원래는 DB나 파일을 읽어서 가져온 정보.
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("<products>");
		sb.append("<product>");
		sb.append("<name>흰우유</name>");
		sb.append("<price>950</price>");
		sb.append("</product>");
		
		sb.append("<product>");
		sb.append("<name>딸기우유</name>");
		sb.append("<price>950</price>");
		sb.append("</product>");
		
		sb.append("<product>");
		sb.append("<name>초코우유</name>");
		sb.append("<price>950</price>");
		sb.append("</product>");
		
		sb.append("<product>");
		sb.append("<name>바나나우유</name>");
		sb.append("<price>1550</price>");
		sb.append("</product>");
		sb.append("</products>");
		return sb.toString();
	}
	@RequestMapping( value = "xml02.do",produces = "text/xml; charset=utf-8")
	@ResponseBody//브라우저
	public String xml02Command() {
		StringBuffer sb = new StringBuffer();
		//원래는 DB나 파일을 읽어서 가져온 정보.
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("<products>");
		sb.append("<product name=\"흰 우유\" price=\"950\" />");
		sb.append("<product name=\"딸기 우유\" price=\"950\" />");
		sb.append("<product name=\"초코 우유\" price=\"950\" />");
		sb.append("<product name=\"바나나 우유\" price=\"1550\" />");
		sb.append("</products>");
		return sb.toString();
	}
	@RequestMapping( value = "xml03.do",produces = "text/xml; charset=utf-8")
	@ResponseBody//브라우저
	public String xml03Command() {
		StringBuffer sb = new StringBuffer();
		//원래는 DB나 파일을 읽어서 가져온 정보.
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("<products>");
		sb.append("<product price=\"950\">흰우유</product>");
		sb.append("<product price=\"950\">딸기우유</product>");
		sb.append("<product price=\"950\">초코우유</product>");
		sb.append("<product price=\"1550\">바나나우유</product>");
		sb.append("</products>");
		return sb.toString();
	}
	
	//외부로 부터 xml파일을 읽어서 전달하는 역할만 한다.
	@RequestMapping( value = "xml04.do",produces = "text/xml; charset=utf-8")
	@ResponseBody//브라우저
	public String xml04Command() {
		StringBuffer sb = new StringBuffer();
		try {
			URL url = new URL("https://www.kma.go.kr/XML/weather/sfc_web_map.xml");
			URLConnection conn = url.openConnection();
			BufferedReader br = 
					new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
			String msg = "";
			while ((msg = br.readLine())!= null) {
				sb.append(msg);
			};
		} catch (Exception e) {
		}
		
		return sb.toString();
	}
	
	// 외부로 부터 xml파일을 읽어서 자체파싱해서 html문서로 만들자
	// DOM방식으로 파싱한다.
		@RequestMapping( value = "xml05.do",produces = "text/html; charset=utf-8")
		@ResponseBody//브라우저
		public String xml05Command() {
			StringBuffer sb = new StringBuffer();
			sb.append("<table><thead><tr><td>지역</td><td>온도</td><td>날씨</td><td>표기</td></tr></thead>");
			try {
				DocumentBuilderFactory factory=DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				URL url = new URL("https://www.kma.go.kr/XML/weather/sfc_web_map.xml");
				
				BufferedInputStream br = 
						new BufferedInputStream(url.openStream());
				
				Document document = builder.parse(br);
				NodeList local =document.getElementsByTagName("local");
				sb.append("<tbody style='background-color:skyblue'>");
				for (int i = 0; i < local.getLength(); i++) {
					sb.append("<tr>");
					//태그글자
					sb.append("<td>"+local.item(i).getFirstChild().getNodeValue()+"</td>");
					//태그속성
					sb.append("<td>"+((Element)(local.item(i))).getAttribute("ta")+"</td>");
					sb.append("<td>"+((Element)(local.item(i))).getAttribute("desc")+"</td>");
					sb.append("<td><img src='http://www.kma.go.kr/images/icon/NW/NB"+((Element)(local.item(i))).getAttribute("icon")+".png'></td>");
					sb.append("</tr>");
				}
				sb.append("</tbody></table>");
				
				//
				
			} catch (Exception e) {
			}
			
			return sb.toString();
		}
		
		//json형태로 객체데이터를 반환한다.
		@RequestMapping( value = "json01.do",produces = "text/html; charset=utf-8")
		@ResponseBody//브라우저
		public String json01Command() {
			StringBuffer sb = new StringBuffer();
			sb.append("[");
			sb.append("{\"name\":\"커피음료\",\"price\":\"1950\"},");
			sb.append("{\"name\":\"이온음료\",\"price\":\"1250\"},");
			sb.append("{\"name\":\"탄산음료\",\"price\":\"1250\"},");
			sb.append("{\"name\":\"과일음료\",\"price\":\"1850\"}");
			sb.append("]");
			return sb.toString();
		}
		@RequestMapping( value = "json02.do",produces = "text/html; charset=utf-8")
		@ResponseBody//브라우저
		public String json02Command() {
			StringBuffer sb = new StringBuffer();
			try {
				URL url = new URL("http://openapi.seoul.go.kr:8088/sample/json/SeoulLibraryTime/1/5/");
				URLConnection conn = url.openConnection();
				BufferedReader br = 
						new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
				String msg = "";
				while ((msg = br.readLine())!= null) {
					sb.append(msg);
				};
			} catch (Exception e) {
			}
			
			return sb.toString();
		}
		
		
}
