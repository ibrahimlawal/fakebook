<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") != null) {
			response.sendRedirect("home.jsp");
		return;
	}
String email			= request.getParameter("email"); 
String security_answer	= request.getParameter("security_answer"); 
String security_question= request.getParameter("security_question"); 
String request_password	= request.getParameter("request_password"); 
String show_password	= request.getParameter("show_password"); 
String password			= ""; 

boolean request_password_try=false;
boolean show_password_try=false;

if(request_password != null){
	request_password_try=true;
	if( !email.equals("") ){ 
		Class.forName("com.mysql.jdbc.Driver"); 
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
		Statement st= con.createStatement(); 
		ResultSet rs=st.executeQuery("select security_question from profile where email='"+email+"'"); 
		if(rs.next()) { 
			security_question = rs.getString(1);
		} else {
			email="";
		}
	}
}

if(show_password != null){
	show_password_try=true;
	if( (!email.equals("")) && (!security_answer.equals("")) ){  
		Class.forName("com.mysql.jdbc.Driver"); 
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
		Statement st= con.createStatement(); 
		ResultSet rs=st.executeQuery("select password from profile where email='"+email.trim()+"' and security_answer='"+security_answer.trim()+"'"); 
		//out.println("select password from profile where email='"+email+"' and security_answer='"+security_answer+"'"); 
		if(rs.next()) { 
			password = rs.getString(1);
		}  
	}	
}

%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container" id="forgot">
<center>
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
			if(show_password_try){
				out.println("<p><font color='red'>Your answer did not match our records!</font></p>");
			} %>
		<form action="forgot.jsp" method="post" >
			<h3>Provide the answer this question to see your password:</h3>
			<div class="field">
				<input type="hidden" id="email" name="email" 
					value="<% if(request.getParameter("email")!=null){out.println(request.getParameter("email"));} %>" />			<!--The security answer input box -->
				<input type="hidden" id="security_question" name="security_question"  
					value="<% out.println(security_question); %>" />			<!--The security answer input box -->
				<label for="security_answer"><% out.println(security_question); %>:</label>								<!--The security answer label -->
				<input type="text" id="security_answer" name="security_answer"  
					 value="<% if(request.getParameter("security_answer")!=null){out.println(request.getParameter("security_answer"));} %>" />			<!--The security answer input box -->
			</div>
			<input type="submit" value="show password" name="show_password" />	
		</form>
<% 		} else {  
			if(request_password_try){
				out.println("<p><font color='red'>No such email exists in our records!</font></p>");
			}  %>
		Please provide your email so we can fetch your password.
		<form action="forgot.jsp" method="post" >
			<div class="field">
			<label for="email">Email:</label>					<!--The email label -->
			<input type="text" id="email" name="email"  
				 value="<% if(request.getParameter("email")!=null){out.println(request.getParameter("email"));} %>" />			<!--The email input box -->
			</div>
			<input type="submit" value="request password" name="request_password" />			<!--The register button -->
		</form>
<% 		}
   } %>
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
<script>
function hidepwd(){
    if(document.getElementById)
    {
        if(document.getElementById('transi-password'))
        {
            document.getElementById('transi-password').style.visibility='hidden';
        }
    }
}
setTimeout(hidepwd, 5000);
</script>
</script>
</center>
<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />