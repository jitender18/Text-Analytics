<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>


<div id="outer">
<jsp:include page="header.jsp"></jsp:include>


<%
String islogin=(String)session.getAttribute("islogin");
if(islogin==null){
request.setAttribute("notlogin_msg","Sorry,Please do Login first");
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
}
%>

<%
/* String n=request.getParameter("val"); */
String username=request.getParameter("username");
System.out.print(username);
String report_type=request.getParameter("report");
System.out.print(report_type);
if (report_type.equals("Current")){
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
	//PreparedStatement ps1=con.prepareStatement("select * from credits order by empid");
	PreparedStatement ps=con.prepareStatement("select * from currentReport");
	/* ps.setString(1,username); */
	/* ps.setString(3,branch);*/
	ResultSet rs=ps.executeQuery();
	//ResultSet rs1=ps1.executeQuery();
	out.print("<br>");	
	out.print("<table border='5' cellspacing=5 cellpadding=2>");
	out.print("<tr><td><B>ID</B></a></td><td><B>Name</B></td><td><B>Monthly Credits Left</B></td><td><B>Gift Credits</B></td><td><B>Gift Cards Bought</B></td></tr>");

while(rs.next()){
	/* System.out.print("********** In while in home***********"); */
	out.print("<tr><td>"+rs.getString(1)+"</td>");
	out.print("<td>"+rs.getString(2)+"</td>");
	out.print("<td>"+rs.getString(3)+"</td>");
	out.print("<td>"+rs.getString(4)+"</td>");
	out.print("<td>"+rs.getString(5)+"</td></tr>");
//out.print("<a href='#' name='"+rs.getString(1)+"' onmouseover='javascript:sendGenInfo(this.name)' ><font style='color: navy;'><B>General Information</B></font></a>");
}
out.print("</table>");
con.close();
}catch(Exception e){e.printStackTrace();}}
//end of if

else if(report_type.equals("Aggregate")){
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
		PreparedStatement ps=con.prepareStatement("select * from aggregatePtsGivenReport");
		PreparedStatement ps1=con.prepareStatement("select * from aggregatePtsReceiveReport");
		/* ps.setString(1,username); */
		/* ps.setString(3,branch);*/
		ResultSet rs=ps.executeQuery();
		ResultSet rs1=ps1.executeQuery();
		out.print("<br>");	
		out.print("<table border='5' cellspacing=5 cellpadding=2>");
		out.print("<tr><td><B>ID</B></a></td><td><B>Name</B></td><td><B>Total Credits Given</B></td><td><B>Year</B></td><td><B>Month</B></td><td><B>Rank</B></td></tr>");

	while(rs.next()){
		/* System.out.print("********** In while in home***********"); */
		out.print("<tr><td>"+rs.getString(1)+"</td>");
		out.print("<td>"+rs.getString(2)+"</td>");
		out.print("<td>"+rs.getString(3)+"</td>");
		out.print("<td>"+rs.getString(4)+"</td>");
		out.print("<td>"+rs.getString(5)+"</td>");
		out.print("<td>"+rs.getString(6)+"</td></tr>");
	//out.print("<a href='#' name='"+rs.getString(1)+"' onmouseover='javascript:sendGenInfo(this.name)' ><font style='color: navy;'><B>General Information</B></font></a>");
	}
	out.print("</table>");
	
	out.print("<br>");	
	out.print("<table border='5' cellspacing=5 cellpadding=2>");
	out.print("<tr><td><B>ID</B></a></td><td><B>Name</B></td><td><B>Total Credits Received</B></td><td><B>Year</B></td><td><B>Month</B></td><td><B>Rank</B></td></tr>");

while(rs1.next()){
	/* System.out.print("********** In while in home***********"); */
		out.print("<tr><td>"+rs1.getString(1)+"</td>");
		out.print("<td>"+rs1.getString(2)+"</td>");
		out.print("<td>"+rs1.getString(3)+"</td>");
		out.print("<td>"+rs1.getString(4)+"</td>");
		out.print("<td>"+rs1.getString(5)+"</td>");
		out.print("<td>"+rs1.getString(6)+"</td></tr>");
//out.print("<a href='#' name='"+rs.getString(1)+"' onmouseover='javascript:sendGenInfo(this.name)' ><font style='color: navy;'><B>General Information</B></font></a>");
}
out.print("</table>");
	con.close();
	}catch(Exception e){e.printStackTrace();}}
	
else if(report_type.equals("Usage")){
	try{
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
		PreparedStatement ps=con.prepareStatement("select ids.empid, emp_first_name, emp_last_name from ((select distinct empid from employee where emp_type != 'Admin') minus (select from_empid from (select distinct from_empid, sum(credits) total from transanctions where EXTRACT(month FROM month_date) = ? and EXTRACT(Year FROM month_date) = ? and from_empid != to_empid group by from_empid )where total >= 1000)) ids, employee_details where ids.empid = employee_details.empid");
	
		ps.setString(1, month);
		ps.setString(2, year);
		ResultSet rs=ps.executeQuery();

		out.print("<br>");	
		out.print("<table border='5' cellspacing=5 cellpadding=2>");
		out.print("<tr><td><B>ID</B></a></td><td><B>First Name</B></td><td><B>Last Name</B></td></tr>");

	while(rs.next()){
		/* System.out.print("********** In while in home***********"); */
		out.print("<tr><td>"+rs.getString(1)+"</td>");
		out.print("<td>"+rs.getString(2)+"</td>");
		out.print("<td>"+rs.getString(3)+"</td></tr>");
	//out.print("<a href='#' name='"+rs.getString(1)+"' onmouseover='javascript:sendGenInfo(this.name)' ><font style='color: navy;'><B>General Information</B></font></a>");
	}
	out.print("</table>");
	con.close();
	}catch(Exception e){e.printStackTrace();}}
		


else if(report_type.equals("Redeem")){
	try{
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
		PreparedStatement ps=con.prepareStatement("select ids.from_empid, emp_first_name, emp_last_name, total from (select from_empid, total from (select distinct from_empid, sum(1) total from transanctions where EXTRACT(month FROM month_date) = ? and EXTRACT(Year FROM month_date) = ? and from_empid = to_empid group by from_empid )) ids, employee_details where ids.from_empid = employee_details.empid");
	
		ps.setString(1, month);
		ps.setString(2, year);
		ResultSet rs=ps.executeQuery();

		out.print("<br>");	
		out.print("<table border='5' cellspacing=5 cellpadding=2>");
		out.print("<tr><td><B>ID</B></a></td><td><B>First Name</B></td><td><B>Last Name</B></td><td><B>No. of gifts</B></td></tr>");

	while(rs.next()){
		/* System.out.print("********** In while in home***********"); */
		out.print("<tr><td>"+rs.getString(1)+"</td>");
		out.print("<td>"+rs.getString(2)+"</td>");
		out.print("<td>"+rs.getString(3)+"</td>");
		out.print("<td>"+rs.getString(4)+"</td></tr>");
	//out.print("<a href='#' name='"+rs.getString(1)+"' onmouseover='javascript:sendGenInfo(this.name)' ><font style='color: navy;'><B>General Information</B></font></a>");
	}
	out.print("</table>");
	con.close();
	}catch(Exception e){e.printStackTrace();}}




%>