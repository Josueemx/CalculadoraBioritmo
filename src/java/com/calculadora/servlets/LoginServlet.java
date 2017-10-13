/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calculadora.servlets;

import com.calculadora.classes.DbHelper;
import com.calculadora.classes.Person;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.jboss.weld.servlet.SessionHolder;

/**
 *
 * @author Morales
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    /*
    PrintWriter out = response.getWriter()
    out.println("<!DOCTYPE html>");
    */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();    
        session.setAttribute("logged_in", "false");
        try {    
            String email = request.getParameter("email");
            String password = request.getParameter("contrasena");
            if(password.equals("") || password == "" || email.equals("") || email == ""){
                request.getRequestDispatcher("Login.jsp?message=10").forward(request, response);
                return;
            }
            DbHelper dbHelper = new DbHelper();
            if(!dbHelper.emailExists(email)){
                dbHelper.endConnection();
                request.getRequestDispatcher("Login.jsp?message=11").forward(request, response);
                return;
            }
            Person p = dbHelper.getPersonByEmail(email);
            if(!password.equals(p.getPassword())){
                dbHelper.endConnection();
                request.getRequestDispatcher("Login.jsp?message=12").forward(request, response);
                return;
            }
            session.setAttribute("logged_in", "true");
            session.setAttribute("person", p);
            request.getRequestDispatcher("Calculadora.jsp").forward(request, response);
        } 
        catch (Exception ex) {
            out.println("<!DOCTYPE html>");
            out.println("<html><h1>Ocurrio un error en el servidor: "+ex.getMessage()+"</h1></html>");
            Logger.getLogger(Request.class.getName()).log(Level.SEVERE, null, ex);
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
