<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>비가동 데이터 분석하기</title>
<script language='javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'></script>
<script type="text/javascript">

function change_go(form){         //Select Box에서 선택한 라인과 공정 데이터를 text_L, text_P 변수로 넘김
    var text_L = form.Line.options[form.Line.selectedIndex].text;
	var text_P = form.sel2.options[form.sel2.selectedIndex].text;
	var s_date = document.getElementById("Start_d").value   
	var s_time = document.getElementById("Start_t").value
	var e_date = document.getElementById("end_d").value   
	var e_time = document.getElementById("end_t").value
	window.open("Problem.jsp?text_L="+text_L+"&text_P="+text_P+"&s_date="+s_date+"&s_time="+s_time+"&e_date="+e_date+"&e_time="+e_time);
	}
	
function sub(){

	 var x = form.Line.value;
	 $.ajax({   
	  type: "POST",  
	  url: "1_Process.jsp",   
	  data: "region="+x,   //&a=xxx 식으로 뒤에 더 붙이면 됨
	  success: result    //function result 를 의미함
	  });
}
function result(msg){
	 //sub()가 실행되면 결과 값을 가지고 와서 action 을 취해주는 callback 함수
	 var sel  =  document.form.sel2;
	 $("#sp1").html(msg); //innerHTML 을 이런 방식으로 사용함
	 //id 는 $("#id")   name 의 경우 $("name") 으로 접근함
}
</script>
</head>
<body>
<center><font size='3'><b>비가동 이력 데이터 분석</b></font>

<form name="form">
<TABLE border='0' width='650' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</table>

<table border='0' width='650' cellpadding='1' cellspacing='1'>
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>검색 기간 선택</b></center></font>
		</td>
		<td>
			<input type='date' id='Start_d'>
			<input type='time' id='Start_t'>
			<font size='3'>~</font>
			<input type='date' id='end_d'>
			<input type='time' id='end_t'>
		</td>
	</tr>
	<tr>
</table>

<table border='0' width='650' cellpadding='1' cellspacing='1'>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>라인</b></center></font>
		</td>
<%
					Class.forName("org.mariadb.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");
					Statement stmt = conn.createStatement();
					ResultSet rs = null;
					String Line, Process, Status, Problem, Solution = null;
					ArrayList<String> Line_array = new ArrayList<String>();           //라인를 저장할 공간
					ArrayList<String> Process_array = new ArrayList<String>();        //공정을 저장할 공간
					ArrayList<String> Status_array = new ArrayList<String>();         //현상을 저장할 공간
					ArrayList<String> Problem_array = new ArrayList<String>();        //원인을 저장할 공간
					ArrayList<String> Solution_array = new ArrayList<String>();       //조치을 저장할 공간
					String SQL_Line = "SELECT DISTINCT Line FROM List_All";          //라인값을 중복값 제거하여 가져오는 쿼리문
					String SQL_Process = "SELECT DISTINCT Process FROM List_All";       //공정값을 중복값 제거하여 가져오는 쿼리문
				   
				   rs = stmt.executeQuery(SQL_Line);
				   while(rs.next()){                 //라인 코드를 가져와 ArrayList에 저장
					   Line = rs.getString("Line");
				       Line_array.add(Line);
				   }
				   
				   rs = stmt.executeQuery(SQL_Process);
				   while(rs.next()){                 //공정 코드를 가져와 ArrayList에 저장
					   Process = rs.getString("Process");
				       Process_array.add(Process);
				   }			   
%>
		<td>
			<select name = "Line" onchange="sub();">
			    <option value="">선택하세요</option>
				<%for(int i=0; i<Line_array.size(); i++){ %>
				<option value="<%=Line_array.get(i)%>"><%=Line_array.get(i)%></option>
				<%}%>
			</select>
		</td>
	</tr>
	<tr>
		<td width='100' bgcolor='7ED2FF' align = "left">
			<font size='2'><center><b>공정</b></center></font>
		</td>
		<td>
			<span id="sp1">
				<select name="sel2">
					<option value="">선택하세요</option>	
				</select>
			</span>
		</td>
	</tr>
</table>
<TABLE border='0' width='650' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</table>
<table border='0' width='650'>
	<tr>
		<td align="right">
		</td>
		<td align="right">
			<input type='button' value="검색" onclick="change_go(this.form);">
			<input type='button' value="메인 메뉴" onclick="location.href='Main.jsp';">
		</td>
	</tr>
</table>
</form>
</body>
</html>