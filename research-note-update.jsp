<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<% if (session.getAttribute("userid") == null) {			//test if the userid is set in the session
			response.sendRedirect("index.jsp");				//redirect the user to index.jsp
		return;												//stop executing commands
	}
Object userid			=session.getAttribute("userid"); 	//pick userid from the session
String id				=request.getParameter("id"); 		//pick id from the request
String title			=request.getParameter("title"); 	//pick title from the request
String note				=request.getParameter("note"); 		//pick note from the request
String save				=request.getParameter("save"); 		//pick save from the request	

//check if note with id is owner by user
Class.forName("com.mysql.jdbc.Driver"); 					//import the jdbc mysql driver
java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 	//connect to the database
Statement st2= con2.createStatement(); 						//create a database statement object
ResultSet rs2 = st2.executeQuery("select title,body from note where id='"+id+"' and user_id='"+userid+"'"); 	// fetch the title of the note
if(rs2.next()) 												//test if title has been optained
{ 
	if(title == null){										//test if title (originally loaded from the request) is null
		title=rs2.getString(1);								//set the title to its database value
	}
	if(note == null){										//test if note (originally loaded from the request) is null
		note=rs2.getString(2);								//set the note to its database value
	}
} else {
	response.sendRedirect("home.jsp");						//redirect the user to homepage
}

boolean saved=false;										//initialise a boolean variable to know if save was successful, set as false
boolean submit=false;										//initialise a boolean variable to know if page was submitted, set as false
if( !(save==null) ){										//test if the save button was clicked
submit=true;												//set the submit boolean variable to true
if( (!title.equals("")) && (!note.equals("")) ){			//if a title and a note was entered
	Class.forName("com.mysql.jdbc.Driver"); 				//import the jdbc mysql driver
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd");		//connect to the database 
	Statement st= con.createStatement();					//create a database statement object 
	st.execute("update note set title='"+title.trim()+"', body='"+note.trim()+"' where id='"+id+"'"); //update/ save changes made on note 
	
	saved=true; 											//confirm action
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
			<h1>Edit Research Note</h1>
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