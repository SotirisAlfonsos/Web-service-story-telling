
package com.example.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author sotos
 */
public class My_first_create_servlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private boolean isMultipart;
   private String filePath;
   private final int maxFileSize = 5000 * 1024;
   private final int maxMemSize = 4 * 1024;
   private File file ;
   
   
    public void init( ){
      // Get the file location where it would be stored.
      filePath = 
             getServletContext().getInitParameter("file-upload"); 
   }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int count=1;
        String storyid,storystep;
        String fileName="";
        int f=0;
        String action = "";
        String first = request.getParameter("first");
        String user = request.getParameter("theuser");
        String title = request.getParameter("title");
        String header = request.getParameter("header");
        String text_field = request.getParameter("text_field");
        
        String latitude = request.getParameter("lat");
        String longitude = request.getParameter("lng");
        storyid =  (request.getParameter("storyid"));
        storystep =  (request.getParameter("storystep"));
        String message="";
        int valid=1;
        String query;
        ResultSet rs;
        Connection conn;
        String url="jdbc:mysql://localhost:3306/";
        String dbName="h_vash_mou";
        String driver="com.mysql.jdbc.Driver";
        
        isMultipart = ServletFileUpload.isMultipartContent(request);
        java.io.PrintWriter out = response.getWriter( );
        if( isMultipart ){
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // maximum size that will be stored in memory
            factory.setSizeThreshold(maxMemSize);
            // Location to save data that is larger than maxMemSize.
            //factory.setRepository(new File("/var/lib/tomcat7/webapps/www_term_project/temp/"));
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
            
            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);
            // maximum file size to be uploaded.
            upload.setSizeMax( maxFileSize );

            try{ 
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator i = fileItems.iterator();

            while ( i.hasNext () ) 
            {
               FileItem fi = (FileItem)i.next();
               if ( !fi.isFormField () )	
               {
                    // Get the uploaded file parameters
                    String fieldName = fi.getFieldName();
                    fileName = fi.getName();
                    String contentType = fi.getContentType();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();
                    String[] spliting = fileName.split("\\.");
                    // Write the file
                    System.out.println(sizeInBytes + " " + maxFileSize);
                    System.out.println(spliting[spliting.length-1]);
                    if (!fileName.equals("")){
                    if ((sizeInBytes<maxFileSize) && (spliting[spliting.length-1].equals("jpg") || spliting[spliting.length-1].equals("png") ||  spliting[spliting.length-1].equals("jpeg"))){
                        
                    
                    if( fileName.lastIndexOf("\\") >= 0 ){
                       file = new File( filePath + 
                       fileName.substring( fileName.lastIndexOf("\\"))) ;
                    }else{
                       file = new File( filePath + 
                       fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                    }
                    fi.write( file ) ;
                    out.println("Uploaded Filename: " + fileName + "<br>");
                    }else{valid=0;  message= "not a valid image";}
                }
               }
                BufferedReader br = null;
                StringBuilder sb = new StringBuilder();

                String line;
                try {
                    br = new BufferedReader(new InputStreamReader(fi.getInputStream()));
                    while ((line = br.readLine()) != null) {
                        sb.append(line);
                    }
                } catch (IOException e) {	
                } finally {
                    if (br != null) {
                        try {
                            br.close();
                        } catch (IOException e) { }
                    }
                }
                if (f==0) user=sb.toString();
                else if (f==1) action=sb.toString();
                else if (f==2) storyid=sb.toString();
                else if (f==3) storystep=sb.toString();
                else if (f==4) title=sb.toString();
                else if (f==5) header=sb.toString();
                else if (f==6) text_field=sb.toString();
                else if (f==7) latitude=sb.toString();
                else if (f==8) longitude=sb.toString();
                
                f++;
               
            }
            }catch(Exception ex) {
                System.out.println("hi");
              System.out.println(ex);
              
            } 
        } 
        
        request.setAttribute("theuser", user);
        if (latitude==null) latitude="";
        if (latitude.equals("") && first==null){
            
            request.setAttribute("message", "please enter a marker");
            request.setAttribute("storyid", storyid);
             
            request.setAttribute("storystep", storystep);
            request.getRequestDispatcher("/story_create.jsp").forward(request,response);
        }else if(valid==1) {
        try{
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url+dbName,"alfonsos", "alfonsos1");
            if (first!=null) {
                if (first.equals("first_step")) {
                    do{
                    query = "select * from story_database where story_id='" + count + "' ";
                    Statement st = conn.createStatement();
                    rs = st.executeQuery(query);
                    count++;
                    }while(rs.next());
                    
                    int a =count-1;
                    request.setAttribute("storyid", a);
                    
                    request.setAttribute("storystep", 1);
                }
            }else{
                query = "select * from story_database where `story_id`='" + storyid + "' && `step_num`='" + storystep + "' ";
                Statement st = conn.createStatement();
                rs = st.executeQuery(query);
                if (!rs.next()) {
                    PreparedStatement pst =(PreparedStatement) conn.prepareStatement("insert into `h_vash_mou`.`story_database`(`story_id`, `step_num`, `content`, `latitude`, `longitude`, `title`, `header`, `max_steps`, `username`,`image_name`) values(?,?,?,?,?,?,?,?,?,?)");

                    pst.setInt(1,Integer.parseInt(storyid));  
                    pst.setInt(2,Integer.parseInt(storystep));
                    pst.setString(3,text_field); 
                    pst.setString(4,latitude); 
                    pst.setString(5,longitude); 
                    pst.setString(6,title); 
                    pst.setString(7,header); 
                    pst.setInt(8,Integer.parseInt(storystep));
                    pst.setString(9,user);
                    if (fileName.equals(""))
                        pst.setString(10,"");
                    else
                        pst.setString(10,fileName);
                    pst.executeUpdate();
                    pst.close();  

                    pst =(PreparedStatement) conn.prepareStatement("UPDATE `h_vash_mou`.`story_database` SET `max_steps` = ? WHERE `story_id` = ?");
                    pst.setInt(1,Integer.parseInt(storystep));
                    pst.setInt(2,Integer.parseInt(storyid));
                    pst.executeUpdate();
                    pst.close(); 
                }else {
                    PreparedStatement pst =(PreparedStatement) conn.prepareStatement("UPDATE `h_vash_mou`.`story_database` SET `content`=?, `latitude`=?, `longitude`=?, `title`=?, `header`=?, `max_steps`=?, `username`=? WHERE `story_id` = ? && `step_num`=?");

                    
                    pst.setString(1,text_field); 
                    pst.setString(2,latitude); 
                    pst.setString(3,longitude); 
                    pst.setString(4,title); 
                    pst.setString(5,header); 
                    
                    pst.setInt(6,Integer.parseInt(storystep));
                    pst.setString(7,user);
                    pst.setInt(8,Integer.parseInt(storyid));  
                    pst.setInt(9,Integer.parseInt(storystep));
                    
                    pst.executeUpdate();
                    pst.close();  

                    pst =(PreparedStatement) conn.prepareStatement("UPDATE `h_vash_mou`.`story_database` SET `max_steps` = ? WHERE `story_id` = ?");
                    pst.setInt(1,Integer.parseInt(storystep));
                    pst.setInt(2,Integer.parseInt(storyid));
                    pst.executeUpdate();
                    pst.close();
                }
                request.setAttribute("storyid", storyid);
                storystep=Integer.toString(Integer.parseInt(storystep)+1);
                request.setAttribute("storystep", storystep);
            }
        }catch(ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            Logger.getLogger(MySignInServlet.class.getName()).log(Level.SEVERE, null, ex);  
        }   
        
        
        request.getRequestDispatcher("/story_create.jsp").forward(request,response);
            
        }else{
            request.setAttribute("storyid", storyid);
            request.setAttribute("message", message);    
            request.setAttribute("storystep", storystep);
            request.getRequestDispatcher("/story_create.jsp").forward(request,response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
