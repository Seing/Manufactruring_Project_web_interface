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
			<input type='button' value="시간별 비가동 발생 빈도" onclick="location.href='Problem_Time.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
			<input type='button' value="월별 비가동 발생 빈도" onclick="location.href='Problem_Month.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
		</td>
		<td align='center'>
			<input type='button' value="고장코드별 분석" onclick="location.href='Problem.jsp?text_L=<%=a%>&text_P=<%=b%>&s_date=<%=s_d%>&s_time=<%=s_t%>&e_date=<%=e_d%>&e_time=<%=e_t%>';">
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
var a="<%=a%>";
var b="<%=b%>";
function go_pop(Name){
	//alert(Name);
	window.open("predict.jsp?text_L="+a+"&text_P="+b+"&name="+Name,"new","width=1000, height=800, resizable=yes, scrollvars=yes, status=no, location=no, directories=no;");
}
   
   $(function () {
    // Create the chart
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '시간대별 비가동 발생 빈도'
        },
        subtitle: {
            text: '-'
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

                   Timestamp ts1 = Timestamp.valueOf(s_d+" "+s_t+":00");
                   Timestamp ts2 = Timestamp.valueOf(e_d+" "+e_t+":00");

				   Class.forName("org.mariadb.jdbc.Driver");
				   Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");
				   Statement stmt = conn.createStatement();
				   ResultSet rs = null;
				   String Problem = null;
				   String P_code = null;
				   String Time = null;
				   String Problem_Code_Code = null;
				   String Problem_Code_Problme = null;
				   int num = 0;
				   int[] Time_array = new int[24];             //시간대별 고장 빈도수값 저장할 배열
				   for(int i=0; i<24; i++){
					   Time_array[i] = 0;
				   }
				   ArrayList<String> Problem_code = new ArrayList<String>();        //고장 원인 코드를 저장할 장소
				   ArrayList<Integer> Problem_count = new ArrayList<Integer>();        //고장 원인의 각 빈도수를 저장할 장소
				   ArrayList<String> p_code = new ArrayList<String>();              //고장 원인 코드 표를 그리기 위한 코드값
				   ArrayList<String> p_problem = new ArrayList<String>();           //고장 원인 코드 표를 그리기 위한 원인값
				   String strSQL1 = "SELECT DISTINCT Line, Process, Problem, Stop, Restart FROM List_All";   //고장 원인 코드를 중복값 제거하여 가져오는 쿼리문
				   String strSQL3 = "SELECT Code, Problem FROM Problem_Code";   //고장 원인 코드를 중복값 제거하여 가져오는 쿼리문
				   rs = stmt.executeQuery(strSQL1);
				   while(rs.next()){                 //고장 원인 코드를 가져와 ArrayList에 저장
					   //Timestamp ts3 = Timestamp.valueOf(rs.getString("Stop"));
				   Time = rs.getString("Stop");
				   
					   if(rs.getString("Line").equals(a) && rs.getString("Process").equals(b)){
						   if(rs.getString("Problem") == null || rs.getString("Problem").isEmpty() || rs.getString("Problem").equals("NULL"))
							   continue;
						   if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=1){
							   Time_array[0]++;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=2){
							   Time_array[1] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=3){
							   Time_array[2] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=4){
							   Time_array[3] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=5){
							   Time_array[4] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=6){
							   Time_array[5] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=7){
							   Time_array[6] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=8){
							   Time_array[7] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=9){
							   Time_array[8] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=10){
							   Time_array[9] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=11){
							   Time_array[10] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=12){
							   Time_array[11] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=13){
							   Time_array[12] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=14){
							   Time_array[13] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=15){
							   Time_array[14] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=16){
							   Time_array[15] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=17){
							   Time_array[16] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=18){
							   Time_array[17] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=19){
							   Time_array[18] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=20){
							   Time_array[19] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=21){
							   Time_array[20] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=22){
							   Time_array[21] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=23){
							   Time_array[22] += 1;
						   }
						   else if(Integer.parseInt(rs.getString("Stop").substring(11,13))<=24){
							   Time_array[23] += 1;
						   }
						   P_code = rs.getString("Problem");
					       Problem_code.add(P_code);
					   	   }
					   }
				   //}
				   
				   rs = stmt.executeQuery(strSQL3);
				   while(rs.next()){
					   Problem_Code_Code = rs.getString("Code");
					   p_code.add(Problem_Code_Code);
					   Problem_Code_Problme = rs.getString("Problem");
					   p_problem.add(Problem_Code_Problme);
				   }
				   rs.close();
                   stmt.close();
                   conn.close();
				   %>
				   {name: '0~1', y: <%=Time_array[0]%>},
				   {name: '1~2', y: <%=Time_array[1]%>},
				   {name: '2~3', y: <%=Time_array[2]%>},
				   {name: '3~4', y: <%=Time_array[3]%>},
				   {name: '4~5', y: <%=Time_array[4]%>},
				   {name: '5~6', y: <%=Time_array[5]%>},
				   {name: '6~7', y: <%=Time_array[6]%>},
				   {name: '7~8', y: <%=Time_array[7]%>},
				   {name: '8~9', y: <%=Time_array[8]%>},
				   {name: '9~10', y: <%=Time_array[9]%>},
				   {name: '10~11', y: <%=Time_array[10]%>},
				   {name: '11~12', y: <%=Time_array[11]%>},
				   {name: '12~13', y: <%=Time_array[12]%>},
				   {name: '13~14', y: <%=Time_array[13]%>},
				   {name: '14~15', y: <%=Time_array[14]%>},
				   {name: '15~16', y: <%=Time_array[15]%>},
				   {name: '16~17', y: <%=Time_array[16]%>},
				   {name: '17~18', y: <%=Time_array[17]%>},
				   {name: '18~19', y: <%=Time_array[18]%>},
				   {name: '19~20', y: <%=Time_array[19]%>},
				   {name: '20~21', y: <%=Time_array[20]%>},
				   {name: '21~22', y: <%=Time_array[21]%>},
				   {name: '22~23', y: <%=Time_array[22]%>},
				   {name: '23~24', y: <%=Time_array[23]%>}, 
        ],
                   
          // point: { events: { click: function (e) { go_pop(this.name); }}},
           
       	    }],
    });
    
});
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