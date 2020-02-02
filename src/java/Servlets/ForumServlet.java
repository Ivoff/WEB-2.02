/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Entities.Forum;
import Entities.User;
import Repository.Implementation.ForumRepository;
import Repository.Implementation.UserRepository;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "ForumServlet", urlPatterns = {"/forum"})
@MultipartConfig(location = "/", fileSizeThreshold = 1024 * 1024 * 10, maxFileSize = 1024 * 1024 * 100, maxRequestSize = 1024 * 1024 * 100 * 5)
public class ForumServlet extends HttpServlet {

    @Inject
    ForumRepository forumRepo;

    @Inject
    UserRepository userRepo;

    private String getRequestFileExtension(String fileName) {
        int i = fileName.length() - 1;
        StringBuilder extension = new StringBuilder();
        while (fileName.charAt(i) != '.') {
            extension.append(fileName.charAt(i));
            i -= 1;
        }
        extension.reverse();
        return ("." + extension.toString());
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("mode") != null) {
            User user = new User();
            Forum forum = new Forum();
            if (request.getParameter("mode").equals("create")) {
                RequestDispatcher view = request.getRequestDispatcher("/views/forum/create.jsp");

                if (request.getParameter("action") != null) {
                    if (request.getParameter("action").equals("edit")) {
                        request.setAttribute("edit", true);
                        forum = (Forum) forumRepo.read(Integer.valueOf(request.getParameter("id")));
                        request.setAttribute("current_forum", forum);
                    }
                }

                if (request.getParameter("form_flag") != null) {                    
                    
                    if (Integer.valueOf(request.getParameter("forum_id")) != 0) {
                        if (request.getPart("forum_icon").getSubmittedFileName().equals("")) {
                            forum.setImagePath(forumRepo.read(Integer.valueOf(request.getParameter("forum_id")))
                                    .getImagePath());
                        }

                    } else {

                        String uploadPath = getServletContext().getRealPath("").replace(File.separator + "build" + File.separator + "web", File.separator + "web" + File.separator + "resources" + File.separator + "storage" + File.separator + "forum_icons");
                        String fileName = (BCrypt.hashpw(request.getPart("forum_icon").getSubmittedFileName(), BCrypt.gensalt()) + getRequestFileExtension(request.getPart("forum_icon").getSubmittedFileName())).replace("/", "|");
                        File uploadDir = new File(uploadPath);

                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        File file = new File(uploadPath + File.separator + fileName);
                        file.createNewFile();
                        Part fileIcon = request.getPart("forum_icon");
                        fileIcon.write(uploadPath + File.separator + fileName);
                        forum.setId(Integer.valueOf(request.getParameter("forum_id")));
                        forum.setImagePath("/WEB-2.01/resources/storage/forum_icons" + File.separator + fileName);
                        forum.setName(request.getParameter("forum_name").trim());
                        forum.setDescription(request.getParameter("forum_description"));

                        if (userRepo.read(request.getParameter("forum_owner")) != null) {
                            forum.setCreatedBy(userRepo.read(request.getParameter("forum_owner")));
                            forumRepo.save(forum);
                            request.setAttribute("status", true);
                        } else {
                            request.setAttribute("status", false);
                        }
                    }
                }

                view.forward(request, response);
            }
        } else {
            RequestDispatcher view = request.getRequestDispatcher("views/forum/index.jsp");

            if (request.getParameter("action") != null) {
                if (request.getParameter("action").equals("delete")) {
                    forumRepo.delete(forumRepo.read(Integer.valueOf(request.getParameter("id"))));
                }
            }

            if (request.getParameter("order") != null) {
                if (request.getParameter("order").equals("newer")) {
                    request.setAttribute("forums", (List<Forum>) forumRepo.all("desc"));
                } else if (request.getParameter("order").equals("older")) {
                    request.setAttribute("forums", (List<Forum>) forumRepo.all("asc"));
                } else {
                    request.setAttribute("forums", (List<Forum>) forumRepo.all());
                }
            } else {
                request.setAttribute("forums", (List<Forum>) forumRepo.all());
            }

            request.setAttribute("forums_recently", (List<Forum>) forumRepo.all("desc limit 6"));

            view.forward(request, response);
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
