<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") == null) {			//test if the userid is set in the session
			response.sendRedirect("index.jsp");				//redirect the user to index.jsp
		return;												//stop executing commands
	}
Object userid			=session.getAttribute("userid"); 	//pick userid from the session
String title			=request.getParameter("title"); 	//pick title from the request
String note				=request.getParameter("note"); 		//pick note from the request
String add				=request.getParameter("add"); 		//pick note from the request
boolean added=false;										//create a bolean variable and set it to false
boolean submit=false;
if(add != null){											//Test if the add button was clicked
submit=true;
if( (!title.equals("")) && (!note.equals("")) ){			//check if all parameters are provided
	Class.forName("com.mysql.jdbc.Driver"); 				//import the jdbc mysql driver
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 	//connect to the database
	Statement st= con.createStatement(); 					//create a database statement object
	st.execute("insert into note (user_id,title,body) values ('"+userid+"','"+title.trim()+"','"+note.trim()+"')"); //add new note to data base 
	 
	added=true;												//the note has been added 											
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