/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Forum;

import Entities.Forum;
import Entities.User;
import Repository.Implementation.ForumRepository;
import Repository.Implementation.UserRepository;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author zilas
 */
@WebServlet(name = "ForumCreateServlet", urlPatterns = {"/forum/create"})
@MultipartConfig(location = "/", fileSizeThreshold = 1024 * 1024  * 10, maxFileSize = 1024 * 1024 * 100, maxRequestSize = 1024 * 1024 * 100 * 5)
public class ForumCreateServlet extends HttpServlet {

    @Inject
    User user;

    @Inject
    Forum forum;

    @Inject
    ForumRepository forumRepo;
    
    @Inject
    UserRepository userRepo;

    private String getRequestFileExtension(String fileName){
        int i = fileName.length() - 1;
        StringBuilder extension = new StringBuilder();
        while(fileName.charAt(i) != '.'){
            extension.append(fileName.charAt(i));
            i -= 1;
        }
        extension.reverse();        
        return ("." + extension.toString());
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher view = getServletContext().getRequestDispatcher("/forumCreate.jsp");

        HttpSession session = request.getSession();

        if (session.getAttribute("session_id") != null && session.getAttribute("session_id").equals(session.getId())) {
            user = (User) session.getAttribute("user");
            request.setAttribute("authStatus", true);
            request.setAttribute("user", user);            

            if (request.getParameter("form_flag") != null) {                
                String uploadPath = getServletContext().getRealPath("").replace(File.separator + "web", File.separator + "storage" + File.separator + "forums_icons");
                System.out.println(uploadPath);
                String fileName = (BCrypt.hashpw(request.getPart("forum_icon").getSubmittedFileName(), BCrypt.gensalt()) + getRequestFileExtension(request.getPart("forum_icon").getSubmittedFileName())).replace("/", "|");
                File uploadDir = new File(uploadPath);
                
                
                if (!uploadDir.exists()) {                    
                    uploadDir.mkdirs();                                        
                }
                
                File file = new File(uploadPath + File.separator + fileName);
                file.createNewFile();                
                                
                forum.setName(request.getParameter("forum_name").trim());
                forum.setDescription(request.getParameter("forum_description"));
                forum.setCreatedBy(user);
                
                Part fileIcon = request.getPart("forum_icon");                
                fileIcon.write(uploadPath + File.separator +  fileName);
                
                forum.setImagePath(uploadPath + File.separator + fileName);
                forumRepo.save(forum);                               
                request.setAttribute("success", true);
            }

        } else {
            request.setAttribute("authStatus", false);
        }

        view.forward(request, response);
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
