/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calculadora.servlets;

import com.calculadora.classes.Biorritmo;
import com.calculadora.classes.DbHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Morales
 */
public class Request extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            response.setContentType("text/html;charset=UTF-8");
            String birthday = request.getParameter("birthday");
            String final_day = request.getParameter("final_day");
            String name = request.getParameter("name");
            if(birthday.equals("") || final_day.equals("")){ 
                request.getRequestDispatcher("Calculadora.jsp?message=1").forward(request, response);
                return;
            }
            Biorritmo bio = new Biorritmo(birthday, final_day);
            if(bio.getBirthday().getTime()>=bio.getFinal_day().getTime()){
                request.getRequestDispatcher("Calculadora.jsp?message=2").forward(request, response);
                return;
            }
            if(name.equals("") || name == ""){
                request.getRequestDispatcher("Calculadora.jsp?message=3").forward(request, response);
                return;
            }            
            request.getRequestDispatcher("Calculadora.jsp?message=0").forward(request, response);
        } catch (Exception ex) {
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
