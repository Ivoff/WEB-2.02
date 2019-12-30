package Servlets.User;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Entities.User;
import Repository.Implementation.UserRepository;
import Repository.Repository;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.OffsetDateTime;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author zilas
 */
@WebServlet(urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User();
        UserRepository repo = new UserRepository();        
        RequestDispatcher view = request.getRequestDispatcher("user.jsp");
        
        if(request.getParameter("flag") != null){
            if(request.getParameter("input_password").equals(request.getParameter("input_confirm"))){
                user.setHashPass(request.getParameter("input_password"));
            }else{
                request.setAttribute("error", "Missmatched passwords");
                request.setAttribute("all", repo.all());
                view.forward(request, response);
            }
            user.setName(request.getParameter("input_name"));
            user.setEmail(request.getParameter("input_email"));
            try{
                user.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("input_birthday")));
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            if(request.getParameter("flag").equals("insertion")){
                user.setId(0);
                user.setCreatedAt(OffsetDateTime.now());
                user.setUpdatedAt(OffsetDateTime.now());
            }
            else{
                user.setId(Integer.parseInt(request.getParameter("user_id")));
                User aux = (User) repo.read(user.getId());
                user.setCreatedAt(aux.getCreatedAt());
                user.setUpdatedAt(OffsetDateTime.now());
            }            
            repo.save(user);
            request.setAttribute("success", "Successfully saved");            
        }else if(request.getParameter("edit") != null){
            user = (User) repo.read(Integer.parseInt(request.getParameter("edit")));
            request.setAttribute("selected_user", user);
        }else if(request.getParameter("destroy") != null){
            user = (User) repo.read(Integer.parseInt(request.getParameter("destroy")));
            request.setAttribute("dashboard", "not_null");
            repo.delete(user);
        }else if(request.getParameter("login") != null){            
            if(repo.testUser(request.getParameter("user_email"), request.getParameter("user_pass"))){
                request.setAttribute("status", "OK");
                request.setAttribute("all", repo.all());
                request.setAttribute("test", "true");
                view.forward(request, response);
            }else{                
                request.setAttribute("status", "NOT-OK");
                request.setAttribute("all", repo.all());
                request.setAttribute("test", "true");
                view.forward(request, response);
            }
        }else if(request.getParameter("logout") != null){
            request.setAttribute("all", repo.all());
            request.setAttribute("test", "true");
            view.forward(request, response);
        }else if(request.getParameter("search") != null){
            List<User> queryList = repo.search(request.getParameter("query"));
            request.setAttribute("all", queryList);
            request.setAttribute("dashboard", "not_null");
            view.forward(request, response);
        }else if(request.getParameter("reset") != null){
            request.setAttribute("all", repo.all());
            request.setAttribute("dashboard", "not_null");
            view.forward(request, response);
        }
        request.setAttribute("all", repo.all());
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
