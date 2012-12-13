<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") != null) {		//test if the userid is set in the session
			response.sendRedirect("home.jsp");			//redirect the user to home.jsp
		return;											//stop executing commands
	}
String email=request.getParameter("email"); 			//pick email address from the request
boolean password_failed=false;
if(email != null){
	String pwd=request.getParameter("pwd"); 			//pick password from the request	
	Class.forName("com.mysql.jdbc.Driver"); 			//import the jdbc mysql driver
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 	//connect to the database
	Statement st= con.createStatement(); 				//create a database statement object
	ResultSet rs=st.executeQuery("select id,password from profile where email='"+email+"'"); 	//fetch the password of the user
	if(rs.next()) 										//test if password was obtained for the email provided
	{ 
		if(rs.getString(2).equals(pwd)) 				//if the password is correct?
		{ 
			 
			session.putValue("userid",rs.getInt(1)); 	//save the user id in the current session
			response.sendRedirect("home.jsp");			//go to homepage
			return;										//stop executing commands
		} 
	} 
	password_failed=true; 								//password is wrong
}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container" id="login">
<center>
<% if(password_failed) { %>
Invalid username or password, please try again.
<% } %>
<fieldset>
<legend>Login</legend>
<jsp:include page="includes/login.jsp" />
				<div id="register"><a href="register.jsp">register</a></div>		</fieldset>
<style>
#top-bar #login-area{
	display: none;
}
#login fieldset{
	width:200px;
	text-align: right;
}
</style>
</center>
<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />