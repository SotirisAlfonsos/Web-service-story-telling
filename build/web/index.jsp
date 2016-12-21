<%-- 
    Document   : index
    Created on : Dec 7, 2014, 10:53:45 PM
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
        <title>Maptales</title>
        
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
        <a class="scroll" id="home"></a>
	<div class="home hero">
		<div class="overlay"></div>
		<div class="herowrapper">
			<h1>Maptales, a place to <b class="rotate color">watch,add,share</b> tales</h1>
		</div>
		<a href="javascript:void(0);" class="scrolldown">
			<h3>More about us</h3>
			<div data-icon="&#xe017;" class="icon"></div>
		</a>
	</div>
        <div class="blockquote main">
            <blockquote>Welcome to our site. Feel free to <i>login</i> and <b>add your own story!</b></blockquote>
	</div>
        <% if (!theuser.equals("")) { %>
        <div class="content">

		<!-- Start HomePage Section -->
		<div class="section full">
			<h2>Your stories</h2>
                        
			<ul class="carousel" id="carousellatest">
                        <c:forEach var="items" items="${results.rows}" varStatus="row">
                            <c:if test="${items.username==theuser && items.step_num==1}">
				<!-- Start Single Block -->
				<li>
					<div class="section block">	
						<FORM ACTION="Controller" METHOD=POST>
                                                    <input type="hidden" name="theuser" value="${theuser}">
                                                    <input type="hidden" name="action" value="story_begin_with_edit">
                                                    <input type="hidden" name="parameter_storyid" value="${items.story_id}">
                                                    <input type="hidden" name="parameter_step" value="${items.step_num}">
                                                    <c:set var="var" value=""/>
                                                    <c:choose>
                                                        <c:when test="${items.image_name!=var}" >
                                                            <input type="image" src="${pageContext.request.contextPath}/pictures/${items.image_name}" alt="Submit">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="image" src="${pageContext.request.contextPath}/pics/images.jpg" alt="Submit">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>
						<div class="content">
							<h5>by ${items.username}</h5>
							<h6>${items.title}</h6>
						</div>
						
					</div>
				</li>
				<!-- End Single Block -->
                            </c:if>
                        </c:forEach>

			</ul>

		</div>
		<!-- End HomePage Section -->

		<!-- Clear :) -->
		<div class="clear"></div>
        </div>
        <% } %>
        <div class="section divider">
		<h2 id="servicestitle">Our featured stories</h2>
		<a class="scroll" id="portfolio"></a>
	</div>
        <ul class="portfolio">
            <c:forEach var="items" items="${results.rows}" varStatus="row">
                <c:if test="${items.step_num==1}">
		<li class="item design">
			<div class="portfolioitem">
				<FORM ACTION="Controller?parameter_storyid=${items.story_id}&parameter_step=${items.step_num}&action=story_begin" METHOD=POST>
                                    <input type="hidden" name="theuser" value="${theuser}">
                                    <c:set var="var" value=""/>
                                        <c:choose>
                                            <c:when test="${items.image_name!=var}" >
                                                <input type="image" src="${pageContext.request.contextPath}/pictures/${items.image_name}" alt="Submit">
                                            </c:when>
                                            <c:otherwise>
                                                <input type="image" src="${pageContext.request.contextPath}/pics/images.jpg" alt="Submit">
                                            </c:otherwise>
                                        </c:choose>
                                </form>
				<!--<div class="portfoliohover">-->
					<div class="info">
						
						<h5>by ${items.username}</h5>
						<h6>${items.title}<b class="light-gray"></b></h6>
					</div>
				<!--</div>-->
			</div>
		</li>
                </c:if>
            </c:forEach>
        </ul>
          <div class="clear"></div>
        <% if (!theuser.equals("")) { %>
        <div class="section divider">
		<h2 id="servicestitle">Add your own story!</h2>
		<a class="scroll" id="portfolio"></a>
	</div>
        <center>
                <form method="POST" action="My_first_create_servlet">
                    <% request.setAttribute("user", theuser); %>
                    <input type="hidden" name="first" value="first_step">
                    <input type="hidden" name="theuser" value="${theuser}">
                    <input class="btn" type="Submit" value=" Add your story now! ">
                </form>
        </center>
        <% } %>
        
        <footer class="footer">
		<a href="http://ninetofive.me"><h6>CSS © Copyright 2014 | ninetofive.me</h6></a>
                code by Alfonsos Sotiris for <a href="http://www.inf.uth.gr/?page_id=5067&lang=en">WWW Technologies</a>
	</footer>
        
        </div>
    </center>
        
    </body>
</html>

