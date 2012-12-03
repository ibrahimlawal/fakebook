<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:query var="rs" dataSource="jdbc/fakebook">
SELECT count(*) as ct FROM message
	WHERE recipient_id =<% out.print( session.getAttribute("userid") ); %>
</sql:query>
<div id="links">
<ul>
<li><a href="home.jsp">Home</a></li>
<li><a href="messages.jsp">Messages (<c:forEach var="row" items="${rs.rows}">${row.ct}</c:forEach>)</a></li>
<li><a href="my-profile.jsp">Profile</a></li>
<li><a href="research-note-add.jsp">Write Research Note</a></li>
<li><a href="friends.jsp">Friends</a></li>
<li><a href="search-results.jsp">Search</a></li>
</ul>
</div>