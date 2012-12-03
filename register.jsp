<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") != null) {
			response.sendRedirect("home.jsp");
		return;
	}
String email			=request.getParameter("email"); 
String firstname		=request.getParameter("firstname"); 
String lastname			=request.getParameter("lastname"); 
String password			=request.getParameter("password"); 
String rpassword		=request.getParameter("rpassword"); 
String security_question=request.getParameter("security_question"); 
String security_answer	=request.getParameter("security_answer"); 
String register			=request.getParameter("register"); 
boolean registered=false;
boolean submit=false;
if(register != null){
submit=true;
if( (!email.equals("")) && (!firstname.equals("")) && (!lastname.equals(""))  && (!password.equals(""))  && (rpassword.equals(password))  && (!security_answer.equals(""))  && (!security_question.equals("")) ){
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
	Statement st= con.createStatement(); 
	st.execute("insert into profile (firstname,lastname,email,password,security_question,security_answer) values ('"+firstname+"','"+lastname+"','"+email+"','"+password+"','"+security_question+"','"+security_answer+"')"); 
	// out.println("welcome "+email); 
	registered=true; 
}
}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container" id="register">
<center>
<% if(registered) { %>
You are now registered as a user on fakebook. please <a href="login.jsp">login</a> to continue.
<% } else { %>
<fieldset class="main">
<legend>Register</legend>
<center>All fields are required!</center>
<% if(submit) { %>
<center><font color="red">Make sure you have provided a valid email and that all fields are filled correctly!</font></center>
<% } %>
<jsp:include page="includes/register.jsp" />
</fieldset>
<style>
#top-bar #login-area{
	display: none;
}
#register fieldset.main{
	width:450px;
	text-align: right;
}
#register fieldset.main input[type="text"],#register fieldset.main input[type="password"]{
	width:200px;
	text-align: left;
}
</style>
<% } %>
</center>
<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />