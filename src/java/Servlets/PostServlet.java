/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Entities.Forum;
import Entities.Post;
import Entities.PostBody;
import Entities.User;
import Repository.Implementation.ForumRepository;
import Repository.Implementation.PostBodyRepository;
import Repository.Implementation.PostRepository;
import Repository.Implementation.UserRepository;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.mindrot.jbcrypt.BCrypt;
import resources.Utils;

/**
 *
 * @author zilas
 */
@WebServlet(name = "", urlPatterns = {"/post"})
@MultipartConfig(location = "/", fileSizeThreshold = 1024 * 1024 * 10, maxFileSize = 1024 * 1024 * 100, maxRequestSize = 1024 * 1024 * 100 * 5)
public class PostServlet extends HttpServlet {

    @Inject
    ForumRepository forumRepo;

    @Inject
    UserRepository userRepo;

    @Inject
    PostRepository postRepo;

    @Inject
    PostBodyRepository postBodyRepo;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        RequestDispatcher view = request.getRequestDispatcher("/views/post/post.jsp");

        User user = new User();
        Forum forum = new Forum();
        Post post = new Post();
        PostBody postBody = new PostBody();

        if (request.getParameter("mode") != null) {
            if (request.getParameter("mode").equals("create")) {
                view = request.getRequestDispatcher("/views/post/create.jsp");

                if (request.getParameter("action") != null) {
                    if (request.getParameter("action").equals("edit")) {
                        request.setAttribute("post", postRepo.read(Integer.valueOf(request.getParameter("id"))));
                    }

                    if (request.getParameter("form_flag") != null) {
                        post.setId(Integer.valueOf(request.getParameter("post_id")));
                        post.setTitle(request.getParameter("post_title"));
                        post.setCreatedBy(userRepo.read(request.getParameter("post_creator")));
                        post.setForum(forumRepo.read(request.getParameter("post_forum")));

                        postBody.setId(Integer.valueOf(request.getParameter("post_body_id")));
                        postBody.setType(Integer.valueOf(request.getParameter("post_type")));

                        if (postBody.getType() == 1) {
                            String uploadPath = getServletContext().getRealPath("").replace(File.separator + "build" + File.separator + "web", File.separator + "web" + File.separator + "resources" + File.separator + "storage" + File.separator + "posts_images");
                            String fileName = (BCrypt.hashpw(request.getPart("post_image").getSubmittedFileName(), BCrypt.gensalt()) + Utils.getRequestFileExtension(request.getPart("post_image").getSubmittedFileName())).replace("/", "|");
                            File uploadDir = new File(uploadPath);

                            if (!uploadDir.exists()) {
                                uploadDir.mkdirs();
                            }

                            File file = new File(uploadPath + File.separator + fileName);
                            file.createNewFile();
                            Part fileIcon = request.getPart("post_image");
                            fileIcon.write(uploadPath + File.separator + fileName);
                            postBody.setContent("/WEB-2.01/resources/storage/posts_images" + File.separator + fileName);
                            postBody.setType(1);

                        } else {
                            postBody.setContent(request.getParameter("post_content"));
                            postBody.setType(0);
                        }
                        postBody.setPost(post);
                        postBodyRepo.save(postBody);

                        post.setBody(postBody);
                        postRepo.save(post);
                    }
                }
            }
        } else {
            
            if(request.getParameter("action") != null && request.getParameter("action").equals("delete")){
                postRepo.delete(postRepo.read(Integer.valueOf(request.getParameter("id"))));
            }
            
            if (request.getParameter("order") != null) {
                if (request.getParameter("order").equals("newer")) {
                    request.setAttribute("posts", postRepo.all("desc", 0));
                } else if (request.getParameter("order").equals("older")) {
                    request.setAttribute("posts", postRepo.all("asc", 0));
                } else {
                    request.setAttribute("posts", postRepo.all());
                }
            } else {
                request.setAttribute("posts", postRepo.all());
            }
            request.setAttribute("posts_recently", postRepo.all("desc", 6));
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
