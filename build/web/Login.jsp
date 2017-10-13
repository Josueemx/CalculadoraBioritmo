<%-- 
    Document   : Calculadora
    Created on : 26-jul-2017, 12:59:07
    Author     : Morales
--%>

<%  
    if(session.getAttribute("logged_in")!=null){
        if(Boolean.valueOf((String) session.getAttribute("logged_in")))
            request.getRequestDispatcher("Calculadora.jsp").forward(request, response);
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


<%@ include file = "header.jsp"%>

<div class="container-fluid text-center">    
  <div class="row">
    <div class="col-md-6 col-md-offset-3">
        <div class="panel-padding-top panel-padding-bottom-first" id="panel-padding"> 
            <div class="panel panel-login">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-6">
                                    <a href="#" class="active" id="login-form-link">Iniciar sesión</a>
                            </div>
                            <div class="col-xs-6">
                                    <a href="#" id="register-form-link">Registrarse</a>
                            </div>
                        </div>
                        <hr>
                    </div>
                    <div class="panel-body">
                            <div class="row">
                                    <div class="col-lg-12">
                                            <form id="login-form" action="LoginServlet" method="post" role="form" style="display: block;">
                                                    <div class="form-group">
                                                            <input type="text" name="email" id="username" tabindex="1" class="form-control" placeholder="Username" value="">
                                                    </div>
                                                    <div class="form-group">
                                                            <input type="password" name="contrasena" id="password" tabindex="2" class="form-control" placeholder="Password">
                                                    </div>
                                                    <div class="form-group">
                                                            <div class="row">
                                                                    <div class="col-sm-6 col-sm-offset-3">
                                                                            <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Iniciar sesión">
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </form>
                                            <form id="register-form" action="Request" method="post" role="form" style="display: none;">
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" name="name" title="haz click para editar el nombre" placeholder="Nombre">
                                                    </div>
                                                    <div class="form-group">
                                                        <input type="email" class="form-control" name="email" title="haz click para editar el correo electrónico" placeholder="Correo">
                                                    </div>
                                                    <div class="form-group">                
                                                        <div class="input-group input-daterange">
                                                            <div class="input-group-addon">de</div>
                                                            <input type="text" class="form-control" title="haz click para editar fecha de nacimiento" placeholder="dia de nacimiento" readonly="true" name="birthday">
                                                            <div class="input-group-addon">hasta</div>
                                                            <input type="text" class="form-control" title="haz click para editar fecha final" readonly="true" name="final_day" id="final_day">
                                                        </div>                
                                                    </div>
                                                    <div class="form-group">
                                                            <input type="password" name="contrasena" id="password" tabindex="2" class="form-control" placeholder="Contraseña nueva">
                                                    </div>
                                                    <div class="form-group">
                                                            <input type="password" name="c-contrasena" id="confirm-password" tabindex="2" class="form-control" placeholder="Confirmar contraseña">
                                                    </div>
                                                    <div class="form-group">
                                                            <div class="row">
                                                                    <div class="col-sm-6 col-sm-offset-3">
                                                                            <input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="Registrar">
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </form>
                                    </div>
                            </div>
                    </div>
            </div>
        </div>
        </div>
    </div>
</div>
                    
<script type="text/javascript">
    $(function() {

        $('#login-form-link').click(function(e) {
                $("#login-form").delay(100).fadeIn(100);
                $("#register-form").fadeOut(100);
                $('#register-form-link').removeClass('active');
                $(this).addClass('active');
                $('#panel-padding').removeClass('panel-padding-bottom-second');
                $('#panel-padding').addClass('panel-padding-bottom-first');
                
                e.preventDefault();
            });
            $('#register-form-link').click(function(e) {
                $("#register-form").delay(100).fadeIn(100);
                $("#login-form").fadeOut(100);
                $('#login-form-link').removeClass('active');
                $(this).addClass('active');
                $('#panel-padding').removeClass('panel-padding-bottom-first');
                $('#panel-padding').addClass('panel-padding-bottom-second');
                e.preventDefault();
            });
    });
</script>

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

<%@ include file = "footer.jsp"%>
