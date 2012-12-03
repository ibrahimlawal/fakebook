<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
		return;
	}
String  id				=request.getParameter("id"); 
%>
<sql:query var="rs" dataSource="jdbc/fakebook">
select * from profile where id=<% out.print(id); %>
</sql:query>
<sql:query var="rs2" dataSource="jdbc/fakebook">
select s.name 
from user_subject u 
	inner join subject s
	on s.id=u.subject_id
where u.user_id=<% out.print(id); %>
</sql:query>
<sql:query var="rs3" dataSource="jdbc/fakebook">
select r.name 
from user_research_interest u 
	inner join research_interest r 
	on r.id=u.research_interest_id
where u.user_id=<% out.print(id); %>
</sql:query>
<sql:query var="rs4" dataSource="jdbc/fakebook">
select id,title,body,DATE_FORMAT(timestamp,'%h:%i%p %b %D, %Y') as timestamp from note where user_id=<% out.print(id); %>
</sql:query>

<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
<c:forEach var="row" items="${rs.rows}">
			<div class="profile">
			<h1 class="name">${row.firstname} ${row.lastname}</h1>
			<div class="clear"></div>
			<fieldset class="contact-details">
				<legend>Contact Details</legend>
				<p>
					Address: ${row.address} <br/>
					Phone: ${row.phone} <br />
				</p>
			</fieldset>
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
<c:forEach var="row4" items="${rs4.rows}">
			<div class="research-note">
				<h2 class="description">
					${row4.title}
				</h2>
				<h3 class="time-updated">
					${row4.timestamp}
				</h3>
				<div class="clear"></div>
				<p class="note">
					${row4.body}
				</p>
				<div class="manage">
					<a href="new-message.jsp?recipient${row.id}=on">send message</a>
				</div>
			</div>
			<style>#no-notes{display:none;}</style>
</c:forEach>	
		<div id="no-notes">${row.firstname} ${row.lastname} has not saved any notes.</div>
</c:forEach>	
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />