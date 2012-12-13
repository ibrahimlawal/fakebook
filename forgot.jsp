<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% 
// send the user to the home page if logged in.
if (session.getAttribute("userid") != null) {	//test if the userid is set in the session
			response.sendRedirect("home.jsp");	//redirect the user to home.jsp
		return;									//stop executing commands
	}
String email			= request.getParameter("email"); 				//pick email address from the request
String security_answer	= request.getParameter("security_answer"); 		//pick security answer from the request
String security_question= request.getParameter("security_question"); 	//pick security question from the request
String request_password	= request.getParameter("request_password"); 	//pick request password from the request
String show_password	= request.getParameter("show_password"); 		//pick show password from the request
String password			= ""; 											//Initialise the string variable to store the password when fetched from the database

boolean request_password_try=false;										//initialise a boolean variable to know if the user tried to request his/her password, set as false
boolean show_password_try=false;										//initialise a boolean variable to know if the user has answered the security question, set as false

if(request_password != null){											// test if request password was clicked
	request_password_try=true;											// set the password request variable as true
	if( !email.equals("") ){ 											// test if the user entered an email
		Class.forName("com.mysql.jdbc.Driver"); 						//import the jdbc mysql driver
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 	//connect to the database
		Statement st= con.createStatement(); 							//create a database statement object	
		ResultSet rs=st.executeQuery("select security_question from profile where email='"+email+"'"); //fetch the user's security question
		if(rs.next()) { 												//test if a question was obtained for the email provided
			security_question = rs.getString(1); 						//set the security question
		} else {
			email=""; 													//clear the email since it was not found
		}
	}
}

if(show_password != null){ 												//test if the show password button was clicked
	show_password_try=true; 											// set the variable as true
	if( (!email.equals("")) && (!security_answer.equals("")) ){  		// confirm that both email and security answer have been provided
		Class.forName("com.mysql.jdbc.Driver"); 						//import the jdbc mysql driver
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 	//connect to the database
		Statement st= con.createStatement(); 							//create a database statement object
		ResultSet rs=st.executeQuery("select password from profile where email='"+email.trim()+"' and security_answer='"+security_answer.trim()+"'");  // fetch the password
		if(rs.next()) { 												// test if a password was obtained
			password = rs.getString(1); 								// set the password variable
		}  
	}	
}

%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">																													<!--The main area-->
		<div class="container" id="forgot">
<center>
<!--  SHOW PASSWORD IF SET-->
<% if(!password.equals("")) { %>
<div>
	<p id="transi-password">
		<br />Your password is: <br /><b><% out.println(password); %></b><br />
		<small>(this message will be removed in 3 seconds)</small>
	</p>
	
	<p>Click <a href="login.jsp">here</a> to login.</p>
</div>
<% } else { 
		if(email!=null && !email.equals("")) { 
			//show error message if a the answer supplied did not match our records
			if(show_password_try){
				out.println("<p><font color='red'>Your answer did not match our records!</font></p>");
			} %>
		<form action="forgot.jsp" method="post" >
			<h3>Provide the answer this question to see your password:</h3>
			<div class="field">
				<input type="hidden" id="email" name="email" 
					value="<% if(request.getParameter("email")!=null){out.println(request.getParameter("email"));} %>" />						<!--The security answer input box -->
				<input type="hidden" id="security_question" name="security_question"  
					value="<% out.println(security_question); %>" />																			<!--The security answer input box -->
				<label for="security_answer"><% out.println(security_question); %>:</label>														<!--The security answer label -->
				<input type="text" id="security_answer" name="security_answer"  
					 value="<% if(request.getParameter("security_answer")!=null){out.println(request.getParameter("security_answer"));} %>" />	<!--The security answer input box -->
			</div>
			<input type="submit" value="show password" name="show_password" />	
		</form>
<% 		} else {  
			// show the error message if the email did not fetch us a security question
			if(request_password_try){
				out.println("<p><font color='red'>No such email exists in our records!</font></p>");
			}  %>
		Please provide your email so we can fetch your password.
		<form action="forgot.jsp" method="post" >
			<div class="field">
			<label for="email">Email:</label>																			<!--The email label -->
			<input type="text" id="email" name="email"  
				 value="<% if(request.getParameter("email")!=null){out.println(request.getParameter("email"));} %>" />	<!--The email input box -->
			</div>
			<input type="submit" value="request password" name="request_password" />									<!--The register button -->
		</form>
<% 		}
   } %>
</fieldset>
<style>
/* Addtional styling for this page only */
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
<script>
function hidepwd(){ 																// a function to hide the password
    if(document.getElementById) 													// test that the browser has the document.getelementbyid function
    {
        if(document.getElementById('transi-password')) 								//get the div containing the password
        {
            document.getElementById('transi-password').style.visibility='hidden'; 	//hide the div containing the password
        }
    }
}
setTimeout(hidepwd, 5000); 															//set the hidepwd function to run 5 seconds after page load.
</script>
</script>
</center>
<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />