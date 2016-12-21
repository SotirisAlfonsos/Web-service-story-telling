<%-- 
    Document   : story_edit
    Created on : Jan 14, 2015, 4:02:50 PM
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit your story</title>
        <link type="text/css" rel="stylesheet" href="css/style.css">
        <link href="css/webfont.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery.jcarousel.js"></script>
        <!-- Load MixItUup js -->
        <script type="text/javascript" src="js/jquery.mixitup.js"></script>
        <!-- Load js -->
        <script type="text/javascript" src="js/custom.js"></script>
    </head>
    <body >
        
        
           
            <p style="margin-top: 100px;text-align: center;padding-top: 10px; font-size: 33px">Editing</p>
            
             <%
                Object theuser = "";
                Object storyid = "";
                Object storystep = "";
                Object message = "";
                if (request.getAttribute("message")!=null) {
                    message= request.getAttribute("message");
                }
                if (request.getAttribute("theuser")!=null) {
                    theuser= request.getAttribute("theuser");
                }
                if (request.getAttribute("storyid")!=null) {
                    storyid= request.getAttribute("storyid");
                    storystep= request.getAttribute("storystep");
                }
                pageContext.setAttribute("message", message);
                pageContext.setAttribute("storyid", storyid);
                pageContext.setAttribute("storystep", storystep);
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
             
            <sql:transaction dataSource="jdbc/h_vash_mou">
            <sql:query sql="select * from story_database where story_id=? && step_num=?" var="results">
                <% if (storyid.equals("")) { %>
			<sql:param>${param.parameter_storyid}</sql:param>
                        <sql:param>${param.parameter_step}</sql:param>
                <%}else {%>
                        <sql:param value="${storyid}"></sql:param>
                        <sql:param value="${storystep}"></sql:param>
                <%}%>
                        
	    </sql:query>
            
            
            <c:set scope="page" var="items" value="${results.rows[0]}"></c:set>
            <c:set var="latitude" value="${items.latitude}"/>
            <c:set var="longitude" value="${items.longitude}"/>
            <c:set var="title" value="${items.title}"/>
            
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script>
            <script src="https://maps.googleapis.com/maps/api/js"></script>
            <script>
                var marker;
                var longitude;
                function initialize() {
                    var mapCanvas = document.getElementById('map_canvas');
                    var mapOptions = {center: new google.maps.LatLng(${latitude-0.1}, ${longitude}), zoom: 9, mapTypeId: google.maps.MapTypeId.HYBRID}; 
                    //var latitude=39.35781;
                    //var longitude=22.95074;
                    var map = new google.maps.Map(mapCanvas, mapOptions);
                    var myLatlng = new google.maps.LatLng(${latitude}, ${longitude});
                    var marker = new google.maps.Marker({
                        position: myLatlng, 
                        map: map, 
                        draggable:true, 
                        title: "${title}",
                        animation: google.maps.Animation.DROP
                    });
                    marker.setMap(map);

                      google.maps.event.addListener(marker, 'dragend', function (event) {
                        document.getElementById("latbox").value = event.latLng.lat();
                        document.getElementById("lngbox").value = event.latLng.lng();
                    });

                    google.maps.event.addListener(map, 'click', function(event) {
                        marker.setPosition(event.latLng);
                        
                        document.getElementById("latbox").value=event.latLng.lat();
                        document.getElementById("lngbox").value=event.latLng.lng();   
                    });

                    marker.setMap(map);
                   
                }

                google.maps.event.addDomListener(window, 'load', initialize);

                $(document).ready(function(){
                    $("#story_window").draggable();
                });

            </script>
            <div id="map_canvas"></div>
            <footer class="footer">
		<a href="http://ninetofive.me"><h6>CSS © Copyright 2014 | ninetofive.me</h6></a>
                code by Alfonsos Sotiris for <a href="http://www.inf.uth.gr/?page_id=5067&lang=en">WWW Technologies</a>
            </footer>
        
            
        <div id="story_window">
            <p style="text-align: center;padding-top: 5px; font-size: 27px; color: black"> Story step ${items.step_num}</p>
            <hr>
            
            <FORM ACTION="Story_edit_servlet" METHOD=POST enctype="multipart/form-data">
                <center>
                <input type="hidden" name="theuser" value="${theuser}">
                <input type="hidden" name="action" value="story_steps">
                <input type="hidden" name="parameter_storyid" value="${items.story_id}">
                <input type="hidden" name="parameter_step" value="${items.step_num}">
                <p style="font-size: 17px">Enter the title.</p>
                <input style="text-align: center;height:30px" value="${items.title}" size="30" maxlength="25" type="text" name="title" required>
                <p style="font-size: 17px">Enter the header.</p>
                <input style="text-align: center;height:30px; width:70%" value="${items.header}" size="120" maxlength="80" type="text" name="header" required>
                <p style="font-size: 17px">Enter the text.</p>
                <textarea style="text-align: center;height:150px;width:95%" type="text" name="text_field" >${items.content}</textarea>
                <input size="20" type="hidden" value="${items.latitude}" id="latbox" name="lat">
                <input size="20" type="hidden" value="${items.longitude}" id="lngbox" name="lng">
                <br>
                <br>
                <div style="font-size: 15px">file size < 3MB</div> <input type="file" name="file" />
                <br>
                <% if (message.equals("not a valid image")) { %> <i style="color:red;">${message}</i><br> <% } %>
                <% if (message.equals("please enter a marker")) { %> <i style="color:red;">${message}</i><br> <% } %>
                <br>
                
                <INPUT class="btn_2" TYPE=SUBMIT VALUE="  Submit   ">
                </center>
            </form>
                <br>
                
                <FORM ACTION="Controller" METHOD=POST >
                <center>
                <input type="hidden" name="theuser" value="${theuser}">
                <input type="hidden" name="action" value="create_from_edit">
                <input type="hidden" name="parameter_storyid" value="${items.story_id}">
                <input type="hidden" name="parameter_max" value="${items.max_steps}">
              
                <INPUT class="btn_2" TYPE=SUBMIT VALUE="  Add new steps   ">
                </center>
            </form>
            <hr>
            <FORM ACTION="Controller" METHOD=POST>
                <center>
                    <input type="hidden" name="theuser" value="${theuser}">
                    <INPUT class="btn_2" style="margin-bottom: 10px;" TYPE=SUBMIT VALUE="  Exit Editing   ">
                </center>
            </FORM>
        </div>
            </sql:transaction>
    </body>
</html>

