			<form action="login.jsp" method="post" >
				<label for="email">Email:</label>				<!--The email label -->
				<input type="text" placeholder="email" id="email" name="email" value="<% if(request.getParameter("email")!=null){out.println(request.getParameter("email"));} %>" />				<!--The email input box -->
				<label for="pwd">Password:</label>				<!--The Password label -->
				<input type="password" placeholder="password" id="pwd" name="pwd" />				<!--The Password input box -->
				<input type="submit" value="login" name="login" /><br/>	
				<div id="forgot"><a href="forgot.jsp">forgot password</a></div>		<!--The forgot Password link -->
			</form>
