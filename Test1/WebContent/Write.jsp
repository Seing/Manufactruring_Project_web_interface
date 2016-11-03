<%-- 비가동 이력 작성 --%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>비가동 이력 작성</title>

<script type="text/javascript">
function change_go(Write){         //작성한 값 넘기기
	var line = form.Line.options[form.Line.selectedIndex].text;              //입력한 라인값 변수에 저장
	var process = form.Process.options[form.Process.selectedIndex].text;
	var type = form.Type.options[form.Type.selectedIndex].value;
	var reporter = document.getElementById("Reporter").value
	var fixitman = document.getElementById("Fixitman").value
	var status = form.Status.options[form.Status.selectedIndex].text;
	var problem = form.Problem.options[form.Problem.selectedIndex].text;
	var solution = form.Solution.options[form.Solution.selectedIndex].text;
	var s_date = document.getElementById("Stop_d").value   
	var s_time = document.getElementById("Stop_t").value
	var re_date = document.getElementById("Restart_d").value   
	var re_time = document.getElementById("Restart_t").value
	var details = document.getElementById("Details").value
	window.open("Write_input.jsp?line="+line+"&process="+process+"&type="+type+"&status="+status+"&problem="+problem+"&solution="+solution+"&s_date="+s_date+"&s_time="+s_time+"&re_date="+re_date+"&re_time="+re_time+"&details="+details+"&reporter="+reporter+"&fixitman="+fixitman);
	}
</script>
</head>
<body>
<center><font size='3'><b> 비가동 이력 작성</b></font>

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</table>

<form Name ="form">

<%-- 라인과 공정을 Select Box로 만들고 DB에 있는 값을 변수로 넣기위한 소스 --%>

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
				   String SQL_Status = "SELECT DISTINCT Code FROM Status_Code";          //현상값을 중복값 제거하여 가져오는 쿼리문
				   String SQL_Problem = "SELECT DISTINCT Code FROM Problem_Code";          //원인값을 중복값 제거하여 가져오는 쿼리문
				   String SQL_Solution = "SELECT DISTINCT Code FROM Solution_Code";          //조치값을 중복값 제거하여 가져오는 쿼리문
				   
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
				   
				   rs = stmt.executeQuery(SQL_Status);
				   while(rs.next()){                 //현상 코드를 가져와 ArrayList에 저장
					   Status = rs.getString("Code");
				       Status_array.add(Status);
				   }
				   
				   rs = stmt.executeQuery(SQL_Problem);
				   while(rs.next()){                 //원인 코드를 가져와 ArrayList에 저장
					   Problem = rs.getString("Code");
					   Problem_array.add(Problem);
				   }
				   
				   rs = stmt.executeQuery(SQL_Solution);
				   while(rs.next()){                 //조치 코드를 가져와 ArrayList에 저장
					   Solution = rs.getString("Code");
					   Solution_array.add(Solution);
				   }
%>
<%-- 비가동 이력 작성 테이블 --%>

<TABLE border='0' width='600' cellpadding='2' cellspacing='2'>

<%-- 라인 --%>
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>라인</b></center></font>
		</td>
		<td>
			<select name = "Line">
				<%for(int i=0; i<Line_array.size(); i++){ %>
				<option value="i"><%=Line_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- 공정 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>공정</b></center></font>
		</td>
		<td>
			<select name = "Process">
				<%for(int i=0; i<Process_array.size(); i++){ %>
				<option value="i"><%=Process_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- 비가동 유형 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>비가동 유형</b></center></font>
		</td>
		<td>
			<select name = "Type">
				<option value="1">전체 비가동</option>
				<option value="2">라인 비가동</option>
				<option value="3">공정 비가동</option>
			</select>
		</td>
	</tr>

<%-- 신고자 사번 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>신고자 사번</b></center></font>
		</td>
		<td>
			<input type='text' size='3' maxlength="6" id='Reporter'>
		</td>
	</tr>
	
<%-- 수리자 사번 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>수리자 사번</b></center></font>
		</td>
		<td>
			<input type='text' size='3' maxlength="6" id='Fixitman'>
		</td>
	</tr>
	
<%-- 현상 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>현상</b></center></font>
		</td>
		<td>
			<select name = "Status">
				<%for(int i=0; i<Status_array.size(); i++){ %>
				<option value="i"><%=Status_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- 원인 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>원인</b></center></font>
		</td>
		<td>
			<select name = "Problem">
				<%for(int i=0; i<Problem_array.size(); i++){ %>
				<option value="i"><%=Problem_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- 조치 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>조치</b></center></font>
		</td>
		<td>
			<select name = "Solution">
				<%for(int i=0; i<Solution_array.size(); i++){ %>
				<option value="i"><%=Solution_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- 중단 시간 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>중단 시간</b></center></font>
		</td>
		<td>
			<input type='date' id='Stop_d'>
			<input type='time' id='Stop_t'>
		</td>
	</tr>
	
<%-- 재가동 시간 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>재가동 시간</b></center></font>
		</td>
		<td>
			<input type='date' id='Restart_d'>
			<input type='time' id='Restart_t'>
		</td>
	</tr>
	
<%-- 세부 사항 --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>세부내역</b></center></font>
		</td>
		<td>
			<input type='text' size='50' id='Details'>
		</td>
	</tr>
		<tr>
		<td colspan='2'><hr size='1' noshade>
		</td>
	</tr>
	
<%-- 이력 등록 --%>
	<tr>
		<td align='center' colspan='2' width='100%'>
		<table>
			<tr>
				<td width='100' align='center'>
					<input type='Reset' value='다시 작성'>
				</td>
				<td width='100' align='center'>
					<input type='button' value='등록' onclick="change_go(this.form);">
				</td>
				<td width='100' align='center'>
					<input type='button' value='비가동 이력 리스트' onclick="location='List.jsp'">
				</td>
				<td width='100' align='center'>
					<input type='button' value="메인 메뉴" onclick="location.href='Main.jsp';">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</TABLE>
</form>
</body>
</html>