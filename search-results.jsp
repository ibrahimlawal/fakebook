<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {		//test if the userid is set in the session
			response.sendRedirect("index.jsp");			//redirect the user to index.jsp
		return;											//stop executing commands
	}
String criteria		=request.getParameter("criteria"); 
%>
<jsp:include page="includes/header.jsp" />
	    <div id="main-container">											<!--The main area-->
		<div class="container">
<%-- CREATE A PAGE-LEVEL QUERY TO SELECT POSSIBLE FRIENDS BASED ON THE CRITERIA CHOSEN BY THE USER --%>
<sql:query var="rs" dataSource="jdbc/fakebook">
<% 
if (criteria != null && criteria.equals("research_interest")){ 			//test if the user selected reseach interest as search criteria %>
SELECT id, CONCAT( profile.firstname,  ' ', profile.lastname ) as name
FROM profile
WHERE id NOT 
IN (
SELECT <% out.println( session.getAttribute("userid") ); %>
UNION
SELECT friend_id
FROM friend
WHERE user_id =<% out.println( session.getAttribute("userid") ); %>
)


and id in (

SELECT DISTINCT user_id
FROM user_research_interest
WHERE research_interest_id
IN (

SELECT research_interest_id
FROM user_research_interest
WHERE user_id =<% out.println( session.getAttribute("userid") ); %>
)
)
<% } else if (criteria != null && criteria.equals("subject")){ 		// test if the user chose subject as their search criteria %>
SELECT id, CONCAT( profile.firstname,  ' ', profile.lastname ) as name
FROM profile
WHERE id NOT 
IN (
SELECT <% out.println( session.getAttribute("userid") ); %>
UNION

SELECT friend_id
FROM friend
WHERE user_id =<% out.println( session.getAttribute("userid") ); %>
)


and id in (

SELECT DISTINCT user_id
FROM user_subject
WHERE subject_id
IN (

SELECT subject_id
FROM user_subject
WHERE user_id =<% out.println( session.getAttribute("userid") ); %>
)
)
<% 		} else { 

// if we got here, the user either didnt select a criteria or selected both, set the criteria as "both" to be sure
criteria="both";
%>
SELECT id, CONCAT( profile.firstname,  ' ', profile.lastname ) as name
FROM profile
WHERE id NOT 
IN (
SELECT <% out.println( session.getAttribute("userid") ); %>
UNION

SELECT friend_id
FROM friend
WHERE user_id =<% out.println( session.getAttribute("userid") ); %>
)

and id in (
SELECT DISTINCT user_id
FROM user_subject
WHERE subject_id
IN (

SELECT subject_id
FROM user_subject
WHERE user_id =<% out.println( session.getAttribute("userid") ); %>
)
UNION
SELECT DISTINCT user_id
FROM user_research_interest
WHERE research_interest_id
IN (

SELECT research_interest_id
FROM user_research_interest
WHERE user_id =<% out.println( session.getAttribute("userid") ); %>
)
)
<% } %>

</sql:query>
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
			<div class="message">
			<div>
			<h1>Search</h1>
			<form action="search-results.jsp" method="get">
				<p>
					Select a criteria and click 'Search'.
				</p>
				<label for="search-both">
					<input id="search-both" type="radio" <% if (criteria.equals("both")){out.print("checked='checked'");} %> name="criteria" value="both" />
					Both Subjects and Research Interests
				</label>
				<label for="search-subject">
					<input id="search-subject" type="radio" <% if (criteria.equals("subject")){out.print("checked='checked'");} %> name="criteria" value="subject" />
					Subject
				</label>
				<label for="search-research-interest">
					<input id="search-research-interest" type="radio" <% if (criteria.equals("research_interest")){out.print("checked='checked'");} %> name="criteria" value="research_interest" />
					Resarch Interest
				</label>
				<div class="manage">
					<input name="search" type="submit" value="Search"/>
				</div>
			</form>
			</div>
			</div>
<%-- PRINT THE LIST OF POSSIBLE FRIENDS AS RETURNED BY THE QUERY ABOVE --%>
<c:forEach var="row" items="${rs.rows}">
			<div class="friend">
				<div class="name">
					${row.name}						<!-- print the friend name -->
				</div>
				<div class="manage">
					<a href="add-friend.jsp?id=${row.id}" onclick="return confirm('Are you sure you want to add \'${row.name}\' as a friend?')">add</a>
				</div>
				<div class="clear"></div>
			</div>
</c:forEach>	

		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />