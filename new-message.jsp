<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {			//test if the userid is set in the session
			response.sendRedirect("index.jsp");				//redirect the user to index.jsp
		return;												//stop executing commands
	}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
<%

List<String> friends = new ArrayList<String>();				//create a string list to store all recipient ids
for(Enumeration all_vars = request.getParameterNames(); all_vars.hasMoreElements() ;){ //iterate through the variables sent in this request
	String val = (String) all_vars.nextElement(); 			// store the current element in a variable, val
	if(val.startsWith("recipient")){						//test if the value starts with recipient
		friends.add(val.substring(9));						//Add the element to the recipient ids list
	}
}
%>
<%-- CREATE A PAGE-LEVEL sql query to fetch the names of the recipients --%>
<sql:query var="rs" dataSource="jdbc/fakebook">
SELECT id,firstname, lastname from profile where id in
	(SELECT '0'
	<% 
	for(String friend : friends){	
		out.print( " UNION SELECT " + friend); 
	}
	%>)
</sql:query>

<jsp:include page="includes/links.jsp" />	
		<div id="content">
			<div class="message">
			<p>
				Type the message you want to send and click 'Send'.
			</p>
				<form action="send-message.jsp" method="post">
				<h2 class="sender">Recipients: 
<!-- PRINT ALL RECIPIENT NAMES -->
<c:forEach var="row" items="${rs.rows}">
					<input type="hidden" value="on" name="recipient${row.id}">	<!-- add the recipient's id as a hidden field -->
					<span>${row.firstname} ${row.lastname}</span>				<!-- print the recipient's name -->
</c:forEach>	
				</h2>
				<div class="clear"></div>
				<textarea class="body" name="message"></textarea>
				<div class="manage">
					<input name="send" type="submit" value="Send"/>
				</div>
				</form>
			</div>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />