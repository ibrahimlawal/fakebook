<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%--CREATE A PAGE LEVEL QUERY TO FETCH THE NUNBER OF UNREAD MESSAGES--%>
<sql:query var="rs" dataSource="jdbc/fakebook">
SELECT count(*) as ct FROM message
	WHERE recipient_id =<% out.print( session.getAttribute("userid") ); %> AND status='Unread'
</sql:query>
<div id="links">
<ul>
<li><a href="home.jsp">Home</a></li>																		 <!--Home Link--> 
<li><a href="messages.jsp">Messages (<c:forEach var="row" items="${rs.rows}">${row.ct}</c:forEach>)</a></li> <!--Messages Link(Unread messages counter)--> 
<li><small><a href="sent-messages.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Sent Messages</a></small></li>				 <!--SentMessages sublink-->	
<li><a href="my-profile.jsp">Profile</a></li>																 <!--Profile Link-->
<li><a href="research-note-add.jsp">Write Research Note</a></li>											 <!--Write Research Note Link-->
<li><a href="friends.jsp">Friends</a></li>																	 <!--Friends Link-->
<li><a href="search-results.jsp">Search</a></li>															 <!--Search Link-->
</ul>
</div>
