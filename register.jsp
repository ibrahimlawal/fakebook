<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") != null) {					//test if the userid is set in the session
			response.sendRedirect("home.jsp");						//redirect the user to home.jsp
		return;														//stop executing commands
	}
String email			=request.getParameter("email"); 			//pick email address from the request
String firstname		=request.getParameter("firstname"); 		//pick user firstname from the request
String lastname			=request.getParameter("lastname"); 			//pick user lastname from the request	
String password			=request.getParameter("password"); 			//pick user password from the request
String rpassword		=request.getParameter("rpassword"); 		//pick user password from the request
String security_question=request.getParameter("security_question");	//pick user security question from the request 
String security_answer	=request.getParameter("security_answer"); 	//pick user security answer from the request
String register			=request.getParameter("register"); 			//pick register from the request
boolean registered=false;											//create a bolean variable and set it to false
boolean submit=false;
if(register != null){												//Test if the register button was clicked
submit=true;
if( (!email.equals("")) && (!firstname.equals("")) && (!lastname.equals(""))  && (!password.equals(""))  && (rpassword.equals(password))  && (!security_answer.equals(""))  && (!security_question.equals("")) ){	//check if all parameters are provided
	Class.forName("com.mysql.jdbc.Driver"); 						//import the jdbc mysql driver
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 	//connect to the database
	Statement st= con.createStatement(); 							//create a database statement object
	ResultSet rs7=st.executeQuery("select id from profile where email='"+email+"'"); 										// fetch the user id
	if(rs7.next()) 													//test if the user id was obtained
	{ 
		registered=true; 											//user already registered
	} else {
		st.execute("insert into profile (firstname,lastname,email,password,security_question,security_answer) values ('"+firstname+"','"+lastname+"','"+email+"','"+password+"','"+security_question+"','"+security_answer+"')"); // add the new user to database 
		ResultSet rs=st.executeQuery("select id from profile where email='"+email+"'"); //fetch the user's id
		if(rs.next()) 													
		{ 
			session.putValue("userid",rs.getInt(1)); 				//save the user id in the current session
			response.sendRedirect("edit-profile.jsp");				//go to edit profile
			return;													//stop executing commands
		}	
	}
}
}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container" id="register">
<center>
<% if(registered) { %>
You are already registered as a user on fakebook. please <a href="login.jsp">login</a> to continue.
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