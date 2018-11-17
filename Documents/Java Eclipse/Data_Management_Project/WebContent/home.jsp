<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>


<div id="outer">
<jsp:include page="header.jsp"></jsp:include>

<%

String username=String.valueOf(request.getSession().getAttribute("username"));
System.out.print(username);

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
	PreparedStatement ps=con.prepareStatement("select * from employee where email = ?");
	ps.setString(1,username);
	ResultSet rs=ps.executeQuery();
	System.out.print("email");
	rs.next();
	int id = Integer.valueOf(rs.getString(1));
	//session.setAttribute("user", username);
	PreparedStatement ps1=con.prepareStatement("select * from credits where empid = ?");
	ps1.setInt(1, id);
	/* ps.setString(3,branch);*/
	ResultSet rs1=ps1.executeQuery();
	rs1.next();
	/* int credits = Integer.valueOf(rs1.getString(2)); */
	
	System.out.print("credits");
	/* System.out.print(credits); */
	
	PreparedStatement ps2=con.prepareStatement("select emp_first_name from employee_details where empid != ? and empid != 10 and empid != 7");
	ps2.setInt(1, id);
	ResultSet rs2=ps2.executeQuery();
	System.out.print("here");
	

 %>
 
 
 
 <p>Your credits:<% out.print("<td>"+rs1.getString(2)+"</td>");%>
 </p><br>

<form method="post" action="credits.jsp">

<table>
<tr><td>
<p>Select Name :
<select name = "user">
<%
while(rs2.next())
{
String fname = rs2.getString(1); 
%>
<option value="<%=fname %>"><%=fname %></option>
<%
}
%>
</select>
</p>
<%
con.close();
}
catch(SQLException sqe)
{ 
out.println(sqe);
}
%></td>
<td><select name="credits">
					<option>Select no. of credits</option>
					<option>100</option>
					<option>200</option>
					<option>500</option>
					<option>800</option>
					</select></td><td><input type="submit" value="Go"></td>

</tr>
</table>

</form>

</div>
</head>
</html>