<%-- �񰡵� �߻� ���� �׷����� ��Ÿ���� --%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("euc-kr"); %>
<%@ page import = "java.sql.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��ġ ���� ������</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<%
String a = request.getParameter("text_L");      //Select Box���� ������ ���ΰ�
String b = request.getParameter("text_P");      //Select Box���� ������ ������
String s_d = request.getParameter("s_date");      //���� ��¥
String s_t = request.getParameter("s_time");      //�ð�
String e_d = request.getParameter("e_date");      //�� ��¥
String e_t = request.getParameter("e_time");      //�ð�
%>
</head>
<body>
<div class="container">
<div class="col-md-9">
<div class="row">
<br/>

<table border='0' width='700'>
	<tr>
		<td align='left'>
			<input type='button' value="���� ����" onclick="location.href='Problem.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
			<input type='button' value="���� ����" onclick="location.href='Status.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
			<input type='button' value="��ġ ����" onclick="location.href='Solution.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
		</td>
		<td align='center'>
			<input type='button' value="�ð��뺰 �м�" onclick="location.href='Problem_Time.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
		</td>
		<td align='right'>
		<input type='button' value="���� �޴�" onclick="location.href='Main.jsp';">
		</td>
	</tr>
</table>

</div>
	<div class="row">
	<br/>
		<div id="container" style="width: 700px; height: 800px; margin: 0 auto"></div>
	</div>
</div>

<script type="text/javascript">
function go_pop(){
	window.open("predict.jsp","new","width=800, height=800, resizable=yes, scrollvars=yes, status=no, location=no, directories=no;");
}
   $(function () {
    // Create the chart
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '���� ����'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
        	//text : '���� ����'
            type: 'category'
        },
        yAxis: {
            title: {
                text: '�߻� ��'
            }
        },
        legend: {
            enabled: false
        },
        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true,
                    //format: '{point.y:.1f}%'
                }
            }
        },

        tooltip: {
            headerFormat: '<span style="font-size:5px">{series.name}</span><br>',
            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b> of total<br/>'
        },

        series: [{
            name: '����',
            colorByPoint: true,
            data: [
                   <%
                   String T1 = s_d+" "+s_t+":00";
                   String T2 = e_d+" "+e_t+":00";
				   Class.forName("org.mariadb.jdbc.Driver");
				   Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");
				   Statement stmt = conn.createStatement();
				   ResultSet rs = null;
				   String Status = null;
				   String St_code = null;
				   String Status_Code_Code = null;
				   String Status_Code_Status = null;
				   int num = 0;
				   ArrayList<String> Status_code = new ArrayList<String>();        //���� ���� �ڵ带 ������ ���
				   ArrayList<Integer> Status_count = new ArrayList<Integer>();        //���� ������ �� �󵵼��� ������ ���
				   ArrayList<String> st_code = new ArrayList<String>();              //���� ���� �ڵ� ǥ�� �׸��� ���� �ڵ尪
				   ArrayList<String> st_status = new ArrayList<String>();           //���� ���� �ڵ� ǥ�� �׸��� ���� ���ΰ�
				   String strSQL1 = "SELECT DISTINCT Line, Process, Status FROM List_All";   //���� ���� �ڵ带 �ߺ��� �����Ͽ� �������� ������
				   String strSQL3 = "SELECT Code, Status FROM Status_Code";   //���� ���� �ڵ带 �ߺ��� �����Ͽ� �������� ������
				   rs = stmt.executeQuery(strSQL1);
				   
				   while(rs.next()){                 //���� ���� �ڵ带 ������ ArrayList�� ����
					   if(rs.getString("Line").equals(a) && rs.getString("Process").equals(b)){
						   if(rs.getString("Status") == null || rs.getString("Status").isEmpty() || rs.getString("Status").equals("NULL"))
							   continue;
					   St_code = rs.getString("Status");
					   Status_code.add(St_code);
				       }
				   }
				   
				   rs = stmt.executeQuery(strSQL3);
				   while(rs.next()){
					   Status_Code_Code = rs.getString("Code");
					   st_code.add(Status_Code_Code);
					   Status_Code_Status = rs.getString("Status");
					   st_status.add(Status_Code_Status);
				   }
				      
				   for(int i=0; i<Status_code.size(); i++){
					   String strSQL2 = "SELECT COUNT(Status) FROM List_All WHERE Status = \"" + Status_code.get(i) + "\" and Line = \"" + a + "\" and Process = \"" + b + "\" and Stop >= \"" + T1 +  "\" and Stop <= \"" + T2 + "\"";   //�� ���� ������ �󵵼��� �������� ������
					   rs = stmt.executeQuery(strSQL2);
					   rs.next();
					   num = rs.getInt(1);
					   Status_count.add(num);
				   %>
				   {name: '<%=Status_code.get(i)%>', y: <%=Status_count.get(i)%>},
				   <%}
				   rs.close();
                   stmt.close();
                   conn.close();%>
                   ],

                   
           point: { events: { click: function (e) { go_pop(); }}},
           
       	    }],
    });
    
});
   </script>
   <!-- RIGHT -->
   <div class="col-md-3">
   <br/><br/>
   		<table border='1'>
   		<%for(int j=0; j<st_code.size(); j++){%>
   		<tr>
   		<td>
   		<%=st_code.get(j)%>
   		</td>
   		<td>
   		<%=st_status.get(j)%>
   		</td>
   		</tr>
   		<%} %>
   		</table>
</div>
</div>
</body>
</html>