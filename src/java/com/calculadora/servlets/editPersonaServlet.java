/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calculadora.servlets;

import com.calculadora.classes.Person;
import com.calculadora.classes.Biorritmo;
import com.calculadora.classes.DbHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Morales
 */
public class editPersonaServlet extends HttpServlet {

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
            String email = request.getParameter("email");
            String password = request.getParameter("contrasena");
            String n_password = request.getParameter("n-contrasena");
            String c_password = request.getParameter("c-contrasena");
            String send_email = request.getParameter("send_email")==null? "false": "true";
            int id = Integer.parseInt(request.getParameter("id"));
            
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
                request.getRequestDispatcher("Calculadora.jsp?message=3%").forward(request, response);
                return;
            } 
            if(email.equals("") || email == ""){
                request.getRequestDispatcher("Calculadora.jsp?message=4").forward(request, response);
                return;
            } 
            /*
                NOTA
                Cuenta continua en deletePersonaServlet
            */
            if(password.equals("") || password == ""){
                request.getRequestDispatcher("Calculadora.jsp?message=7").forward(request, response);
                return;
            }
            if(n_password.equals("") || n_password == ""){
                request.getRequestDispatcher("Calculadora.jsp?message=14").forward(request, response);
                return;
            }
            if(!n_password.equals(c_password)){
                request.getRequestDispatcher("Calculadora.jsp?message=8").forward(request, response);
                return;
            }
            HttpSession session = request.getSession();   
            Person p_s = (Person) session.getAttribute("person");
            DbHelper dbHelper = new DbHelper();
            if(dbHelper.emailExists(email)){
                if(!p_s.getEmail().equals(email)){
                    request.getRequestDispatcher("Calculadora.jsp?message=9").forward(request, response);
                    return;
                }
            }
            if(!p_s.getPassword().equals(password)){
                request.getRequestDispatcher("Calculadora.jsp?message=12").forward(request, response);
                return;
            }
            Person p = dbHelper.updatePersonById(id, name, email, birthday, final_day, n_password);
            session.setAttribute("person", p);
            if(Boolean.parseBoolean(send_email)){
                p.sendEmail();
                request.getRequestDispatcher("Calculadora.jsp?message=6&email="+email).forward(request, response);
            }
            else{
                request.getRequestDispatcher("Calculadora.jsp?message=15").forward(request, response);
            }
            dbHelper.endConnection();
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
