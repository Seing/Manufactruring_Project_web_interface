package apriori;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import weka.associations.Apriori;
import weka.core.*;
import weka.experiment.InstanceQuery;

import java.sql.*;

public class ap {
	
	public static String text_L;     //선택한 라인값
	public static String text_P;     //선택한 공정값
	public static String name;
	public String resultapriori;
	public String[] exploded = null;
	
	public ArrayList<String> Problem_code = new ArrayList<String>();        //고장 원인 코드를 저장할 장소
	public ArrayList<String> Status_code = new ArrayList<String>();        //고장 원인 코드를 저장할 장소
	public ArrayList<String> Solution_code = new ArrayList<String>();        //고장 원인 코드를 저장할 장소
	public String att_a;        //고장 원인 코드를 저장할 장소
	public String att_b;        //고장 원인 코드를 저장할 장소
	public String att_c;        //고장 원인 코드를 저장할 장소
	public String data_code;        //고장 원인 코드를 저장할 장소
	public String Last = "";

	
	
	String driver	= "org.mariadb.jdbc.Driver";
	String url		= "jdbc:mariadb://210.125.146.146:3306/DALAB";
	String uId		= "yura";
	String uPwd		= "1234";
	
	Connection			con;
	PreparedStatement	pstmt;
	ResultSet			rs;
	
	//Problem.jsp에서 Select Box로 선택한 라인값과 공정값 가져오기
	public ap(String a, String b, String c){
		this.text_L = a;
		this.text_P = b;
		this.name = c;
	}
	

	
	//걍 테스트 값 확인해봄
	public String testPrint() throws Exception{
		
    	InstanceQuery query = new InstanceQuery();
    	query.setDatabaseURL(url);
    	query.setUsername(uId);
    	query.setPassword(uPwd);
    	query.setQuery("select Problem, Status, Solution from List_All where Line=\""+text_L+"\" and Process=\""+text_P+"\"");
    	Instances data = query.retrieveInstances();

		double deltaValue = 0.05;
		double lowerBoundMinSupportValue = 0.05;
		double minMetricValue = 0.5;
		int numRulesValue = 10;
		double upperBoundMinSupportValue = 1.0;
		Apriori apriori = new Apriori();
		apriori.setDelta(deltaValue);
		apriori.setLowerBoundMinSupport(lowerBoundMinSupportValue);
		apriori.setNumRules(numRulesValue);
		apriori.setUpperBoundMinSupport(upperBoundMinSupportValue);
		apriori.setMinMetric(minMetricValue);
		try {
			apriori.buildAssociations( data );
			}
		catch ( Exception e ) {
			e.printStackTrace();
			}
		resultapriori = apriori.toString();
		exploded = resultapriori.split("\n");
		for(int i = 0; i < exploded.length - 1; i++){
			if(exploded[i].equals("Best rules found:")){
				resultapriori = "";
				for(int j = i+1; j < exploded.length; j++){
					resultapriori += exploded[j]+"?";
				}
			}
		}
		return resultapriori;
	}

	
	public void apriori() {
		data_code = "@data\n";
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, uId, uPwd);
			if(con != null){System.out.println("데이터 베이스 접속 성공");}
		}
		catch(ClassNotFoundException e){System.out.println("드라이버 로드 실패");}
		catch(SQLException e){System.out.println("데이터 베이스 접속 실패");}
		
        String sql_1    = "select  DISTINCT Line, Process, Problem, Status, Solution FROM List_All";
        try {
            pstmt                = con.prepareStatement(sql_1);
            rs                   = pstmt.executeQuery();
            while(rs.next()){
				   if(rs.getString("Line").equals(this.text_L) && rs.getString("Process").equals(this.text_P)){
				       Problem_code.add(rs.getString("Problem"));
				       Status_code.add(rs.getString("Status"));
				       Solution_code.add(rs.getString("Solution"));
				       data_code += rs.getString("Problem") + "," + rs.getString("Status") + "," + rs.getString("Solution") + "\n";
				   }
            }
        } catch (SQLException e) { System.out.println("쿼리 수행 실패"); }
        
//        String sql_2    = "select Details from List_All where Problem ="+ name +"\"";
//        try {
//            pstmt                = con.prepareStatement(sql_2);
//            rs                   = pstmt.executeQuery();
//            while(rs.next()){
//				       Details.add(rs.getString("Details"));
//				   }
//        } catch (SQLException e) { System.out.println("쿼리 수행 실패"); }
	}
	
	public ArrayList<String> Details() {
		ArrayList<String> Details = new ArrayList<String>();  
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, uId, uPwd);
			if(con != null){System.out.println("데이터 베이스 접속 성공");}
		}
		catch(ClassNotFoundException e){System.out.println("드라이버 로드 실패");}
		catch(SQLException e){System.out.println("데이터 베이스 접속 실패");}
		
        String sql_2    = "select distinct Details ,Stop from List_All where Problem = '"+ this.name +"'order by Stop ASC";
        try {
            pstmt                = con.prepareStatement(sql_2);
            rs                   = pstmt.executeQuery();
            while(rs.next()){
//            		System.out.println(rs.getString("Details"));
				       Details.add(rs.getString("Stop") + " ----> " + rs.getString("Details"));
				   }
        } catch (SQLException e) { System.out.println("쿼리 수행 실패"); }
        return Details;
	}
	
}