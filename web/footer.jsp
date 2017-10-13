<%-- 
    Document   : footer
    Created on : 26-jul-2017, 17:04:35
    Author     : Morales
--%>

<footer class="container-fluid text-center">
    <p><i>©2017 Los Javeros. Todos los derechos reservados.</i></p>
</footer>

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
            alert("Se envió un correo a \"${param.email}\" con la \ninformación de la cuenta.");
        </c:when>
        <c:when test="${param.message == 7}">
            alert("La contraseña no puede estar vacia.");
        </c:when>
        <c:when test="${param.message == 8}">
            alert("Las contraseñas deben de ser iguales.");
        </c:when>
        <c:when test="${param.message == 9}">
            alert("El correo ya ha sido dado de alta.");
        </c:when>
        <c:when test="${param.message == 10}">
            alert("Las credenciales no pueden estar vacias.");
        </c:when>
        <c:when test="${param.message == 11}">
            alert("El correo introducido no existe.");
        </c:when>
        <c:when test="${param.message == 12}">
            alert("Contraseña inválida.");
        </c:when>
        <c:when test="${param.message == 13}">
            alert("Tienes que iniciar sesión antes de entrar a la aplicación.");
        </c:when>
        <c:when test="${param.message == 14}">
            alert("La nueva contraseña no puede estar vacia.");
        </c:when>
        <c:when test="${param.message == 15}">
            alert("Los cambios se guardaron correctamente.");
        </c:when>
</c:choose>
</script>    

</body>
</html>

