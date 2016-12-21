
package com.example.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Controller
 */
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Map<String, String> actionMap = new HashMap<String, String>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() { 

		actionMap.put("story_begin", "/the_story_window.jsp");
                actionMap.put("story_begin_with_edit", "/the_story_window.jsp");
		actionMap.put("story_steps", "/the_story_window.jsp");
		actionMap.put("home", "/index.jsp");
                actionMap.put("login", "/login.jsp");
		actionMap.put("signin", "/signin.jsp");
                actionMap.put("story_steps_edit", "/story_edit.jsp");
                actionMap.put("create_from_edit", "/story_create.jsp");
                actionMap.put("story_delete", "/index.jsp");
                actionMap.put("help", "/help.jsp");
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
        @Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	private void doForward(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String parameter_max;
            String parameter_storyid="";
            String parameter_step="";
		String action = request.getParameter("action");
                String username = request.getParameter("theuser");
                request.setAttribute("theuser", username);
                
		if (action == null || !actionMap.containsKey(action))
			action = "home";
                System.out.println(action);
                if (action.equals("logout")) {
                    request.setAttribute("theuser", "");
                }
                if (action.equals("story_begin_with_edit") || action.equals("story_steps_edit"))
                    request.setAttribute("action", action);
                if (action.equals("story_begin_with_edit") || action.equals("story_begin") || action.equals("story_steps")){
                    parameter_storyid = request.getParameter("parameter_storyid");
                    parameter_step = request.getParameter("parameter_step");
                    request.setAttribute("parameter_storyid", parameter_storyid);
                    request.setAttribute("parameter_step", parameter_step);
                }
                if (action.equals("create_from_edit")){
                    parameter_storyid = request.getParameter("parameter_storyid");
                    parameter_max = request.getParameter("parameter_max");
                    parameter_max=Integer.toString(Integer.parseInt(parameter_max)+1);
                    request.setAttribute("storyid", parameter_storyid);
                    request.setAttribute("storystep", parameter_max);
                }
                
                if (action.equals("story_delete")) {
                    
                    //String  = request.getParameter("parameter_storyid");
                    Connection conn;
                    String url="jdbc:mysql://localhost:3306/";
                    String dbName="h_vash_mou";
                    String driver="com.mysql.jdbc.Driver";
                    try {
                        Class.forName(driver).newInstance();
                        conn = DriverManager.getConnection(url+dbName,"alfonsos", "alfonsos1"); 
                        PreparedStatement pst =(PreparedStatement) conn.prepareStatement("DELETE FROM `h_vash_mou`.`story_database` WHERE `story_id` = ? and `username` = ?");
                        pst.setInt(1,Integer.parseInt(request.getParameter("parameter_storyid")));
                        pst.setString(2,username);
                        pst.executeUpdate();
                        pst.close();
                    }catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex){
                        Logger.getLogger(MySignInServlet.class.getName()).log(Level.SEVERE, null, ex);  
                    }
                    
                }
               
		request.getRequestDispatcher(actionMap.get(action)).forward(request,
				response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
        @Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		doForward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
        @Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		doForward(request, response);
	}

}

