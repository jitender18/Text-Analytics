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
String curuser = String.valueOf(request.getSession().getAttribute("username"));
System.out.print("curuserfrom"+curuser);

String username=request.getParameter("user");
System.out.print("userto"+username);
String credit = request.getParameter("credits");
int credits = Integer.valueOf(credit);
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
	PreparedStatement ps=con.prepareCall("{call updateOp(?, ?, ?)}");
	
	ps.setString(1,username);
	ps.setString(2,curuser);
	ps.setInt(3,credits);
	/* ps.setString(3,branch);*/
	ResultSet rs=ps.executeQuery();
	out.print("<br>");	
	con.close();
	%>
	<jsp:forward page="success.jsp"></jsp:forward>
	<% 
}
catch(Exception e){e.printStackTrace();}

%>
</div>
</head>
</html>