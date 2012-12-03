<% if (session.getAttribute("userid") == null) {
		response.sendRedirect("index.jsp");
		return;
	}
	session.putValue("userid",null); 
	response.sendRedirect("index.jsp");

%>
