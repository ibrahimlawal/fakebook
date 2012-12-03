<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") != null) {
			response.sendRedirect("home.jsp");
		return;
	}
String email=request.getParameter("email"); 
boolean password_failed=false;
if(email != null){
	String pwd=request.getParameter("pwd"); 
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
	Statement st= con.createStatement(); 
	ResultSet rs=st.executeQuery("select id,password from profile where email='"+email+"'"); 
	if(rs.next()) 
	{ 
		if(rs.getString(2).equals(pwd)) 
		{ 
			// out.println("welcome "+email); 
			session.putValue("userid",rs.getInt(1)); 
			response.sendRedirect("home.jsp");
			return;
		} 
	} 
	password_failed=true; 
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
</fieldset>
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