<form action="register.jsp" method="post" >
<fieldset>
	<legend>User Details</legend>
	<div class="field">
	<label for="firstname">First name:</label>					<!--The firstname label -->
	<input type="text" id="firstname" name="firstname" 
		 value="<% if(request.getParameter("firstname")!=null){out.println(request.getParameter("firstname"));} %>" />	<!--The firstname input box. Remember -->
	</div>
	<div class="field">
	<label for="lastname">Last name:</label>					<!--The lastname label -->
	<input type="text" id="lastname" name="lastname"  
		 value="<% if(request.getParameter("lastname")!=null){out.println(request.getParameter("lastname"));} %>" />	<!--The lastname input box. Remember entry -->
	</div>
	<div class="field">
	<label for="email">Email:</label>							<!--The email label -->
	<input type="text" id="email" name="email"  
		 value="<% if(request.getParameter("email")!=null){out.println(request.getParameter("email"));} %>" />			<!--The email input box . Remember entry-->
	</div>
	<div class="field">
	<label for="password">Password:</label>						<!--The password label -->
	<input type="password" id="password" name="password" />		<!--The password input box -->
	</div>
	<div class="field">
	<label for="rpassword">Repeat password:</label>				<!--The repeat password label -->
	<input type="password" id="rpassword" name="rpassword" />	<!--The repeat password input box -->
	</div>
</fieldset>
<fieldset>
	<legend>Security</legend>
	<div class="field">
	<label for="security_question">Security question:</label>			<!--The security question label -->
	<input type="text" id="security_question" name="security_question"  
		 value="<% if(request.getParameter("security_question")!=null){out.println(request.getParameter("security_question"));} %>" />	<!--The security question input box. Remember entry -->
	</div>
	<div class="field">
	<label for="security_answer">Answer:</label>						<!--The security answer label -->
	<input type="text" id="security_answer" name="security_answer"  
		 value="<% if(request.getParameter("security_answer")!=null){out.println(request.getParameter("security_answer"));} %>" />		<!--The security answer input box. Remember entry -->
	</div>
</fieldset>
	<input type="submit" value="register" name="register" />			<!--The register button -->
</form>

