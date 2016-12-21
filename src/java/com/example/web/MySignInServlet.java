/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author sotos
 */

public class MySignInServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        response.setContentType("text/html");
        
        ResultSet rs;
        Connection conn;
        String url="jdbc:mysql://localhost:3306/";
        String dbName="h_vash_mou";
        String driver="com.mysql.jdbc.Driver";

        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");
        
        try{
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url+dbName,"alfonsos", "alfonsos1");
            String query = "select * from users where name='" + account + "' ";
            Statement st = conn.createStatement();
            rs = st.executeQuery(query);
        
            if (!rs.next()) {
                if (password.equals(password2)) {
                        PreparedStatement pst =(PreparedStatement) conn.prepareStatement("insert into `h_vash_mou`.`users`(`name`, `password`) values(?,?)");
                        pst.setString(1,account);  
                        pst.setString(2,password);
                        pst.executeUpdate();
                        pst.close();  
                        request.setAttribute("theuser", account);
                        request.getRequestDispatcher("/index.jsp").forward(request,response);
                }else {
                    String message= "Sorry the passwords are different";  
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("/signin.jsp").forward(request,response);
                }
            }else {
                String message= "Sorry username is in use. Pick another.";  
                request.setAttribute("message", message);
                request.getRequestDispatcher("/signin.jsp").forward(request,response);
            }
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            Logger.getLogger(MySignInServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}