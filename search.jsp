<jsp:include page="includes/header.jsp" />
	<div id="main-container">																			<!--The main area-->
		<div class="container">
		
<jsp:include page="includes/links.jsp" />	
		<div id="content">
			<div class="message">
			<h1>Search</h1>
			<form action="search-results.jsp" method="get">
				<p>
					Select a criteria and click 'Search'.
				</p>
				<label for="search-both">
					<input id="search-both" type="radio" checked="checked" name="criteria" value="both" />
					Both Subjects and Research Interests
				</label>
				<label for="search-subject">
					<input id="search-subject" type="radio" name="criteria" value="subject" />
					Subject
				</label>
				<label for="search-research-interest">
					<input id="search-research-interest" type="radio" name="criteria" value="research_interest" />
					Research Interest
				</label>
				<div class="manage">
					<input name="search" type="submit" value="Search"/>
				</div>
			</form>
			</div>
		</div>	
		<div class="clear"></div>
		
		</div>
	</div>
<jsp:include page="includes/footer.jsp" />
