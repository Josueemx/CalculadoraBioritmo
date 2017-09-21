<%-- 
    Document   : Calculadora
    Created on : 26-jul-2017, 12:59:07
    Author     : Morales
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.AbstractList"%>
<%@page import="com.calculadora.classes.DbHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.calculadora.classes.Person"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file = "header.jsp"%>

<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
      
    </div>
    <div class="col-sm-8 text-left"> 
        <h3>Introduce tus datos</h3>
        <form action="Request" method="post">
            <div class="form-group">
                <label for="usr">Nombre</label>
                <input type="text" class="form-control" name="name" title="haz click para editar el nombre" placeholder="nombre">
            </div>
            <div class="form-group">
                <label for="usr">Correo</label>
                <input type="text" class="form-control" name="email" title="haz click para editar el correo electrónico" placeholder="correo">
            </div>
            <div class="form-group">                
                <div class="input-group input-daterange">
                    <div class="input-group-addon">de</div>
                    <input type="text" class="form-control" title="haz click para editar fecha de nacimiento" placeholder="dia de nacimiento" readonly="true" name="birthday">
                    <div class="input-group-addon">hasta</div>
                    <input type="text" class="form-control" title="haz click para editar fecha final" readonly="true" name="final_day" id="final_day">
                </div>                
            </div>
            <input class="btn btn-default pull-right" type="submit" value="Registrar">
            <br>
            <br>
        </form>
        <hr>        
        <h3>Lista de personas registradas</h3>
        <table class="table table-bordered table-hover text-center"> <!-- aqui se itera sobre nombres -->
            <tbody>
                <%  
                    List<Person> sheeple = new ArrayList<Person>();
                    String key = "_p";
                    String key2 = "_p2";
                    try{
                        DbHelper dbHelper = new DbHelper();
                        sheeple = dbHelper.getAllSheeple();
                        for(Person person : sheeple) {
                            out.println("<tr style=\"cursor: pointer;\" data-toggle=\"modal\" data-target=\"#"+person.getID()+key+"\" ><td><h4>"+person.getName()+"</h4></td></tr>");
                        }
                        dbHelper.endConnection();
                    }
                    catch (Exception e) {
                        out.println("<script type=\"text/javascript\">alert(\"Error en la base de datos: "+e.getMessage()+".\");</script>");
                    }
                %>
            </tbody>
        </table>
            <% 
                for(Person person : sheeple) {
                    out.println(
                    //modal 1
                    "<div id=\""+person.getID()+key+"\" class=\"modal fade\" role=\"dialog\">" +
                    "<div class=\"modal-dialog\">" +

                      "<!-- Modal content-->"+
                      "<div class=\"modal-content\">" +
                        "<div class=\"modal-header\">" +
                          "<button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>" +
                          "<h4 class=\"modal-title\">"+person.getName()+"</h4>" +
                        "</div>" +
                        "<div class=\"modal-body\">"+
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
                       " </div>" +
                        "<div class=\"modal-footer\">" +
                            "<a type=\"button\" class=\"btn btn-info\" data-dismiss=\"modal\" data-toggle=\"modal\" data-target=\"#"+person.getID()+key2+"\">Editar</a>" +
                            "<a type=\"button\" href=\"deletePersonaServlet?id="+person.getID()+"\" class=\"btn btn-danger\">Eliminar</a>" +
                        "</div>" +
                      "</div>" +
                    "</div>" +
                    "</div>"+
                            
                    //modal 2
                    "<div id=\""+person.getID()+key2+"\" class=\"modal fade\" role=\"dialog\">" +
                    "<div class=\"modal-dialog\">" +
                      "<div class=\"modal-content\">" +
                        "<form action=\"editPersonaServlet\" method=\"post\">"+
                        "<div class=\"modal-header\">" +
                          "<button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>" +
                          "<h4 class=\"modal-title\">"+person.getName()+"</h4>" +
                        "</div>" +
                        "<div class=\"modal-body\">"+
                            "<div class=\"form-group\">"+
                                "<input type=\"hidden\" name=\"id\" value=\""+person.getID()+"\">" +
                                "<label for=\"usr\">Nombre</label>"+
                                "<input type=\"text\" class=\"form-control\" name=\"name\" title=\"haz click para editar el nombre\" placeholder=\"nombre\" value=\""+person.getName()+"\">" +
                            "</div>" +
                            "<div class=\"form-group\">" +
                                "<label for=\"usr\">Correo</label>" +
                                "<input type=\"text\" class=\"form-control\" name=\"email\" title=\"haz click para editar el correo electrónico\" placeholder=\"correo\" value=\""+person.getEmail()+"\">" +
                            "</div>" +
                            "<div class=\"form-group\">" +                
                                "<div class=\"input-group input-daterange\">" +
                                    "<div class=\"input-group-addon\">de</div>" +
                                    "<input type=\"text\" class=\"form-control\" title=\"haz click para editar fecha de nacimiento\" placeholder=\"dia de nacimiento\" readonly=\"true\" name=\"birthday\" value=\""+person.getBirthday()+"\">" +
                                    "<div class=\"input-group-addon\">hasta</div>" +
                                    "<input type=\"text\" class=\"form-control\" title=\"haz click para editar fecha final\" readonly=\"true\" name=\"final_day\" id=\"final_day\" value=\""+person.getBio().getFinal_daystr()+"\">" +
                                "</div>" +
                            "</div>" +
                            //falta boton aqui o en el footer
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
        if(counter==2){
            $(this).datepicker("setDate", new Date());
        }
        $(this).datepicker('update');
    });
</script> 

<script type="text/javascript" async>
<c:choose>
        <c:when test="${param.message == 1}">
            alert("Los datos introducidos no son validos.");
        </c:when>
        <c:when test="${param.message == 2}">
            alert("La fecha final no puede ser mayor o igual que la primera.");
        </c:when>
        <c:when test="${param.message == 3}">
            alert("El nombre no puede estar vacio.");
        </c:when>
        <c:when test="${param.message == 4}">
            alert("El correo no puede estar vacio.");
        </c:when>
        <c:when test="${param.message == 5}">
            alert("Se eliminó \"${param.name}\" correctamente.");
        </c:when>
        <c:when test="${param.message == 6}">
            alert("Se envió un correo a \"${param.email}\" con los resultados.");
        </c:when>
</c:choose>
</script>
    

        
<%@ include file = "footer.jsp"%>
