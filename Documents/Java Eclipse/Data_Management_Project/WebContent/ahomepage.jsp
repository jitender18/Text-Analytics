<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>

<div id="outer">

<jsp:include page="header.jsp"></jsp:include>

    <title>Select a type of report you want to see</title>

</head>
<body>
 <a href="reset.jsp">Reset the monthly credits of all users to 1000 !!</a><br><br>
 <div class="box">
 
 <form method="post" action="areport.jsp" >
					<table>
					<tr><td style="color:navy;"><B> Select a report type </B></td></tr>
					<tr><td><br></td></tr>
					<tr><td>I want to see a :</td><td><select name="report">
					<option>Select a report</option>
					<option>Current</option>
					<option>Aggregate</option>
					<option>Usage</option>
					<option>Redeem</option>
					</select></td><td>Report</td></tr>
					<tr><td><br></td></tr>
					
					<tr><td style="color:navy;"><B> Select a month </B></td></tr>
					<tr><td><br></td></tr>
					<tr><td>I want to see a :</td><td><select name="month">
					<option>Select month</option>
					<option>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
					<option>6</option>
					<option>7</option>
					<option>8</option>
					<option>9</option>
					<option>10</option>
					<option>11</option>
					<option>12</option>
					</select></tr>
					
					<tr><td style="color:navy;"><B> Select a year </B></td></tr>
					<tr><td><br></td></tr>
					<tr><td>I want to see a :</td><td><select name="year">
					
					<option>2018</option>
					</select></tr>
					
					<tr><td></<td><td></td><td><input type="submit" value="Go"></td></tr>
					
					</table>
					</form>
 </div>
 

</body>
</html>