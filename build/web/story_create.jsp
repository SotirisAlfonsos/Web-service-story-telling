<%-- 
    Document   : story_create
    Created on : Jan 5, 2015, 2:41:08 PM
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
        <title>Add your story</title>
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
        <c:set var="longitude" value="0"/>
       
           
            <p style="margin-top: 100px;text-align: center;padding-top: 10px; font-size: 33px">Starting your own story. Yeah!</p>
            
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
            
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script>
            <script src="https://maps.googleapis.com/maps/api/js"></script>
            <script>
                var marker;
                
                function initialize() {
                    var mapCanvas = document.getElementById('map_canvas');
                    var mapOptions = {center: new google.maps.LatLng(39, 38), zoom: 3, mapTypeId: google.maps.MapTypeId.HYBRID}; 
                    
                    var map = new google.maps.Map(mapCanvas, mapOptions);
                    
                    google.maps.event.addListener(map, 'click', function(event) {
                        if (marker === undefined){
                            marker = new google.maps.Marker({
                                position: event.latLng,
                                map: map,
                                animation: google.maps.Animation.DROP
                            });
                            document.getElementById("latbox").value = event.latLng.lat();
                            document.getElementById("lngbox").value = event.latLng.lng();

                        }
                        else{
                            marker.setPosition(event.latLng);
                            
                            document.getElementById("latbox").value=event.latLng.lat();
                            document.getElementById("lngbox").value=event.latLng.lng();     
                         }
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
            <p style="text-align: center;padding-top: 5px; font-size: 27px; color: black"> Story step ${storystep}</p>
            <hr>
            
            <FORM ACTION="My_first_create_servlet" METHOD=POST enctype="multipart/form-data">
                <center>
                <input type="hidden" name="theuser" value="${theuser}">
                <input type="hidden" name="action" value="story_steps">
                <input type="hidden" name="storyid" value="${storyid}">
                <input type="hidden" name="storystep" value="${storystep}">
                <p style="font-size: 17px">Enter the title:</p>
                <input style="text-align: center;height:30px" size="30" maxlength="25" type="text" name="title" required>
                <p style="font-size: 17px">Enter the header:</p>
                <input style="text-align: center;height:30px; width:70%" size="120" maxlength="80" type="text" name="header" required>
                <p style="font-size: 17px">Enter the text:</p>
                <textarea style="text-align: center;height:150px;width:95%" type="text" name="text_field" ></textarea>
                <input size="20" type="hidden" id="latbox" name="lat">
                <input size="20" type="hidden" id="lngbox" name="lng">
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
           
                <hr>
            <FORM ACTION="Controller" METHOD=POST>
            <center>
                <input type="hidden" name="theuser" value="${theuser}">
                <INPUT class="btn_2" style="margin-bottom: 10px;" TYPE=SUBMIT VALUE="  Exit Editing   ">
            </center>
            </FORM>
        </div>
    </body>
</html>
