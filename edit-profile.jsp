<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
		return;
	}
Object userid			=session.getAttribute("userid"); 
String address			=request.getParameter("address"); 
String firstname		=request.getParameter("firstname"); 
String phone			=request.getParameter("phone"); 
String lastname			=request.getParameter("lastname"); 
String save				=request.getParameter("save"); 
String[] subjects		=request.getParameterValues("subjects"); 
String[] research_interests		=request.getParameterValues("research_interests"); 

//check if note with id is owner by user
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
Statement st2= con2.createStatement(); 
ResultSet rs2 = st2.executeQuery("select firstname,lastname,address,phone from profile where id='"+userid+"'"); 
if(rs2.next()) 
{ 
	if(firstname == null){
		firstname=rs2.getString(1);
	}
	if(lastname == null){
		lastname=rs2.getString(2);
	}
	if(address == null){
		address=rs2.getString(3);
	}
	if(phone == null){
		phone=rs2.getString(4);
	}
} else {
	response.sendRedirect("home.jsp");
}

java.sql.Connection con3 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
Statement st3= con3.createStatement(); 
ResultSet rs3 = st3.executeQuery("select s.id,s.name from user_subject u inner join subject s on s.id=u.subject_id where u.user_id='"+userid+"'"); 
ArrayList<String> subjects_orig = new ArrayList<String>();
while(rs3.next()) 
{
	subjects_orig.add(rs3.getString(1));
} 

boolean saved=false;
boolean submit=false;
if( !(save==null) ){
submit=true;
if( (!lastname.equals("")) && (!phone.equals("")) && (!firstname.equals("")) && (!address.equals("")) ){
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
	Statement st= con.createStatement(); 
	st.execute("update profile set address='"+address.trim()+"', phone='"+phone.trim()+"', firstname='"+firstname.trim()+"', lastname='"+lastname.trim()+"'where id='"+userid+"'"); 
	//out.println("update profile set address='"+address.trim()+"', phone='"+phone.trim()+"', firstname='"+firstname.trim()+"', lastname='"+lastname.trim()+"'where id='"+userid+"'"); 
	
	st.execute("delete from user_subject where user_id='"+userid+"'"); 
	st.execute("delete from user_research_interest where user_id='"+userid+"'"); 
	for(int n=0; n<subjects.length; n++)
	{
		st.execute("insert into user_subject (user_id,subject_id) values('"+userid+"','"+subjects[n]+"')"); 
	}
	for(int n=0; n<research_interests.length; n++)
	{
		st.execute("insert into user_research_interest (user_id,research_interest_id) values('"+userid+"','"+research_interests[n]+"')"); 
	}

	saved=true; 
}
}
%>
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
				<label for="firstname">First name:</label>					<!--The firstname label -->
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
<c:forEach var="row2" items="${rs2.rows}">
					<option value="${row2.id}" <c:if test="${!(row2.user_id==null)}">selected='selected'</c:if> >${row2.name}</option>
</c:forEach>	
				</select>
			</fieldset>
			<fieldset class="research-interests">
				<legend>Research Interests</legend>
				<p>
					<i>Hold down ctrl (or CMD on a Mac) to select multiple reserach interests.</i>
				</p>
				<select multiple="multiple" name="research_interests" id="research_interests">
<c:forEach var="row3" items="${rs3.rows}">
					<option value="${row3.id}" <c:if test="${!(row3.user_id==null)}">selected='selected'</c:if> >${row3.name}</option>
</c:forEach>	
				</select>
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