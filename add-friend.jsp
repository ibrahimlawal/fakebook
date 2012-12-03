<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
		return;
	}
Object userid			=session.getAttribute("userid"); 
String id				=request.getParameter("id"); 

Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
Statement st2= con2.createStatement(); 
st2.execute("delete from friend where user_id='"+userid+"' and friend_id='"+id+"'"); 
st2.execute("insert into friend(user_id,friend_id) values ('"+userid+"','"+id+"')"); 


%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
Friend added successfully.

		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />