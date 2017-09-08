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
                    try{
                        DbHelper dbHelper = new DbHelper();
                        sheeple = dbHelper.getAllSheeple();
                        for(Person person : sheeple) {
                            out.println("<tr style=\"cursor: pointer;\" data-toggle=\"modal\" data-target=\"#"+person.getID()+key+"\" ><td><h4>"+person.getName()+"</h4></td></tr>");//aqui falta lo del anchor
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
                          "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button>" +
                        "</div>" +
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

<c:choose>
    <c:when test="${param.message == 1}">
        <script type="text/javascript">
            alert("Los datos introducidos no son validos.");
        </script>
    </c:when>
    <c:when test="${param.message == 2}">
        <script type="text/javascript">
            alert("La fecha final no puede ser mayor o igual que la primera.");
        </script>
    </c:when>
    <c:when test="${param.message == 3}">
        <script type="text/javascript">
            alert("El nombre no puede estar vacio.");
        </script>
    </c:when>
</c:choose>
        
<%@ include file = "footer.jsp"%>
