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

/* String username=request.getParameter("user");
System.out.print("userto"+username); */
String credit = request.getParameter("credits");
int credits = Integer.valueOf(credit);
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
	
	PreparedStatement ps=con.prepareStatement("select * from employee where email = ?");
	ps.setString(1,curuser);
	ResultSet rs=ps.executeQuery();
	System.out.print("Id in debit ");
	rs.next();
	int id = Integer.valueOf(rs.getString(1));
	System.out.print(id);
	
	PreparedStatement ps0=con.prepareCall("select gift_credits from credits where empid = ?");
	ps0.setInt(1, id);
	ResultSet rs0=ps0.executeQuery();
	rs0.next();
	
	int gift_credits = Integer.valueOf(rs0.getString(1));
	System.out.print(gift_credits);
	
	if(gift_credits>=10000){
	
	PreparedStatement ps1=con.prepareCall("{call redeemOp(?, ?)}");
	
	ps1.setString(1,curuser);
	/* ps.setString(2,curuser);*/
	ps1.setInt(2,credits);
	/* ps.setString(3,branch);*/
	ResultSet rs1=ps1.executeQuery();
	con.close();
	
	%>
	<jsp:forward page="redeemed.jsp"></jsp:forward>
	<% 
	}
	
	out.print("You don't have sufficient credits to redeem!!");
	out.print("<br>");	
	con.close();
	%>
	<jsp:forward page="redeem.jsp"></jsp:forward>
	<% 
}
catch(Exception e){e.printStackTrace();}

%>
</div>
</head>
</html>