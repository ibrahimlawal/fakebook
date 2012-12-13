<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") == null) {			//test if the userid is set in the session
			response.sendRedirect("index.jsp");				//redirect the user to index.jsp
		return;												//stop executing commands
	}
Object userid			=session.getAttribute("userid"); 	//pick userid from the session
String id				=request.getParameter("id"); 		//pick id from the request
String title			=request.getParameter("title"); 	//pick title from the request
String note				=request.getParameter("note"); 		//pick note from the request
String save				=request.getParameter("save"); 		//pick save from the request

//check if note with id is owner by user
Class.forName("com.mysql.jdbc.Driver"); 					//import the jdbc mysql driver
java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); //connect to the database
Statement st2= con2.createStatement(); 						//create a database statement object
st2.execute("delete from note where id='"+id+"' and user_id='"+userid+"'"); //delete note when delete link is clicked


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