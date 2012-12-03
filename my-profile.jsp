<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
		return;
	}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
<sql:query var="rs" dataSource="jdbc/fakebook">
select * from profile where id=<% out.println( session.getAttribute("userid") ); %>
</sql:query>
<sql:query var="rs2" dataSource="jdbc/fakebook">
select s.name 
from user_subject u 
	inner join subject s
	on s.id=u.subject_id
where u.user_id=<% out.println( session.getAttribute("userid") ); %>
</sql:query>
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
<c:forEach var="row" items="${rs.rows}">
			<h1 class="name">${row.firstname} ${row.lastname}</h1>
			<form id="edit-profile" action="edit-profile.jsp" method="get">
				<input type="submit" value="Edit profile" />
			</form>
			<div class="clear"></div>
			<fieldset class="contact-details">
				<legend>Contact Details</legend>
				<p>
					Address: ${row.address} <br/>
					Phone: ${row.phone} <br />
				</p>
			</fieldset>
</c:forEach>	
			<fieldset class="subjects">
				<legend>Subjects</legend>
				<ul>
<c:forEach var="row2" items="${rs2.rows}">
					<li>${row2.name}</li>
</c:forEach>	
				</ul>
			</fieldset>
			<fieldset class="research-interests">
				<legend>Research Interests</legend>
				<ul>
<c:forEach var="row3" items="${rs3.rows}">
					<li>${row3.name}</li>
</c:forEach>	
				</ul>
			</fieldset>
			</div>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />