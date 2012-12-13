<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {					//test if the userid is set in the session
			response.sendRedirect("index.jsp");						//redirect the user to index.jsp
		return;														//stop executing commands
	}
Object userid			=session.getAttribute("userid"); 			//pick userid from the session
String address			=request.getParameter("address"); 			//pick address from the request
String firstname		=request.getParameter("firstname"); 		//pick firstname from the request
String phone			=request.getParameter("phone"); 			//pick phone number from the request
String lastname			=request.getParameter("lastname"); 			//pick lastname from the request

String subject_other	=request.getParameter("subject_other");  	//pick subject entered by user from request
String save				=request.getParameter("save");			 	//pick value of save from request
String research_interest_other	=request.getParameter("research_interest_other");	//pick research interest entered by user from request 
String[] subjects		=request.getParameterValues("subjects"); 	//pick subjects selected in the list box
String[] research_interests		=request.getParameterValues("research_interests"); //pick research interest selected from the box


Class.forName("com.mysql.jdbc.Driver"); 							//import the jdbc mysql driver
java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 	//connect to the database
Statement st2= con2.createStatement(); 								//create a database statement object
ResultSet rs2 = st2.executeQuery("select firstname,lastname,address,phone from profile where id='"+userid+"'"); 		//fetch profile details for user	
if(rs2.next())  													//test if a profile was loaded
{ 
	if(firstname == null){          								//test if firstname (originally loaded from the request) is null
		firstname=rs2.getString(1); 								//set the firstname to its database value
	}
	if(lastname == null){	       								    //test if lastname (originally loaded from the request) is null
		lastname=rs2.getString(2);									//set the lastname to its database value
	}
	if(address == null){											//test if address (originally loaded from the request) is null
		address=rs2.getString(3);									//set the address to its database value
	}
	if(phone == null){												//test if phone(number) (originally loaded from the request) is null
		phone=rs2.getString(4);										//set the phone(number) to its database value
	}
} else {
	response.sendRedirect("home.jsp");  							//redirect to homepage if no profile was loaded
}

java.sql.Connection con3 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd");  //create a new db connection
Statement st3= con3.createStatement(); 								// create a new db statement
ResultSet rs3 = st3.executeQuery("select s.id,s.name from user_subject u inner join subject s on s.id=u.subject_id where u.user_id='"+userid+"'");  //load subjects for current user 
ArrayList<String> subjects_orig = new ArrayList<String>();  		//create a new string list to store subjects
while(rs3.next()) 													//iterate through the subjects loaded
{
	subjects_orig.add(rs3.getString(1)); 							//add each subject to the list
} 

boolean saved=false;  												//initialise a boolean variable to know if save was successful, set as false
boolean submit=false;												//initialise a boolean variable to know if page was submitted, set as false
if( !(save==null) ){ 												//test if the save button was clicked
submit=true; //set the submit boolean variable to true
if( (!lastname.equals("")) && (!phone.equals("")) && (!firstname.equals("")) && (!address.equals("")) ){ //test if all required fields have a value
	Class.forName("com.mysql.jdbc.Driver"); //import the mysql jdbc driver
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd");  //create a new connection
	Statement st= con.createStatement();  							//create a new satement
	st.execute("update profile set address='"+address.trim()+"', phone='"+phone.trim()+"', firstname='"+firstname.trim()+"', lastname='"+lastname.trim()+"'where id='"+userid+"'"); //save the profile changes to db
	
	st.execute("delete from user_subject where user_id='"+userid+"'"); //remove all existing subject mappings for this user
	st.execute("delete from user_research_interest where user_id='"+userid+"'"); //remove all existing research interest mappings for this user
	if(!(subjects==null))	{ 										 // test if no subjects were selected
		for(int n=0; n<subjects.length; n++) 						 //iterate through selected subjects
		{
			st.execute("insert into user_subject (user_id,subject_id) values('"+userid+"','"+subjects[n]+"')");  //add a new subject mapping
		}
	}
	if(!(research_interests==null))	{ 								// test if no research interests were selected
		for(int n=0; n<research_interests.length; n++)  			//iterate through selected interests
		{
			st.execute("insert into user_research_interest (user_id,research_interest_id) values('"+userid+"','"+research_interests[n]+"')"); // add a new interests mapping 
		}
	}
	
	if(!(research_interest_other==null)){  							// test if an optional, new research interest was provided
		if(!(research_interest_other.equals(""))){ 					//test if it is empty
			st.execute("insert into research_interest (name) values('"+research_interest_other+"')"); //create a new interest
			ResultSet rs=st.executeQuery("select id from research_interest where name='"+research_interest_other+"'"); //fecth the id for the newly created interest
			if(rs.next()) 											//test if the id fetch was successful
			{ 
				st.execute("insert into user_research_interest (user_id,research_interest_id) values('"+userid+"','"+rs.getString(1)+"')");  //add a new mapping to the interest
			} 
		}
	}

	if(!(subject_other==null)){ 									// test if an optional, new subject was provided
		if(!(subject_other.equals(""))){ 							//test if it is empty
			st.execute("insert into subject (name) values('"+subject_other+"')");  // create a new subject
			ResultSet rs4=st.executeQuery("select id from subject where name='"+subject_other+"'"); //fetch the subject id
			if(rs4.next()) //test if a subject id was returned via fetch
			{ 
				st.execute("insert into user_subject (user_id,subject_id) values('"+userid+"','"+rs4.getString(1)+"')"); //add a new mapping
			} 
		}
	}

	saved=true; 													// set the save boolean variable to true
}
}
%>
<%-- 

Use an in-page sql query to fetch subjects from database 

--%>
<sql:query var="rs2" dataSource="jdbc/fakebook">
SELECT s.id, s.name, u.user_id
	FROM (
		SELECT user_id, subject_id
			FROM user_subject
		WHERE user_subject.user_id =<% out.println( session.getAttribute("userid") ); %>
	)u
	RIGHT OUTER JOIN subject s ON s.id = u.subject_id
ORDER BY user_id DESC
</sql:query>
<%-- 

Use an in-page sql query to fetch interests from database 

--%>
<sql:query var="rs3" dataSource="jdbc/fakebook">
SELECT r.id, r.name, u.user_id AS uid
	FROM (
		SELECT user_id, research_interest_id
			FROM user_research_interest
		WHERE user_research_interest.user_id =<% out.println( session.getAttribute("userid") ); %>
	)u
	RIGHT OUTER JOIN research_interest r ON r.id = u.research_interest_id
ORDER BY uid DESC
</sql:query>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
<% if(saved) { %>
Profile saved successfully.
<% } else { %>
			<form id="edit-profile-form" action="edit-profile.jsp" method="post">
			<div class="profile">
<% if(submit) { %>
<center><font color="red">Make sure you have provided a valid title and note!</font></center>
<% } %>
			<div class="name">
				<div class="field">
				<label for="firstname">First name:</label>														<!--The firstname label -->
				<input type="text" id="firstname" name="firstname" value="<% out.print(firstname); %>" />		<!--The firstname input box -->
				</div>
				<div class="field">
				<label for="lastname">Last name:</label>					<!--The lastname label -->
				<input type="text" id="lastname" name="lastname" value="<% out.print(lastname); %>" />			<!--The lastname input box -->
				</div>
			</div>
				<input name="save" type="submit" value="Save changes" />
			<div class="clear"></div>
			<fieldset class="contact-details">
				<legend>Contact Details</legend>
				<div class="field">
				<label for="address">Address:</label>					<!--The firstname label -->
				<input type="text" id="address" name="address" value="<% out.print(address); %>" />		<!--The firstname input box -->
				</div>
				<div class="field">
				<label for="phone">Phone:</label>					<!--The lastname label -->
				<input type="text" id="phone" name="phone" value="<% out.print(phone); %>" />			<!--The lastname input box -->
				</div>
			</fieldset>
			<fieldset class="subjects">
				<legend>Subjects</legend>
				<p>
					<i>Hold down ctrl (or CMD on a Mac) to select multiple subjects.</i>
				</p>
				<select multiple="multiple" name="subjects" id="subjects">
<!--  print all subjects marking the ones selected already by this user as 'selected' -->
<c:forEach var="row2" items="${rs2.rows}">
					<option value="${row2.id}" <c:if test="${!(row2.user_id==null)}">selected='selected'</c:if> >${row2.name}</option>
</c:forEach>	
				</select>
				<div>Other Subject <i>(optional)</i>: <input name="subject_other" type="text" value="<% if(!(subject_other==null)){out.print(subject_other);} %>" /></div>
			</fieldset>
			<fieldset class="research-interests">
				<legend>Research Interests</legend>
				<p>
					<i>Hold down ctrl (or CMD on a Mac) to select multiple reserach interests.</i>
				</p>
				<select multiple="multiple" name="research_interests" id="research_interests">
<!--  print all interests marking the ones selected already by this user as 'selected' -->
<c:forEach var="row3" items="${rs3.rows}">
					<option value="${row3.id}" <c:if test="${!(row3.user_id==null)}">selected='selected'</c:if> >${row3.name}</option>
</c:forEach>	
				</select>
				<div>Other Research Interest <i>(optional)</i>: <input name="research_interest_other" type="text" value="<% if(!(research_interest_other==null)){out.print(research_interest_other);} %>" /></div>

			</fieldset>
			</div>
				<input name="save" type="submit" value="Save changes" />
			</form>
<% } %>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />