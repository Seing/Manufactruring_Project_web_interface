<%-- 비가동 발생 원인 그래프로 나타내기 --%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("euc-kr"); %>
<%@ page import = "java.sql.*, java.util.*" %>
<%@ page import="apriori.ap"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>고장 원인 데이터</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<%
String a = request.getParameter("text_L");      //Select Box에서 선택한 라인값
String b = request.getParameter("text_P");      //Select Box에서 선택한 공정값
String s_d = request.getParameter("s_date");      //시작 날짜
String s_t = request.getParameter("s_time");      //시간
String e_d = request.getParameter("e_date");      //끝 날짜
String e_t = request.getParameter("e_time");      //시간
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
			<input type='button' value="고장 원인" onclick="location.href='Problem.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
			<input type='button' value="고장 현상" onclick="location.href='Status.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
			<input type='button' value="조치 내용" onclick="location.href='Solution.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
		</td>
		<td align='center'>
			<input type='button' value="시간대별 분석" onclick="location.href='Problem_Time.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
		</td>
		<td align='right'>
		<input type='button' value="메인 메뉴" onclick="location.href='Main.jsp';">
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
function go_pop(Name){
	window.open("predict.jsp?text_L="+a+"&text_P="+b+"&name="+Name+"&cycle="+cycle+"&recent="+recent+"&percent="+percent,"new","width=1500, height=800, resizable=yes, scrollvars=yes, status=no, location=no, directories=no;");
}
   
   $(function () {
    // Create the chart
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '비가동 발생 원인'
        },
        subtitle: {
            text: '고장 원인 선택시 세부적인 데이터 분석화면을 볼 수 있습니다.'
        },
        xAxis: {
        	//text : '고장 원인'
            type: 'category'
        },
        yAxis: {
            title: {
                text: '발생 빈도'
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
                }
            }
        },

        tooltip: {
            headerFormat: '<span style="font-size:5px">{series.name}</span><br>',
            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b> of total<br/>'
        },
        series: [{
            name: '원인',
            colorByPoint: true,
            data: [
                   <%

                   String T1 = s_d+" "+s_t+":00";
                   String T2 = e_d+" "+e_t+":00";


				   Class.forName("org.mariadb.jdbc.Driver");
				   Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");
				   Statement stmt = conn.createStatement();
				   ResultSet rs = null;
				   String Problem = null;
				   String P_code = null;
				   String Problem_Code_Code = null;
				   String Problem_Code_Problme = null;
				   int num = 0;
				   ArrayList<String> Problem_code = new ArrayList<String>();        //고장 원인 코드를 저장할 장소
				   ArrayList<Integer> Problem_count = new ArrayList<Integer>();        //고장 원인의 각 빈도수를 저장할 장소
				   ArrayList<String> p_code = new ArrayList<String>();              //고장 원인 코드 표를 그리기 위한 코드값
				   ArrayList<String> p_problem = new ArrayList<String>();           //고장 원인 코드 표를 그리기 위한 원인값
				   String strSQL1 = "SELECT DISTINCT Line, Process, Problem, Stop, Restart FROM List_All";   //고장 원인 코드를 중복값 제거하여 가져오는 쿼리문
				   String strSQL3 = "SELECT Code, Problem FROM Problem_Code";   //고장 원인 코드를 중복값 제거하여 가져오는 쿼리문
				   rs = stmt.executeQuery(strSQL1);
				   while(rs.next()){                 //고장 원인 코드를 가져와 ArrayList에 저장
					   Timestamp ts3 = Timestamp.valueOf(rs.getString("Stop"));
					   if(rs.getString("Line").equals(a) && rs.getString("Process").equals(b)){
						   if(rs.getString("Problem") == null || rs.getString("Problem").isEmpty() || rs.getString("Problem").equals("NULL"))
							   continue;
						   P_code = rs.getString("Problem");
					       Problem_code.add(P_code);
					   	   }
					   }
				   rs = stmt.executeQuery(strSQL3);
				   while(rs.next()){
					   Problem_Code_Code = rs.getString("Code");
					   p_code.add(Problem_Code_Code);
					   Problem_Code_Problme = rs.getString("Problem");
					   p_problem.add(Problem_Code_Problme);
				   }
				   
				   rs = stmt.executeQuery("select timestampdiff(minute, min(Stop), max(Stop)) as time, count(Stop) as count, max(Stop) as recent, SUM(Timestampdiff(minute, Stop, Restart)) as down_time from List_All where Line = \"" + a + "\" and Process = \"" + b + "\"");
				   rs.next();
				   double time = rs.getLong("time");          //비가동이 발생했던 총 기간
				   double count = rs.getLong("count");        //비가동 발생 빈도수
				   double rate_of_operation = 100-(rs.getLong("down_time")/time*100);
				   String recent = rs.getString("recent");  //마지막으로 비가동이 발생한 날짜
				   double cycle = time / count / 60 / 24;     //비가동 발생 주기
				   int cy = (int) cycle;
				   double percent = Double.parseDouble(String.format("%.2f",rate_of_operation));
				   System.out.println("time="+time);
				   System.out.println("total="+ percent);
				  
				   
				   for(int i=0; i<Problem_code.size(); i++){
					   String strSQL2 = "SELECT COUNT(Problem) FROM List_All WHERE Problem = \"" + Problem_code.get(i) + "\" and Line = \"" + a + "\" and Process = \"" + b + "\" and Stop >= \"" + T1 +  "\" and Stop <= \"" + T2 + "\"";   //각 고장 원인의 빈도수를 가져오는 쿼리문
					   rs = stmt.executeQuery(strSQL2);
					   rs.next();
					   num = rs.getInt(1);
					   Problem_count.add(num);
				   %>
				   {name: '<%=Problem_code.get(i)%>', y: <%=Problem_count.get(i)%>},
				   <%}
				   rs.close();
                   stmt.close();
                   conn.close();%>                  
                   ],
                   
           point: { events: { click: function (e) { go_pop(this.name); }}},
           
       	    }],
    });
    
});
   var a="<%=a%>";
   var b="<%=b%>";
   var cycle="<%=cy%>";
   var recent="<%=recent%>";
   var percent="<%=percent%>";
</script>
<!-- RIGHT -->
<div class="col-md-3">
<br/><br/>
		<table border='1'>
		<%for(int j=0; j<p_code.size(); j++){%>
		<tr>
		<td>
		<%=p_code.get(j)%>
		</td>
		<td>
		<%=p_problem.get(j)%>
		</td>
		</tr>
		<%} %>
		</table>
</div>
</div>
</body>
</html>