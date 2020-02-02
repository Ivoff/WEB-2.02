/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Entities.Comment;
import Entities.Post;
import Entities.User;
import Entities.Vote;
import Repository.Implementation.CommentRepository;
import Repository.Implementation.PostRepository;
import Repository.Implementation.UserRepository;
import Repository.Implementation.VoteRepository;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import resources.Utils;

/**
 *
 * @author zilas
 */
@WebServlet(name = "JsonServlet", urlPatterns = {"/json"})
public class JsonServlet extends HttpServlet {

    @Inject
    UserRepository userRepo;

    @Inject
    PostRepository postRepo;

    @Inject
    VoteRepository voteRepo;

    @Inject
    @Qualifier.CommentRepository
    CommentRepository commentRepo;

    private void deleteReverseCasade(Comment comment) {
        commentRepo.delete(comment);
        System.out.println(comment.getParent().getChildren().size());
        if (comment.getParent().getChildren().size() == 1 && comment.getParent().getUser() == null) {
            deleteReverseCasade(comment.getParent());
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        if (request.getParameter("user") != null && request.getParameter("post") == null && request.getParameter("vote") == null) {
            User user = userRepo.read(request.getParameter("user"));
            String result;
            if (user == null) {
                result = new Gson().toJson(user);
            } else {
                result = new Gson().toJson(Utils.jsonSerializer(user));
            }

            out.print(result);
            out.flush();

        } else if (request.getParameter("post") != null && request.getParameter("vote") != null && request.getParameter("user") != null) {
            Post post = postRepo.read(Integer.valueOf(request.getParameter("post")));
            User user = userRepo.read(request.getParameter("user"));

            Vote vote = new Vote();
            vote.setPost(post);
            vote.setUser(user);
            vote.setVote(Integer.valueOf(request.getParameter("vote")));
            voteRepo.vote(vote);
        } else if (request.getParameter("comment") != null) {

            if (request.getParameter("erase") != null) {
                Comment comment = commentRepo.read(Integer.valueOf(request.getParameter("comment")));
                comment.setBody("<p class=\"text-monospace font-weight-bold text-white\">deleted comment</p>");
                comment.setUser(null);
                commentRepo.save(comment);
            } else {
                Post post = postRepo.read(Integer.valueOf(request.getParameter("post")));
                User user = userRepo.read(request.getParameter("user"));

                Comment comment = new Comment();
                comment.setPost(post);
                comment.setUser(user);

                if (!request.getParameter("parent").equals("")) {
                    comment.setParent(commentRepo.read(Integer.valueOf(request.getParameter("parent"))));
                    comment.getParent().getChildren().add(comment);

                } else {
                    comment.setParent(null);
                }

                comment.setBody(request.getParameter("comment"));
//            commentRepo.save(comment.getParent());
                commentRepo.save(comment);
            }
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
