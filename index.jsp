<% if (session.getAttribute("userid") != null) {		//test if the userid is set in the session
			response.sendRedirect("home.jsp");			//redirect the user to index.jsp
		return;											//stop executing commands
	}
%>
<jsp:include page="includes/header.jsp" />
	<div id="register-area">											<!--The register area -->
		<div class="container">
		
<jsp:include page="includes/register.jsp" />						
		<div id="lets-share">
			<img src="images/letsshare.jpg" />							<!--The site banner-->
		</div>
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />
