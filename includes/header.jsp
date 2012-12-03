<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>Fakebook</title>
	<link href="css/style.css" rel="stylesheet" />
</head>
<body>

<div id="wrapper">										<!--A wrapper for the page-->
	<div id="top-bar">									<!--The topbar -->
		<div class="container">

		<div id="logo">									<!--The logo -->
			<a href="index.jsp"><img src="images/logo.jpg" border="0"/></a>
		</div>
		<div id="login-area">							<!--The login-area -->
<% if (session.getAttribute("userid") == null) { %>
	<jsp:include page="login.jsp" />
<%	} else { %>
<sql:query var="rs" dataSource="jdbc/fakebook">
select firstname, lastname from profile where id=<% out.println( session.getAttribute("userid") ); %>
</sql:query>


<c:forEach var="row" items="${rs.rows}">
Hello, ${row.firstname} ${row.lastname} [ <a href="logout.jsp"><i>logout</i></a> ]<br/>
</c:forEach>	
<%	} %>


		</div>
		<div class="clear"></div>
		</div>
	</div>
