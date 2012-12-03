<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
		return;
	}
%>
<jsp:include page="includes/header.jsp" />
	<div id="main-container">											<!--The main area-->
		<div class="container">
<%

Object userid			=session.getAttribute("userid"); 
String message			=request.getParameter("message"); 
String send				=request.getParameter("send"); 
int sent_messages=0;

if(send != null){
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakebook","fakeuser","fakepwd"); 
	Statement st2= con2.createStatement(); 
	
	List<String> friends = new ArrayList<String>();
	for(Enumeration all_vars = request.getParameterNames(); all_vars.hasMoreElements() ;){
		String val = (String) all_vars.nextElement();
		if(val.startsWith("recipient")){
			friends.add(val.substring(9));
			st2.execute("insert into message (sender_id,recipient_id,message) values ('"+userid+"','"+val.substring(9)+"','"+message+"')"); 
			//out.print(val.substring(9));
			sent_messages++;
		}
	}

}
%>
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
<% if (sent_messages == 0){ %>
			<div class="message">
			<h1>Friends list</h1>
			<p>
				Select the recipients of your message and click 'Send'.
			</p>
				<form action="new-message.jsp" method="get">
				<label for="recipient1">
					<input id="recipient1" type="checkbox" name="recipient1" />
					Favour
				</label>
				<label for="recipient2">
					<input id="recipient2" type="checkbox" name="recipient2"  />
					Chisom
				</label>
				<label for="recipient3">
					<input id="recipient3" type="checkbox" name="recipient3"  />
					Suraju
				</label>
				<label for="recipient4">
					<input id="recipient4" type="checkbox" name="recipient4"  />
					Sample
				</label>
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