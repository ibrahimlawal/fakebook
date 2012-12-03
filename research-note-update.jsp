<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
		return;
	}
Object userid			=session.getAttribute("userid"); 
String id				=request.getParameter("id"); 
String title			=request.getParameter("title"); 
String note				=request.getParameter("note"); 
String save				=request.getParameter("save"); 

//check if note with id is owner by user
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
Statement st2= con2.createStatement(); 
ResultSet rs2 = st2.executeQuery("select title,body from note where id='"+id+"' and user_id='"+userid+"'"); 
if(rs2.next()) 
{ 
	if(title == null){
		title=rs2.getString(1);
	}
	if(note == null){
		note=rs2.getString(2);
	}
} else {
	response.sendRedirect("home.jsp");
}

boolean saved=false;
boolean submit=false;
if( !(save==null) ){
submit=true;
if( (!title.equals("")) && (!note.equals("")) ){
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
	Statement st= con.createStatement(); 
	st.execute("update note set title='"+title.trim()+"', body='"+note.trim()+"' where id='"+id+"'"); 
	// out.println("update note set title='"+title.trim()+"', body='"+note.trim()+"' where id='"+id+"'"); 
	saved=true; 
}
}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
<% if(saved) { %>
Note saved successfully.
<% } else { %>
			<form id="research-note-form" action="" method="post">
			<div class="profile">
<% if(submit) { %>
<center><font color="red">Make sure you have provided a valid title and note!</font></center>
<% } %>
			<h1>Write Research Note</h1>
				<div class="field">
					<label for="title">Title:</label>					<!--The firstname label -->
					<input type="text" id="title" name="title" value="<% out.print(title); %>"/>		<!--The firstname input box -->
				</div>
				<div class="field">
					<label for="note">Note:</label>						<!--The lastname label -->
					<textarea id="note" name="note" ><% out.print(note); %></textarea>		<!--The lastname input box -->
				</div>
				<input type="submit" value="Save Changes" name="save"/>
			</div>
			</form>
<% } %>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />