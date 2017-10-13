<%-- 
    Document   : header
    Created on : 26-jul-2017, 17:04:13
    Author     : Morales
--%>
<%@ include file = "header.jsp"%>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Los javeros</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="Calculadora.jsp">Home</a></li>
        
        
      </ul>
      <form action="LogoutServlet" method="post" id="form">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#" onclick="document.getElementById('form').submit();"><span class="glyphicon glyphicon-log-in"></span> Salir</a></li>
      </ul>
      </form>
    </div>
  </div>
</nav>
