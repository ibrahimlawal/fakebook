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
<%

List<String> friends = new ArrayList<String>();
for(Enumeration all_vars = request.getParameterNames(); all_vars.hasMoreElements() ;){
	String val = (String) all_vars.nextElement();
	if(val.startsWith("recipient")){
		friends.add(val.substring(9));
		//out.print(val.substring(9));
	}
}
%>
<sql:query var="rs" dataSource="jdbc/fakebook">
SELECT id,firstname, lastname from profile where id in
	(SELECT '0'
	<% 
	for(String friend : friends){	
		out.print( " UNION SELECT " + friend); 
	}
	%>)
</sql:query>

<jsp:include page="includes/links.jsp" />	
		<div id="content">
			<div class="message">
			<p>
				Type the message you want to send and click 'Send'.
			</p>
				<form action="send-message.jsp" method="post">
				<h2 class="sender">Recipients: 
<c:forEach var="row" items="${rs.rows}">
					<input type="hidden" value="on" name="recipient${row.id}">
					<span>${row.firstname} ${row.lastname}</span>
</c:forEach>	
				</h2>
				<div class="clear"></div>
				<textarea class="body" name="message"></textarea>
				<div class="manage">
					<input name="send" type="submit" value="Send"/>
				</div>
				</form>
			</div>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />