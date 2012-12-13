<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {		//test if the userid is set in the session
			response.sendRedirect("index.jsp");			//redirect the user to home.jsp
		return;											//stop executing commands
	}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
<%-- CREATE A PAGE LEVEL QUERY THAT GETS THE PROFILE OF THE CURRENT USER --%>		
<sql:query var="rs" dataSource="jdbc/fakebook">
select * from profile where id=<% out.println( session.getAttribute("userid") ); %>
</sql:query>
<%-- CREATE A PAGE LEVEL QUERY THAT GETS THE LIST OF SUBJECTS OF THE CURRENT USER --%>
<sql:query var="rs2" dataSource="jdbc/fakebook">
select s.name 
from user_subject u 
	inner join subject s
	on s.id=u.subject_id
where u.user_id=<% out.println( session.getAttribute("userid") ); %>
</sql:query>
<%-- CREATE A PAGE LEVEL QUERY THAT GETS THE LIST OF RESEARCH INTEREST OF THE CURRENT USER --%>
<sql:query var="rs3" dataSource="jdbc/fakebook">
select r.name 
from user_research_interest u 
	inner join research_interest r 
	on r.id=u.research_interest_id
where u.user_id=<% out.println( session.getAttribute("userid") ); %>
</sql:query>


		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
			<div class="profile">
<!--PRINT THE USER'S PROFILE-->
<c:forEach var="row" items="${rs.rows}">
			<h1 class="name">${row.firstname} ${row.lastname}</h1>				<!--print user's firstname, lastname-->
			<form id="edit-profile" action="edit-profile.jsp" method="get">
				<input type="submit" value="Edit profile" />
			</form>
			<div class="clear"></div>
			<fieldset class="contact-details">
				<legend>Contact Details</legend>								<!--print user's contact details-->
				<p>
					Address: ${row.address} <br/>								<!--print user's  address-->
					Phone: ${row.phone} <br />									<!--print user's phone number-->
				</p>
			</fieldset>
</c:forEach>	
			<fieldset class="subjects">
				<legend>Subjects</legend>
				<ul>
<c:forEach var="row2" items="${rs2.rows}">										<!--for each row2 in rs2 (which contains all subjects)-->
					<li>${row2.name}</li>								<!--print name of Subject-->
</c:forEach>	
				</ul>
			</fieldset>
			<fieldset class="research-interests">
				<legend>Research Interests</legend>
				<ul>
<c:forEach var="row3" items="${rs3.rows}">										<!--for each row3 in rs3 (which contains all research interests)-->
					<li>${row3.name}</li>								<!--print name of research interest-->
</c:forEach>	
				</ul>
			</fieldset>
			</div>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />