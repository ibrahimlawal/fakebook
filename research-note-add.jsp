<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
		return;
	}
Object userid			=session.getAttribute("userid"); 
String title			=request.getParameter("title"); 
String note				=request.getParameter("note"); 
String add				=request.getParameter("add"); 
boolean added=false;
boolean submit=false;
if(add != null){
submit=true;
if( (!title.equals("")) && (!note.equals("")) ){
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
	Statement st= con.createStatement(); 
	st.execute("insert into note (user_id,title,body) values ('"+userid+"','"+title.trim()+"','"+note.trim()+"')"); 
	// out.println("welcome "+email); 
	added=true; 
}
}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
<% if(added) { %>
Note saved successfully.
<% } else { %>
			<form id="research-note-form" action="research-note-add.jsp" method="post">
			<div class="profile">
<% if(submit) { %>
<center><font color="red">Make sure you have provided a valid title and note!</font></center>
<% } %>
			<h1>Write Research Note</h1>
				<div class="field">
					<label for="title">Title:</label>					<!--The firstname label -->
					<input type="text" id="title" name="title" />		<!--The firstname input box -->
				</div>
				<div class="field">
					<label for="note">Note:</label>						<!--The lastname label -->
					<textarea id="note" name="note" ></textarea>		<!--The lastname input box -->
				</div>
				<input type="submit" value="Add" name="add"/>
			</div>
			</form>
<% } %>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />