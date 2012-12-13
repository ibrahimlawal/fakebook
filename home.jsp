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
			<h1>My Notes</h1>
<%-- CREATE A PAGE-LEVEL SQL QUERY TO FETCH ALL NOTES OF THE CURRENT USER --%>
<sql:query var="rs" dataSource="jdbc/fakebook">
select id,title,body,DATE_FORMAT(timestamp,'%h:%i%p %b %D, %Y') as timestamp from note where user_id=<% out.println( session.getAttribute("userid") ); %>
</sql:query>

<%-- print the user's notes --%>
<c:forEach var="row" items="${rs.rows}">
			<div class="research-note">
				<h2 class="description">
					${row.title}
				</h2>
				<h3 class="time-updated">
					${row.timestamp}
				</h3>
				<div class="clear"></div>
				<p class="note">
					${row.body}
				</p>
				<div class="manage">
					Manage: <a href="research-note-update.jsp?id=${row.id}">edit</a>&nbsp;|&nbsp;
					<a href="research-note-delete.jsp?id=${row.id}" onclick="return confirm('Are you sure you want to delete \'${row.title}\'?')">delete</a>
				</div>
			</div>
			<style>#no-notes{display:none;}</style>
</c:forEach>	
		<div id="no-notes">You have not saved any notes. Add a new one by clicking <a href="research-note-add.jsp">here</a>.</div>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />
