/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Entities.User;
import Repository.Implementation.UserRepository;
import java.io.IOException;
import java.io.PrintWriter;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author zilas
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {   
    
    @Inject
    private UserRepository userRepo;   
    
    @Inject
    private User user;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        
                
        RequestDispatcher view = request.getRequestDispatcher("login.jsp");
        
        if(request.getParameter("login_flag") != null)
        {            
            if(userRepo.testUser(request.getParameter("email_login"), request.getParameter("password_login")))
            {   
                user = userRepo.read(request.getParameter("email_login").trim());
                
                HttpSession session = request.getSession();
                session.setAttribute("session_id", session.getId());
                session.setAttribute("user", user);
                
                response.sendRedirect("profile");
                return;
            }            
            request.setAttribute("status", false);                            
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
