<%-- 
    Document   : help
    Created on : Jan 28, 2015, 8:51:14 PM
    Author     : sotos
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<sql:setDataSource var="ds" dataSource="jdbc/h_vash_mou" />
<sql:query dataSource="${ds}" sql="select * from story_database order by story_id desc" var="results" />


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link type="text/css" rel="stylesheet" href="css/style.css">
        <link href="css/webfont.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery.jcarousel.js"></script>
        <!-- Load MixItUup js -->
        <script type="text/javascript" src="js/jquery.mixitup.js"></script>
        <!-- Load js -->
        <script type="text/javascript" src="js/custom.js"></script>
        <title>Help</title>
    </head>
    <body>
        <%
                Object theuser = "";
                if (request.getAttribute("theuser")!=null) {
                    theuser= request.getAttribute("theuser");
                }
            pageContext.setAttribute("theuser", theuser);
            %>
        
        <div class="menubar" data-scroll="false">
		<a href="#" class="logo"></a>
		<ul class="mainmenu">
                    <li class="active">                 
                        <form action="Controller?action=home" method="post">
                            <input type="hidden" name="theuser" value="${theuser}" />
                            <a id="ref" href="#">Home</a>
                        </form>
                    </li>
                    <% if (theuser.equals("")) { %>
			<li><a href="login.jsp">Login</a></li>
			<li><a href="signin.jsp">Sign in</a></li>
                    <% }else { %>
                            <li><a href="<c:url value="/Controller?action=logout" />">Logout</a></li>
                    <% } %>
                    <li><form action="Controller?action=help" method="post">
                            <input type="hidden" name="theuser" value="${theuser}" />
                            <a id="ref2" href="#">help</a>
                        </form>
                   </li>
		</ul>
	</div>
        <script>
                    $('#ref').click(function(e) {
                       e.preventDefault();
                       $(this).parents('form').submit();
                    });
                    $('#ref2').click(function(e) {
                       e.preventDefault();
                       $(this).parents('form').submit();
                    });
        </script>
        
        <p style="margin-top: 100px;text-align: center;padding-top: 10px; font-size: 33px">Help page.</p>
    <center>
        <p style="font-size: 19px">In our home page you can see all of our stories and choose which one you want to watch-follow. </p>
        
        <div class="section divider">
		<h2 id="servicestitle">Add your story.</h2>
		<a class="scroll" id="portfolio"></a>
	</div>        
        <p style="font-size: 19px">In order for you to add a story you need to login or sign in. Both these options 
            are available from the menu at the top of the page.<br>
        Once you have logged in you can add your own story. At the bottom of the page there is the button "Add your
        story now!"<br>
        This button leads you to a page where you can add the steps of your story one by one.<br>On each step:<br> You place one marker on 
        a location on the map.<br> Then you need to add a title and header for this specific step of the story. <br>
        Finally you add the context of the story, whatever you want to say about this step-place.You also have the option to 
        add one photo.</p>
        
        <div class="section divider">
		<h2 id="servicestitle">Manage your stories.</h2>
		<a class="scroll" id="portfolio"></a>
	</div> 
        <p style="font-size: 19px">Once you are logged in and have created a story you can see  your stories from the homepage.<br>
            Clicking on them you are able to watch the story but also edit or delete it.<br><br>
            Each step gives you the option to <b>edit </b>, change the place of the marker, the title, header, text or even the foto.<br>
            Also once you have clicked edit there is a button that lets you add more steps to the story.the steps will be added <br>
            at the end of the story line, after the other steps you have already created.
        </p>
        <footer class="footer">
		<a href="http://ninetofive.me"><h6>CSS © Copyright 2014 | ninetofive.me</h6></a>
                code by Alfonsos Sotiris for <a href="http://www.inf.uth.gr/?page_id=5067&lang=en">WWW Technologies</a>
	</footer>
    </center>
    </body>
</html>




