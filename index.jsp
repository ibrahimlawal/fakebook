<% if (session.getAttribute("userid") != null) {
			response.sendRedirect("home.jsp");
		return;
	}
%>
<jsp:include page="includes/header.jsp" />
	<div id="register-area">											<!--The register area -->
		<div class="container">
		
<jsp:include page="includes/register.jsp" />		
		<div id="lets-share">
			<img src="images/letsshare.jpg" />				<!--The site banner-->
		</div>
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />