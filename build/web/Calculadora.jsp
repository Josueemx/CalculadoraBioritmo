<%-- 
    Document   : Calculadora
    Created on : 26-jul-2017, 12:59:07
    Author     : Morales
--%>

<%  
    if(session.getAttribute("logged_in")!=null){
        if(!Boolean.valueOf((String) session.getAttribute("logged_in")))
            request.getRequestDispatcher("Login.jsp?message=13").forward(request, response);
    }
    else{
        request.getRequestDispatcher("Login.jsp?message=13").forward(request, response);
    }
%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.AbstractList"%>
<%@page import="com.calculadora.classes.DbHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.calculadora.classes.Person"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file = "navbar.jsp"%>

<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
      
    </div>
    <div class="col-sm-8 text-left">        
            <% 
                if(session.getAttribute("person")!=null){
                    Person person = (Person) session.getAttribute("person");
                    String key2 = "_p";
                    out.println(
                        "<h3>Resultados de Biorritmo para "+person.getName()+"</h3>" +
                        "<hr>"+
                        //tabla
                        "<table class=\"table table-bordered\">" +
                            "<tbody>" +
                                "<tr>" +
                                    "<td>Correo</td>" +
                                    "<td>" +
                                        person.getEmail() +
                                    "</td>" +
                                "</tr>"+
                                "<tr>" +
                                    "<td>Cumpleaños</td>" +
                                    "<td>" +
                                        person.getBirthday() +
                                    "</td>" +
                                "</tr>"+
                                "<tr>" +
                                    "<td>Fecha fin" +
                                    "<td>" +
                                        person.getBio().getFinal_daystr() +
                                    "</td>" +
                                "</tr>"+
                                "<tr>" +
                                    "<td>Dias vividos a la fecha de calculo</td>" +
                                    "<td>" +
                                        person.getBio().getDays() +
                                    "</td>" +
                                "</tr>"+
                                "<tr>"+
                                    "<td>Dias del Ciclo fisico (23)</td>" +
                                    "<td style=\"background: "+person.getBio().getPhysicalColor()+"\">" +
                                        person.getBio().getPhysicalCycle() +
                                    "</td>" +
                                "</tr>" +
                                "<tr>" +
                                    "<td>Dias del Ciclo Emocional (28)</td>" +
                                    "<td style=\"background: "+person.getBio().getEmotionalColor()+"\">" +                        
                                        person.getBio().getEmotionalCycle() +
                                    "</td>" +
                                "</tr>" +
                                "<tr>" +
                                    "<td>Dias del Ciclo Intelectual (33)</td>"+
                                    "<td style=\"background: "+person.getBio().getIntelectualColor()+"\">" +
                                        person.getBio().getIntelectualCycle() +
                                    "</td>" +
                                "</tr>" +
                            "</tbody>" +
                        "</table>" +
                        "<a type=\"button\" class=\"btn btn-info\" data-dismiss=\"modal\" data-toggle=\"modal\" data-target=\"#"+person.getID()+key2+"\">Editar</a>" +
                        //"<a type=\"button\" href=\"deletePersonaServlet?id="+person.getID()+"\" class=\"btn btn-danger\">Eliminar</a>" +        

                    //modal 1
                    "<div id=\""+person.getID()+key2+"\" class=\"modal fade\" role=\"dialog\">" +
                    "<div class=\"modal-dialog\">" +
                      "<div class=\"modal-content\">" +
                        "<form action=\"editPersonaServlet\" method=\"post\" accept-charset=\"UTF-8\">"+
                        "<div class=\"modal-header\">" +
                          "<button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>" +
                          "<h4 class=\"modal-title\">"+person.getName()+"</h4>" +
                        "</div>" +
                        "<div class=\"modal-body\">"+
                            "<div class=\"form-group\">"+
                                "<input type=\"hidden\" name=\"id\" value=\""+person.getID()+"\">" +
                                "<input type=\"text\" class=\"form-control\" name=\"name\" title=\"haz click para editar el nombre\" placeholder=\"Nombre\" value=\""+person.getName()+"\">" +
                            "</div>" +
                            "<div class=\"form-group\">" +
                                "<input type=\"email\" class=\"form-control\" name=\"email\" title=\"haz click para editar el correo electrónico\" placeholder=\"Correo\" value=\""+person.getEmail()+"\">" +
                            "</div>" +
                            "<div class=\"form-group\">" +                
                                "<div class=\"input-group input-daterange\">" +
                                    "<div class=\"input-group-addon\">de</div>" +
                                    "<input type=\"text\" class=\"form-control\" title=\"haz click para editar fecha de nacimiento\" placeholder=\"dia de nacimiento\" readonly=\"true\" name=\"birthday\" value=\""+person.getBirthday()+"\">" +
                                    "<div class=\"input-group-addon\">hasta</div>" +
                                    "<input type=\"text\" class=\"form-control\" title=\"haz click para editar fecha final\" readonly=\"true\" name=\"final_day\" id=\"final_day\" value=\""+person.getBio().getFinal_daystr()+"\">" +
                                "</div>" +
                            "</div>" +
                            "<div class=\"form-group\">" +
                                "<input type=\"password\" name=\"contrasena\" id=\"password\" class=\"form-control\" placeholder=\"Contraseña actual\">"+
                            "</div>"+
                            "<div class=\"form-group\">" +
                                "<input type=\"password\" name=\"n-contrasena\" id=\"password\" class=\"form-control\" placeholder=\"Contraseña nueva\">"+
                            "</div>"+
                            "<div class=\"form-group\">" +
                                "<input type=\"password\" name=\"c-contrasena\" id=\"password\" class=\"form-control\" placeholder=\"Confirmar contraseña\">"+
                            "</div>"+
                            "<div class=\"form-group\">" +
                                "<label for=\"send_email\" >Enviar correo:&nbsp;&nbsp;<input type=\"checkbox\" name=\"send_email\" id=\"send_email\" value=\"send_email\"></label>"+
                            "</div>"+
                       " </div>" +
                        "<div class=\"modal-footer\">" +
                            "<button type=\"submit\" class=\"btn btn-primary\">Actualizar</button>" +
                        "</div>" +
                        "</form>"+
                      "</div>" +
                    "</div>" +
                    "</div>"
                    );
                }
            %>
    </div>
    <div class="col-sm-2 sidenav">
    </div>
  </div>
</div>
                    
<script type="text/javascript">
    var counter = 0;
    $('.input-daterange input').each(function() {
        counter++;
        $(this).datepicker({
            format: 'dd/mm/yyyy',
            autoclose: 'true'
        });
        $(this).datepicker('update');
    });
</script> 
         

<%@ include file = "footer.jsp"%>
