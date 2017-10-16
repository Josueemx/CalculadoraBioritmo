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
        <h3>Resultados de Biorritmo para <span id="person_name"></span></h3>
        <hr>
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <td>Correo</td>
                    <td>
                        <span id="person_email"></span>
                    </td>
                </tr>
                <tr>
                    <td>Cumpleaños</td>
                    <td>
                        <span id="person_birthday"></span>
                    </td>
                </tr>
                <tr>
                    <td>Fecha fin</td>
                    <td>
                        <span id="person_final_day"></span>
                    </td>
                </tr>
                <tr>
                    <td>Dias vividos a la fecha de calculo</td>
                    <td>
                        <span id="person_days"></span>
                    </td>
                </tr>
                <tr>
                    <td>Dias del Ciclo fisico (23)</td>
                    <td id="person_physicalcolor">
                        <span id="person_physicalcycle"></span>
                    </td>
                </tr>
                <tr>
                    <td>Dias del Ciclo Emocional (28)</td>
                    <td id="person_emotionalcolor">                        
                        <span id="person_emotionalcycle"></span>
                    </td>
                </tr>
                <tr>
                    <td>Dias del Ciclo Intelectual (33)</td>
                    <td id="person_intelectualcolor">
                        <span id="person_intelectualcycle"></span>
                    </td>
                </tr>
            </tbody>
        </table>
        <a type="button" class="btn btn-info" data-dismiss="modal" data-toggle="modal" data-target="#person_modal">Editar</a>
        <div id="person_modal" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <form action="editPersonaServlet" method="post" accept-charset="UTF-8">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title"><span id="person_name2"></span></h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <%if(session.getAttribute("person_id")!=null)
                            out.print("<input type=\"hidden\" name=\"id\" id=\"id\" value=\""+(String)session.getAttribute("person_id")+"\">");
                        %>
                        <input type="text" class="form-control" name="name" id="name" title="haz click para editar el nombre" placeholder="Nombre">
                    </div>
                    <div class="form-group">
                        <input type="email" class="form-control" name="email" id="email" title="haz click para editar el correo electrónico" placeholder="Correo" >
                    </div>
                    <div class="form-group">               
                        <div class="input-group input-daterange">
                            <div class="input-group-addon">de</div>
                            <input type="text" class="form-control" title="haz click para editar fecha de nacimiento" placeholder="dia de nacimiento" readonly="true" name="birthday" id="birthday">
                            <div class="input-group-addon">hasta</div>
                            <input type="text" class="form-control" title="haz click para editar fecha final" readonly="true" name="final_day" id="final_day" >
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="password" name="contrasena" id="contrasena" class="form-control" placeholder="Contraseña actual">
                    </div>
                    <div class="form-group">
                        <input type="password" name="n-contrasena" id="n-contrasena" class="form-control" placeholder="Contraseña nueva">
                    </div>
                    <div class="form-group">
                        <input type="password" name="c-contrasena" id="c-contrasena" class="form-control" placeholder="Confirmar contraseña">
                    </div>
                    <div class="form-group">
                        <label for="send_email" >Enviar correo:&nbsp;&nbsp;<input type="checkbox" name="send_email" id="send_email" value="send_email"></label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="Update">Actualizar</button>
                </div>
                </form>
              </div>
            </div>
        </div>
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

<script type="text/javascript">
    
    $(document).ready(function() {
        $.ajax({ 
            type: 'GET', 
            url: 'http://localhost:8080/CalculadoraBioritmo/UpdatePersonaServlet',
            
            data:   {ID: <%if(session.getAttribute("person_id")!=null)
                            out.print((String)session.getAttribute("person_id"));
                        %>},
            dataType: 'json',
            success: function(result){
                setValues(result);
            }
        });
    });
    
    /*$("#Update").click(function() {
        $.ajax({ 
            type: 'POST', 
            url: 'http://localhost:8080/CalculadoraBioritmo/editPersonaServlet',
            data:  {id: $('#id').val(),
                    name: $('#name').val(),
                    email: $('#email').val(),
                    birthday: $('#birthday').val(),
                    final_day: $('#final_day').val(),
                    contrasena: $('#contrasena').val(),
                    ncontrasena: $('#n-contrasena').val(),
                    ccontrasena: $('#c-contrasena').val(),
                    send_email: $('#send_email').val()
                    },
            dataType: 'json',
            success: function(result){
                setValues(result);
            }
        });
    });*/
    
    function setValues(person) {      
        //Resultados
        $('#person_name').text(person.Name);
        $('#person_email').text(person.Email);
        $('#person_birthday').text(person.Birthday);
        $('#person_final_day').text(person.Final_day);
        $('#person_days').text(person.days);
        $('#person_physicalcycle').text(person.physicalcycle);
        $('#person_emotionalcycle').text(person.emotionalcycle);
        $('#person_intelectualcycle').text(person.intelectualcycle);

        //Clases
        $('#person_physicalcolor').removeClass('red yellow green');
        $('#person_physicalcolor').addClass(person.physicalcolor);
        $('#person_emotionalcolor').removeClass('red yellow green');
        $('#person_emotionalcolor').addClass(person.emotionalcolor);
        $('#person_intelectualcolor').removeClass('red yellow green');
        $('#person_intelectualcolor').addClass(person.intelecualcolor);

        //Modal
        $('#id').val(person.ID);
        $('#person_name2').text(person.Name);
        $('#name').val(person.Name);
        $('#email').val(person.Email);
        $('#birthday').val(person.Birthday);
        $('#final_day').val(person.Final_day);
    }
</script>

<%@ include file = "footer.jsp"%>
