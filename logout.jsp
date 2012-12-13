<% if (session.getAttribute("userid") == null) {		//test if the userid is set in the session
		response.sendRedirect("index.jsp");				//redirect the user to index.jsp
		return;											//stop executing commands
	}
	session.putValue("userid",null); 					//Clear the user id in the current session
	response.sendRedirect("index.jsp");					//redirect the user to index.jsp

%>
