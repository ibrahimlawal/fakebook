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
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
<%-- CREATE A PAGE-LEVEL SQL QUERY THAT MARKS THE REQUESTED MESSAGE AS READ --%>		
<sql:update var="rs2" dataSource="jdbc/fakebook">
UPDATE message SET status='Read' WHERE id=<% out.print( request.getParameter("id")); %>
</sql:update>
<%-- CREATE A PAGE-LEVEL SQL QUERY THAT FETCHES THE MESSAGE DETAILS --%>
<sql:query var="rs" dataSource="jdbc/fakebook">
SELECT message.id, message.sender_id,CONCAT( profile.firstname,  ' ', profile.lastname ) AS sender, 
	message.message, message.status, DATE_FORMAT( message.timestamp,  '%h:%i%p %b %D, %Y' ) AS timestamp
FROM message
	INNER JOIN profile ON message.sender_id = profile.id
WHERE (message.recipient_id =<% out.print( session.getAttribute("userid") ); %>
	OR message.sender_id =<% out.print( session.getAttribute("userid") ); %>)
	AND message.id=<% out.print( request.getParameter("id")); %>
</sql:query>


<c:forEach var="row" items="${rs.rows}">
			<div class="message">
				<h2 class="sender">
					${row.sender}										<!--print sender name-->
				</h2>
				<h3 class="sent">
					${row.timestamp}									<!--print message time -->
				</h3>
				<div class="clear"></div>
				<pre class="body">${row.message}</pre>					<!--print message body-->
<!--DONT SHOW THE REPLY BUTTON IF THE USER IS READING A MESSAGE HE/ SHE SENT-->
<c:if test="${row.sender_id!=userid}">									<!--test if the current user sent this message-->
				<div class="manage">
					<a href="new-message.jsp?recipient${row.sender_id}=on">reply</a>
				</div>
</c:if>
			</div>
</c:forEach>	
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />
