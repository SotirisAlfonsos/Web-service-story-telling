<%-- 
    Document   : the_story_window
    Created on : Dec 7, 2014, 9:45:35 PM
    Author     : sotos
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<sql:setDataSource var="ds" dataSource="jdbc/h_vash_mou" />
<sql:query dataSource="${ds}" sql="select * from story_database order by story_id desc" var="results" />

<!DOCTYPE html>
<html id="htm">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The story</title>
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
                Object action = "";
                Object parameter_storyid="";
                Object parameter_step="";
                if (request.getAttribute("theuser")!=null) {
                    theuser= request.getAttribute("theuser");
                }
                if (request.getAttribute("action")!=null) {
                    action= request.getAttribute("action");
                }
                if (request.getAttribute("parameter_storyid")!=null) {
                    parameter_storyid= request.getAttribute("parameter_storyid");
                }
                if (request.getAttribute("parameter_step")!=null) {
                    parameter_step= request.getAttribute("parameter_step");
                }
                pageContext.setAttribute("parameter_storyid", parameter_storyid);
                pageContext.setAttribute("parameter_step", parameter_step);
                pageContext.setAttribute("action", action);
                pageContext.setAttribute("theuser", theuser);
            System.out.println(parameter_storyid + " " + parameter_step);%>
            
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
           
            
            <p style="margin-top: 100px;text-align: center;padding-top: 10px; font-size: 33px">Step ${parameter_step} !</p>
            
            
            
            <sql:transaction dataSource="jdbc/h_vash_mou">
            <sql:query sql="select * from story_database where story_id=? && step_num=?" var="results">
                <sql:param value="${parameter_storyid}"></sql:param>
                <sql:param value="${parameter_step}"></sql:param>
                        
	    </sql:query>
            
            
            <c:set scope="page" var="items" value="${results.rows[0]}"></c:set>
            <c:set var="latitude" value="${items.latitude}"/>
            <c:set var="longitude" value="${items.longitude}"/>
            <c:set var="title" value="${items.title}"/>
          
          <div id="MyDiv">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script>  
            <script src="https://maps.googleapis.com/maps/api/js"></script>
                <script>
                    function initialize() {
                        var mapCanvas = document.getElementById('map_canvas');
                        var mapOptions = {center: new google.maps.LatLng(${latitude-0.1}, ${longitude}), zoom: 9, mapTypeId: google.maps.MapTypeId.HYBRID}; 
                        
                        var map = new google.maps.Map(mapCanvas, mapOptions);
                        var myLatlng = new google.maps.LatLng(${latitude}, ${longitude});
                        var marker = new google.maps.Marker({position: myLatlng, map: map,title: "${title}",animation: google.maps.Animation.DROP});
                        marker.setMap(map);
                        
                        google.maps.event.addListener(marker, 'click', function() {
                           
                            map.setCenter(new google.maps.LatLng(${latitude-0.01}, ${longitude}));
                            map.setZoom(13);
                        });
                        
                        
                    }
                    google.maps.event.addDomListener(window, 'load', initialize);
    
                $(document).ready(function(){
                    $("#story_window").draggable();
                });
                </script>
          </div>   
            
            <div id="map_canvas"></div>
            
            <footer class="footer">
		<a href="http://ninetofive.me"><h6>CSS © Copyright 2014 | ninetofive.me</h6></a>
                code by Alfonsos Sotiris for <a href="http://www.inf.uth.gr/?page_id=5067&lang=en">WWW Technologies</a>
            </footer>
            
        
        <div id="story_window">
            
                <table style=" width:100%">
                    <td id="next_story_step_image1">
                        <c:if test="${(items.step_num-1)!=0}">
                            <% if (!theuser.equals("") && !action.equals("")) { %>
                            <FORM ACTION="Controller" METHOD=POST>
                                <input type="hidden" name="theuser" value="${theuser}">
                                
                                <input type="hidden" name="action" value="story_begin_with_edit">
                                <input type="hidden" name="parameter_storyid" value="${items.story_id}">
                                <input type="hidden" name="parameter_step" value="${items.step_num-1}">
                            
                                <input style="padding-top: 5px" type="image" style="border-radius: 20px; " src="${pageContext.request.contextPath}/pics/left-arrow.png" >
                     
                            </form>
                            <% }else{ %>
                                <FORM ACTION="Controller?parameter_storyid=${items.story_id}&parameter_step=${items.step_num-1}&action=story_begin" METHOD=POST>
                                    <input type="hidden" name="theuser" value="${theuser}">
                                    <input style="padding-top: 5px" type="image" style="border-radius: 20px; " src="${pageContext.request.contextPath}/pics/left-arrow.png" >

                                </form>
                            <% } %>
                        </c:if>
                        <c:if test="${(items.step_num-1)==0}">
                            <div style="width:79px;height:30px"/>
                        </c:if>
                    </td>
                    <td style="width: 100%">
                        <p style="text-align: center;padding-top: 5px; font-size: 30px; color: black">${items.header} </>
                    </td>
                    <td id="next_story_step_image2">
                        <c:if test="${items.step_num!=items.max_steps}">
                            <% if (!theuser.equals("") && !action.equals("")) { %>
                                <FORM ACTION="Controller" METHOD=POST>
                                    <input type="hidden" name="theuser" value="${theuser}">

                                    <input type="hidden" name="action" value="story_begin_with_edit">


                                    <input type="hidden" name="parameter_storyid" value="${items.story_id}">
                                    <input type="hidden" name="parameter_step" value="${items.step_num+1}">
                                    <input style="padding-top: 5px" type="image" style="border-radius: 20px;" src="${pageContext.request.contextPath}/pics/right-arrow.png" alt="Submit">

                                </form>
                            <% }else{ %>
                                <FORM ACTION="Controller?parameter_storyid=${items.story_id}&parameter_step=${items.step_num+1}&action=story_begin" METHOD=POST>
                                    <input type="hidden" name="theuser" value="${theuser}">
                                    <input type="hidden" name="action" value="story_steps">
                                    <input type="hidden" name="parameter_storyid" value="${items.story_id}">
                                    <input type="hidden" name="parameter_step" value="${items.step_num+1}">
                                    <input style="padding-top: 5px" type="image" style="border-radius: 20px;" src="${pageContext.request.contextPath}/pics/right-arrow.png" alt="Submit">

                                </form>

                            <% } %>
                        
                        </c:if>
                        <c:if test="${items.step_num==items.max_steps}">
                            <div style="width:79px;height:30px"/>
                        </c:if>
                    </td>
                </table>
           
            <hr>
            
            <center>
                <table style="width: 100%; padding:10px;">
                     
                    <c:set var="val" value=""/>
                    <c:if test="${items.image_name != val}">
                        <tr>
                        <img style="margin-left: 5%; height: 400px;width:80%;margin-right: 5%" src="${pageContext.request.contextPath}/pictures/${items.image_name}"/>
                    </tr>
                    
                    </c:if>
                    <tr >
                        <div id="text_on_story">${items.content}</div>
                    </tr>   
                </table>
            </center>
                
                <% if (!theuser.equals("") && !action.equals("")) { %>
                <center>
                    <FORM ACTION="Controller" METHOD=POST>
                        <input type="hidden" name="theuser" value="${theuser}">
                        <input type="hidden" name="action" value="story_steps_edit">
                        <input type="hidden" name="parameter_storyid" value="${items.story_id}">
                        <input type="hidden" name="parameter_step" value="${items.step_num}">
                        <INPUT style="height:20px;width: 80px;margin-bottom: 10px;" TYPE=SUBMIT VALUE="  Edit   ">

                    </form>
                    <FORM ACTION="Controller" METHOD=POST>
                        <input type="hidden" name="theuser" value="${theuser}">
                        <input type="hidden" name="action" value="story_delete">
                        <input type="hidden" name="parameter_storyid" value="${items.story_id}">
                        <input type="hidden" name="parameter_step" value="${items.step_num}">
                        <INPUT style="height:20px;width: 150px;margin-bottom: 10px;" TYPE=SUBMIT VALUE="  DELETE STORY   ">

                    </form>
                </center>
                <% } %>
        </div>
        </sql:transaction>
    </body>
</html>
