<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% 

// send the user to the index page if not logged in.
if (session.getAttribute("userid") == null) {   //test if the userid is set in the session
	response.sendRedirect("index.jsp");			//redirect the user to index.jsp
	return;										//stop executing commands
}


Object userid			=session.getAttribute("userid"); 	//pick userid from the session
String id				=request.getParameter("id");		//pick friend id from request

Class.forName("com.mysql.jdbc.Driver"); 					//import the jdbc mysql driver
java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd");   //connect to the database
Statement st2= con2.createStatement(); 						//create a database statement object
st2.execute("delete from friend where user_id='"+userid+"' and friend_id='"+id+"'"); 	//clean out any existing friendship between this user and friend being added
st2.execute("insert into friend(user_id,friend_id) values ('"+userid+"','"+id+"')"); 	//add a fresh friendship between this user and the friend being added


%>
<jsp:include page="includes/header.jsp" />			<!--  include the site header -->
	<div id="main-container">						<!--The main area-->
		<div class="container">
			
<jsp:include page="includes/links.jsp" />			<!--  include the site links -->
			<div id="content">						<!--  content area -->
Friend added successfully.  						<!-- Display success message -->
			</div>	
			<div class="clear"></div>				<!-- clear all float -->
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />			<!--  include the site footer -->
