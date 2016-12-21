<%-- 
    Document   : signin
    Created on : Jan 2, 2015, 3:34:37 PM
    Author     : sotos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%-- 
    Document   : login
    Created on : Jan 2, 2015, 3:18:20 PM
    Author     : sotos
--%>
<HTML>
    <head>
    <link type="text/css" rel="stylesheet" href="css/style.css">
        <link href="css/webfont.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery.jcarousel.js"></script>
        <!-- Load MixItUup js -->
        <script type="text/javascript" src="js/jquery.mixitup.js"></script>
        <!-- Load js -->
        <script type="text/javascript" src="js/custom.js"></script>
    <TITLE>Sign In</TITLE>
    </HEAD>
    <BODY>
        
        <div class="menubar" data-scroll="false">
		<a href="#" class="logo"></a>
		<ul class="mainmenu">
                    <li class="active"><a href="index.jsp">Home</a></li>
                    <li><form action="Controller?action=help" method="post">
                            <input type="hidden" name="theuser" value="${theuser}" />
                            <a id="ref2" href="#">help</a>
                        </form></li>
		</ul>
	</div>
            <script>
                    
                    $('#ref2').click(function(e) {
                       e.preventDefault();
                       $(this).parents('form').submit();
                    });
        </script>
        <FORM ACTION=SigninHandler METHOD=POST>
            <CENTER>
                <TABLE style="margin-top: 100px; height: 400px" BORDER=0>
                    <TR><TD COLSPAN=2>
                        <h3 ALIGN=CENTER>
                        Welcome!<br>
                        Please enter an Account Name<br>
                        and Password to sign in.</H3><br>
                    </TD></TR>

                    <TR><TD>
                        <P ALIGN=RIGHT><B>Account:</B>
                    </TD>
                    <TD>
                        <P><INPUT TYPE=TEXT NAME="account" VALUE="" SIZE=15 required>
                    </TD></TR>

                    <TR><TD>
                        <P ALIGN=RIGHT><B>Password:</B>
                    </TD>
                    <TD>
                        <P><INPUT TYPE=PASSWORD NAME="password" VALUE="" SIZE=15 required>
                    </TD></TR>                                                            

                    <TR><TD>
                        <P ALIGN=RIGHT><B>Re-enter password:</B>
                    </TD>
                    <TD>
                        <P><INPUT TYPE=PASSWORD NAME="password2" VALUE="" SIZE=15 required>
                    </TD></TR>                                                            

                    <TR><TD COLSPAN=2>                                                    
                        <CENTER>                                                              
                            <INPUT class="btn_2" TYPE=SUBMIT VALUE="  OK   ">                                   
                        </CENTER>                                                             
                    </TD></TR>
                </TABLE>
                <%
                    Object message = "";
                    if (request.getAttribute("message")!=null) {
                        message= request.getAttribute("message");
                    }
                %>
                <i style="color: red;"><%=message%></i>
            </CENTER>
        </FORM>  
        <footer class="footer">
		<a href="http://ninetofive.me"><h6>CSS © Copyright 2014 | ninetofive.me</h6></a>
                code by Alfonsos Sotiris for <a href="http://www.inf.uth.gr/?page_id=5067&lang=en">WWW Technologies</a>
	</footer>
        
    </BODY>
</HTML>
