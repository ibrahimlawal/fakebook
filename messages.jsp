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
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
			<h1 class="fltlft">Messages</h1>
			<form id="send-message" action="send-message.jsp" method="get">
				<input type="submit" value="Send message" />
			</form>
<%-- CREATE A PAGE LEVEL QUERY TO SELECT ALL MESSAGES SENT TO THE CURRENT USER--%>			
<sql:query var="rs" dataSource="jdbc/fakebook">
SELECT message.id, CONCAT( profile.firstname,  ' ', profile.lastname ) AS sender, 
	message.message, message.status, DATE_FORMAT( message.timestamp,  '%h:%i%p %b %D, %Y' ) AS timestamp
FROM message
	INNER JOIN profile ON message.sender_id = profile.id
WHERE message.recipient_id =<% out.println( session.getAttribute("userid") ); %>
ORDER BY message.timestamp DESC
</sql:query>

<!--PRINT ALL MESSAGES TO THE SCREEN-->
<c:forEach var="row" items="${rs.rows}">					
			<div class="message">
				<a href="message.jsp?id=${row.id}">
				<!--ONLY MAKE UNREAD MESSAGED BOLD (START TAG)-->
				<c:if test="${row.status == 'Unread'}">
				<b>
				</c:if>
				<span class="sender">
					${row.sender}								<!--print sender name-->
				</span>
				<span class="sent">
					${row.timestamp}							<!--print message time -->
				</span>
				<!--ONLY MAKE UNREAD MESSAGED BOLD (END TAG)-->
				<c:if test="${row.status == 'Unread'}">
				</b>
				</c:if>
				</a>
				<div class="clear"></div>
			</div>
			<style>#no-messages{display:none;}</style>		    <!--Hide " You do not have any messages" if a note is on the page-->
</c:forEach>	
		<div id="no-messages">
		<div class="clear"></div>
		<p>You do not have any messages</p>
		</div>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />
