<%-- �񰡵� �̷� ��� --%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�񰡵� �̷� ���</title>
</head>
<body>
<%

String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum = "1";
}

int listSize = 100;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * listSize + 1;
int endRow = currentPage * listSize;
int lastRow = 0;
int i = 0;
int num[] = {0};


// DB �����ϱ�
Class.forName("org.mariadb.jdbc.Driver");
				   
Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");

Statement stmt = conn.createStatement();

String strSQL = "SELECT * FROM List_All ORDER BY Num DESC";
ResultSet rs = stmt.executeQuery(strSQL);

while(rs.next()){
	num[i] = rs.getInt("num");
}
lastRow = num[0];
%>

<center><font size='3'><b>�񰡵� �̷� ����Ʈ</b></font>

<TABLE border='0' width='800' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</TABLE>

<TABLE border='0' cellspacing=1 cellpadding=2 width='800'>
	<tr>
		<td bgcolor='7ED2FF'><font size=2><b>��ȣ</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>����</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>����</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>�񰡵� ����</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>�Ű��� ���</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>������ ���</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>����</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>����</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>��ġ</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>�ߴܽð�</b></font></td>
		<td bgcolor='7ED2FF'><font size=2><b>�簡�� �ð�</b></font></td>
	</tr>
	
<%
if(lastRow > 0){
	strSQL = "SELECT * FROM List_All WHERE Num BETWEEN " + startRow + " and " + endRow;
	rs = stmt.executeQuery(strSQL);
	
	for(i=0; i<listSize; i++){
		if(rs.next()){

	int listnum = rs.getInt("Num");
	String Line = rs.getString("Line");
	String Process = rs.getString("Process");
	String Reporter = rs.getString("Reporter");
	String Fixitman = rs.getString("Fixitman");
	String Status = rs.getString("Status");
	String Problem = rs.getString("Problem");
	String Solution = rs.getString("Solution");
	int Type = rs.getInt("Type");
	String Stop = rs.getString("Stop");
	String Restart = rs.getString("Restart");
%>
	<tr>
		<td align=center><a href="Write_output.jsp?num=<%=num %>"><font size=2 color='black'><%=listnum %></font></a></td>
		<td align=center><font size=2 color='black'><%=Line %></font></td>
		<td align=center><font size=2 color='black'><%=Process %></font></td>
		<td align=center><font size=2 color='black'><%=Reporter %></font></td>
		<td align=center><font size=2 color='black'><%=Fixitman %></font></td>
		<td align=center><font size=2 color='black'><%=Status %></font></td>
		<td align=center><font size=2 color='black'><%=Problem %></font></td>
		<td align=center><font size=2 color='black'><%=Solution %></font></td>
		<td align=center><font size=2 color='black'><%=Type %></font></td>
		<td align=center><font size=2 color='black'><%=Stop %></font></td>
		<td align=center><font size=2 color='black'><%=Restart %></font></td>
	</tr>
<%
	}
}
%>
</TABLE>

<TABLE border='0' width='800' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</TABLE>

<TABLE border=0 width=800>
	<tr>
		<td align=left>
		</td>
		<td align='right'>
		<a href='Write.jsp'>[�̷� �ۼ� ������]</a>
		</td>
	</tr>
</TABLE>

<%
rs.close();
stmt.close();
conn.close();
}

if(lastRow > 0){
	int setPage = 1;
	int lastPage = 0;
	if(lastRow % listSize == 0)
		lastPage = lastRow / listSize;
	else
		lastPage = lastRow / listSize + 1;
	
	if(currentPage > 1){
		%>
		
		<a href="List.jsp?pageNum=<%=currentPage-1%> %>">[����]</a>
		<%
		}
		while(setPage <= lastPage){
			System.out.println("dkdkdk");
		%>
		<a href="List.jsp?pageNum=<%=setPage%>">[<%=setPage %>]</a>
		<%
		setPage = setPage + 1;
		}
		if(lastPage > currentPage){
			%>
			<a href="List.jsp?pageNum=<%=currentPage+1%>">[����]</a>
			<%}}%>
			</center>
</body>
</html>