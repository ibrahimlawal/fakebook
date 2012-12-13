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
<%-- CREATE A PAGE-LEVEL SQL QUERY TO FETCH ALL FRIENDS OF THE CURRENT USER --%>
<sql:query var="rs" dataSource="jdbc/fakebook">
SELECT id,concat(firstname,' ',lastname) as name from profile inner join friend on friend.friend_id=profile.id where 
friend.user_id=<% out.print( session.getAttribute("userid") ); %>
</sql:query>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
<jsp:include page="includes/links.jsp" />	
		<div id="content">
			<h1 class="fltlft">Friends</h1>
			<form id="add-friend" action="search-results.jsp" method="get">
				<input type="submit" value="Add friend" />
				<input id="search-both" type="hidden" name="criteria" value="both" />
			</form>
			<div class="clear"></div>
<%-- print the list of friends --%>
<c:forEach var="row" items="${rs.rows}">
			<div class="friend">
				<div class="name">
					${row.name}
				</div>
				<div class="manage">
					<a href="profile.jsp?id=${row.id}">view profile</a>&nbsp;|&nbsp;
					<a href="new-message.jsp?recipient${row.id}=on">send message</a>
				</div>
				<div class="clear"></div>
			</div>
</c:forEach>	
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />