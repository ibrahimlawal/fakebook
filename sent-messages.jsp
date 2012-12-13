<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {		//test if the userid is set in the session
			response.sendRedirect("index.jsp");			//redirect the user to index.jsp
		return;											//stop executing commands
	}
%>
<jsp:include page="includes/header.jsp" />								<!--Include page-->
	<div id="main-container">											<!--The main area-->
		<div class="container">
		
<jsp:include page="includes/links.jsp" />								<!--Include page-->	
		<div id="content">
			<h1 class="fltlft">Sent Messages</h1>
			<form id="send-message" action="send-message.jsp" method="get">
				<input type="submit" value="Send message" />
			</form>
<%-- CREATE A PAGE-LEVEL SQL QUERY TO FETCH SENT MESSAGES --%>
<sql:query var="rs" dataSource="jdbc/fakebook">
SELECT message.id, CONCAT( profile.firstname,  ' ', profile.lastname ) AS recipient, 
	message.message, message.status, DATE_FORMAT( message.timestamp,  '%h:%i%p %b %D, %Y' ) AS timestamp
FROM message
	INNER JOIN profile ON message.recipient_id = profile.id
WHERE message.sender_id =<% out.println( session.getAttribute("userid") ); %>
ORDER BY message.timestamp DESC
</sql:query>

<!--PRINT ALL MESSAGES TO THE SCREEN-->
<c:forEach var="row" items="${rs.rows}">
			<div class="message">
				<a href="message.jsp?id=${row.id}">
				<span class="sender">
					${row.recipient}						<!--print recipients name-->
				</span>
				<span class="sent">
					${row.timestamp}						<!--print time-->
				</span>
				</a>
				<div class="clear"></div>
			</div>
			<style>#no-messages{display:none;}</style>		
</c:forEach>	
		<div id="no-messages">
		<div class="clear"></div>
		<p>You have not sent any messages</p>
		</div>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />								<!--Include page-->
