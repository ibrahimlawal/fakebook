<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
		return;
	}
Object userid			=session.getAttribute("userid"); 
String id				=request.getParameter("id"); 
String title			=request.getParameter("title"); 
String note				=request.getParameter("note"); 
String save				=request.getParameter("save"); 

//check if note with id is owner by user
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
Statement st2= con2.createStatement(); 
st2.execute("delete from note where id='"+id+"' and user_id='"+userid+"'"); 


%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
Note deleted successfully.

		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />