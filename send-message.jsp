<%-- Import required libraries since we will be using SQL on this page --%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {		//test if the userid is set in the session
			response.sendRedirect("index.jsp");			//redirect the user to index.jsp
		return;											//stop executing commands
	}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
<%

Object userid			=session.getAttribute("userid"); 	//pick userid from the session
String message			=request.getParameter("message"); 	//pick message from the request
String send				=request.getParameter("send"); 		//pick send from the request
int sent_messages=0;										//number of sent messages

if(send != null){											//test if send button is clicked
	Class.forName("com.mysql.jdbc.Driver"); 				//import the jdbc mysql driver
	java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); //connect to the database
	Statement st2= con2.createStatement(); 					//create a database statement object
	
	List<String> friends = new ArrayList<String>();         //create a string list to store all recipient ids
	for(Enumeration all_vars = request.getParameterNames(); all_vars.hasMoreElements() ;){	//iterate through the variables sent in this request
		String val = (String) all_vars.nextElement();		// store the current element in a variable, val
		if(val.startsWith("recipient")){					//test if the value starts with recipient
			friends.add(val.substring(9));					//Add the element to the recipient ids list
			st2.execute("insert into message (sender_id,recipient_id,message) values ('"+userid+"','"+val.substring(9)+"','"+message+"')"); //save message for resipient 
			//out.print(val.substring(9));
			sent_messages++;
		}
	}

}
%>
<%-- CREATE A PAGE-LEVEL SQL QUERY TO FETCH THE NAMES OF THE RECIPIENTS --%>
<sql:query var="rs" dataSource="jdbc/fakebook">
SELECT id,concat(firstname,' ',lastname) as name from profile inner join friend on friend.friend_id=profile.id where 
friend.user_id=<% out.print( session.getAttribute("userid") ); %>
</sql:query>
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
<% if (sent_messages == 0){ %>
			<div class="message">
			<h1>Friends list</h1>
			<p>
				Select the recipients of your message and click 'Send'.
			</p>
				<form action="new-message.jsp" method="get">
<c:forEach var="row" items="${rs.rows}">
				<label for="recipient${row.id}">
					<input id="recipient${row.id}" type="checkbox" name="recipient${row.id}"  />
					${row.name}
				</label>
</c:forEach>	
				<div class="manage">
					<input name="send" type="submit" value="Send"/>
				</div>
				</form>
			</div>
<% } else { %>
	Message sent to <% out.print(sent_messages); %> recipient(s).
<% } %>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />