<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="apriori.ap"%>
<%@ page import = "java.sql.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
<script src="http://d3js.org/dr.v3.min.js" charset="utf-8"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
<center><h1>설비 비가동 정보</h1></center>
<h2>① 발생 원인, 현상, 조치 내역</h2>
<!-- 최적 룰 top3를 rules[]배열에 각각 저장 -->

<%
String A = request.getParameter("text_L");      //Select Box에서 선택한 라인값
String B = request.getParameter("text_P");      //Select Box에서 선택한 공정값
String C = request.getParameter("name");
String recent = request.getParameter("recent");      //Select Box에서 선택한 라인값
String cycle = request.getParameter("cycle");      //Select Box에서 선택한 공정값
String percent = request.getParameter("percent");      //Select Box에서 선택한 공정값
System.out.println(C);

ap a = new ap(A, B, C);
String Allrules = a.testPrint();
String[] rules = null;
rules = Allrules.split("\\?");  //룰 전체 문자 값

ArrayList<String> R = new ArrayList<String>();

String rule1 = rules[1].substring(0, rules[1].indexOf("lift"));
rule1 = rule1.replace("=", " ");
rule1 = rule1.replace("Status", "현상");
rule1 = rule1.replace("Problem", "원인");
rule1 = rule1.replace("Solution", "조치");

String rule2 = rules[2].substring(0, rules[2].indexOf("lift"));
rule2 = rule2.replace("=", " ");
rule2 = rule2.replace("Status", "현상");
rule2 = rule2.replace("Problem", "원인");
rule2 = rule2.replace("Solution", "조치");

String rule3 = rules[3].substring(0, rules[3].indexOf("lift"));
rule3 = rule3.replace("=", " ");
rule3 = rule3.replace("Status", "현상");
rule3 = rule3.replace("Problem", "원인");
rule3 = rule3.replace("Solution", "조치");

String rule4 = rules[4].substring(0, rules[4].indexOf("lift"));
rule4 = rule4.replace("=", " ");
rule4 = rule4.replace("Status", "현상");
rule4 = rule4.replace("Problem", "원인");
rule4 = rule4.replace("Solution", "조치");

String rule5 = rules[5].substring(0, rules[5].indexOf("lift"));
rule5= rule5.replace("=", " ");
rule5 = rule5.replace("Status", "현상");
rule5 = rule5.replace("Problem", "원인");
rule5 = rule5.replace("Solution", "조치");

String rule6 = rules[6].substring(0, rules[6].indexOf("lift"));
rule6= rule6.replace("=", " ");
rule6 = rule6.replace("Status", "현상");
rule6 = rule6.replace("Problem", "원인");
rule6 = rule6.replace("Solution", "조치");

String rule7 = rules[7].substring(0, rules[7].indexOf("lift"));
rule7= rule7.replace("=", " ");
rule7 = rule7.replace("Status", "현상");
rule7 = rule7.replace("Problem", "원인");
rule7 = rule7.replace("Solution", "조치");

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");
Statement stmt = conn.createStatement();
ResultSet rs = null;

String[] Text1 = null;
String[] Text2 = null;
String[] Text3 = null;
String[] Text4 = null;
String[] Text5 = null;
String[] Text6 = null;
String[] Text7 = null;
String[] row = null;
Text1 = rule1.split(" ");
Text2 = rule2.split(" ");
Text3 = rule3.split(" ");
Text4 = rule4.split(" ");
Text5 = rule5.split(" ");
Text6 = rule6.split(" ");
Text7 = rule7.split(" ");

//룰1번 코드값 바꾸기
for(int i=0; i<Text1.length; i++){
	if(Text1[i].equals("현상")){//TRUE
		rs = stmt.executeQuery("SELECT Status FROM Status_Code where Code LIKE \"%"+Text1[i+1]+"%\"");
		while(rs.next()){
			Text1[i+1] = "["+rs.getString("Status")+"]";
		}
	}
	if(Text1[i].equals("원인")){//TRUE
		rs = stmt.executeQuery("SELECT Problem FROM Problem_Code where Code LIKE \"%"+Text1[i+1]+"%\"");
		while(rs.next()){
			Text1[i+1] = "["+rs.getString("Problem")+"]";
		}
	}
	if(Text1[i].equals("조치")){//TRUE
		rs = stmt.executeQuery("SELECT Solution FROM Solution_Code where Code LIKE \"%"+Text1[i+1]+"%\"");
		while(rs.next()){
			Text1[i+1] = "["+rs.getString("Solution")+"]";
		}
	}
	if(Text1[i].equals(">")){
		Text1[i] = "<font color='red'>  ======= ▷</font>";
	}
}

//룰2번 코드값 바꾸기
for(int i=0; i<Text2.length; i++){
	if(Text2[i].equals("현상")){//TRUE
		rs = stmt.executeQuery("SELECT Status FROM Status_Code where Code LIKE \"%"+Text2[i+1]+"%\"");
		while(rs.next()){
			Text2[i+1] = "["+rs.getString("Status")+"]";
		}
	}
	if(Text2[i].equals("원인")){//TRUE
		rs = stmt.executeQuery("SELECT Problem FROM Problem_Code where Code LIKE \"%"+Text2[i+1]+"%\"");
		while(rs.next()){
			Text2[i+1] = "["+rs.getString("Problem")+"]";
		}
	}
	if(Text2[i].equals("조치")){//TRUE
		rs = stmt.executeQuery("SELECT Solution FROM Solution_Code where Code LIKE \"%"+Text2[i+1]+"%\"");
		while(rs.next()){
			Text2[i+1] = "["+rs.getString("Solution")+"]";
		}
	}
	if(Text2[i].equals(">")){
		Text2[i] = "<font color='red'>  ======= ▷</font>";
	}
}

//룰3번 코드값 바꾸기
for(int i=0; i<Text3.length; i++){
	if(Text3[i].equals("현상")){//TRUE
		rs = stmt.executeQuery("SELECT Status FROM Status_Code where Code LIKE \"%"+Text3[i+1]+"%\"");
		while(rs.next()){
			Text3[i+1] = "["+rs.getString("Status")+"]";
		}
	}
	if(Text3[i].equals("원인")){//TRUE
		rs = stmt.executeQuery("SELECT Problem FROM Problem_Code where Code LIKE \"%"+Text3[i+1]+"%\"");
		while(rs.next()){
			Text3[i+1] = "["+rs.getString("Problem")+"]";
		}
	}
	if(Text3[i].equals("조치")){//TRUE
		rs = stmt.executeQuery("SELECT Solution FROM Solution_Code where Code LIKE \"%"+Text3[i+1]+"%\"");
		while(rs.next()){
			Text3[i+1] = "["+rs.getString("Solution")+"]";
		}
	}
	if(Text3[i].equals(">")){
		Text3[i] = "<font color='red'>  ======= ▷</font>";
	}
}

//룰4번 코드값 바꾸기
for(int i=0; i<Text4.length; i++){
	if(Text4[i].equals("현상")){//TRUE
		rs = stmt.executeQuery("SELECT Status FROM Status_Code where Code LIKE \"%"+Text4[i+1]+"%\"");
		while(rs.next()){
			Text4[i+1] = "["+rs.getString("Status")+"]";
		}
	}
	if(Text4[i].equals("원인")){//TRUE
		rs = stmt.executeQuery("SELECT Problem FROM Problem_Code where Code LIKE \"%"+Text4[i+1]+"%\"");
		while(rs.next()){
			Text4[i+1] = "["+rs.getString("Problem")+"]";
		}
	}
	if(Text4[i].equals("조치")){//TRUE
		rs = stmt.executeQuery("SELECT Solution FROM Solution_Code where Code LIKE \"%"+Text4[i+1]+"%\"");
		while(rs.next()){
			Text4[i+1] = "["+rs.getString("Solution")+"]";
		}
	}
	if(Text4[i].equals(">")){
		Text4[i] = "<font color='red'>  ======= ▷</font>";
	}
}

//룰5번 코드값 바꾸기
for(int i=0; i<Text5.length; i++){
	if(Text5[i].equals("현상")){//TRUE
		rs = stmt.executeQuery("SELECT Status FROM Status_Code where Code LIKE \"%"+Text5[i+1]+"%\"");
		while(rs.next()){
			Text5[i+1] = "["+rs.getString("Status")+"]";
		}
	}
	if(Text5[i].equals("원인")){//TRUE
		rs = stmt.executeQuery("SELECT Problem FROM Problem_Code where Code LIKE \"%"+Text5[i+1]+"%\"");
		while(rs.next()){
			Text5[i+1] = "["+rs.getString("Problem")+"]";
		}
	}
	if(Text5[i].equals("조치")){//TRUE
		rs = stmt.executeQuery("SELECT Solution FROM Solution_Code where Code LIKE \"%"+Text5[i+1]+"%\"");
		while(rs.next()){
			Text5[i+1] = "["+rs.getString("Solution")+"]";
		}
	}
	if(Text5[i].equals(">")){
		Text5[i] = "<font color='red'>  ======= ▷</font>";
	}
}

//룰6번 코드값 바꾸기
for(int i=0; i<Text6.length; i++){
	if(Text6[i].equals("현상")){//TRUE
		rs = stmt.executeQuery("SELECT Status FROM Status_Code where Code LIKE \"%"+Text6[i+1]+"%\"");
		while(rs.next()){
			Text6[i+1] = "["+rs.getString("Status")+"]";
		}
	}
	if(Text6[i].equals("원인")){//TRUE
		rs = stmt.executeQuery("SELECT Problem FROM Problem_Code where Code LIKE \"%"+Text6[i+1]+"%\"");
		while(rs.next()){
			Text6[i+1] = "["+rs.getString("Problem")+"]";
		}
	}
	if(Text6[i].equals("조치")){//TRUE
		rs = stmt.executeQuery("SELECT Solution FROM Solution_Code where Code LIKE \"%"+Text6[i+1]+"%\"");
		while(rs.next()){
			Text6[i+1] = "["+rs.getString("Solution")+"]";
		}
	}
	if(Text6[i].equals(">")){
		Text6[i] = "<font color='red'>  ======= ▷</font>";
	}
}

//룰7번 코드값 바꾸기
for(int i=0; i<Text7.length; i++){
	if(Text7[i].equals("현상")){//TRUE
		rs = stmt.executeQuery("SELECT Status FROM Status_Code where Code LIKE \"%"+Text7[i+1]+"%\"");
		while(rs.next()){
			Text7[i+1] = "["+rs.getString("Status")+"]";
		}
	}
	if(Text7[i].equals("원인")){//TRUE
		rs = stmt.executeQuery("SELECT Problem FROM Problem_Code where Code LIKE \"%"+Text7[i+1]+"%\"");
		while(rs.next()){
			Text7[i+1] = "["+rs.getString("Problem")+"]";
		}
	}
	if(Text7[i].equals("조치")){//TRUE
		rs = stmt.executeQuery("SELECT Solution FROM Solution_Code where Code LIKE \"%"+Text7[i+1]+"%\"");
		while(rs.next()){
			Text7[i+1] = "["+rs.getString("Solution")+"]";
		}
	}
	if(Text7[i].equals(">")){
		Text7[i] = "<font color='red'>  ======= ▷</font>";
	}
}

ArrayList<String> AllDetaills = a.Details();
%>

<br><%for(int i=0; i<Text1.length; i++){
		out.println(Text1[i]);}%> <!--1번 룰-->
<br>
<br><%for(int i=0; i<Text2.length; i++){
		out.println(Text2[i]);}%> <!--2번 룰-->
<br>

<br><%for(int i=0; i<Text3.length; i++){
		out.println(Text3[i]);}%> <!--3번 룰-->
<br>

<br><%for(int i=0; i<Text4.length; i++){
		out.println(Text4[i]);}%> <!--4번 룰-->
<br>
<br><%for(int i=0; i<Text5.length; i++){
		out.println(Text5[i]);}%> <!--5번 룰-->
<br>
<br><%for(int i=0; i<Text6.length; i++){
		out.println(Text6[i]);}%> <!--6번 룰-->
<br>
<br><%for(int i=0; i<Text7.length; i++){
		out.println(Text7[i]);}%> <!--7번 룰-->
<br>
<hr>

<h2>② 발생 주기 및 최근 발생 일자 </h2>
<br>비가동 발생 주기 : <font color='red' size='6'><%out.println(cycle);%></font>일<br>
<br>최근 비가동 발생 일자 : <font color='red' size='4'><%out.println(recent);%></font><br><hr>

<h2>③ 설비 가동률</h2>
<div style="width: 600px; height: 200px; margin: 0px">
    <div id="container-speed" style="width: 600px; height: 200px; float: left"></div>
</div><hr>


<h2>④ 과거 조치 내역</h2>
<br>
<table border ='1' bgcolor='#C4FDFF'>
	<%for(int i = 0; i < AllDetaills.size(); i++){%>
<tr>
<td>
	<%out.println(AllDetaills.get(i));%>
</td>
</tr>
<%}%>
</table>

<script type="text/javascript">
$(function () {

    var gaugeOptions = {

        chart: {
            type: 'solidgauge'
        },

        title: null,

        pane: {
            center: ['50%', '85%'],
            size: '140%',
            startAngle: -90,
            endAngle: 90,
            background: {
                backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
                innerRadius: '60%',
                outerRadius: '100%',
                shape: 'arc'
            }
        },

        tooltip: {
            enabled: false
        },

        // the value axis
        yAxis: {
            stops: [
                [0.1, '#55BF3B'], // green
                [0.5, '#DDDF0D'], // yellow
                [0.9, '#DF5353'] // red
            ],
            lineWidth: 0,
            minorTickInterval: null,
            tickAmount: 2,
            title: {
                y: -70
            },
            labels: {
                y: 16
            }
        },

        plotOptions: {
            solidgauge: {
                dataLabels: {
                    y: 5,
                    borderWidth: 0,
                    useHTML: true
                }
            }
        }
    };

    // The speed gauge
    $('#container-speed').highcharts(Highcharts.merge(gaugeOptions, {
        yAxis: {
            min: 0,
            max: 100,
            title: {
                text: '가동률'
            }
        },

        credits: {
            enabled: false
        },

        series: [{
            name: 'percent',
            data: [<%=percent%>],
            dataLabels: {
                format: '<div style="text-align:center"><span style="font-size:25px;color:' +
                    ((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y}</span><br/>' +
                       '<span style="font-size:20px;color:silver">%</span></div>'
            },
            tooltip: {
                valueSuffix: ' %'
            }
        }]

    }));
});
</script>
</div>
</body>
</html>