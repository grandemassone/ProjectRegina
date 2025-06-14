<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Utente, model.Prodotto" %>
<%
  List<Utente> utenti = (List<Utente>) request.getAttribute("utenti");
  List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
%>

<html>
<head>
  <meta charset="UTF-8">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cal+Sans&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <link href="<%= request.getContextPath() %>/css/index.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/img/favicon.ico" rel="icon" type="image/x-icon">
  <title>Admin Dashboard</title>
</head>
<body>
<header>
  <div id="contenitoreHeader">
    <!-- Sezione bottoni sinistra -->
    <div class="sezioneBottoni sinistra">
      <a href="<%= request.getContextPath() %>/TuttiProdottiServlet">
        <button class="button" type="button"><i class="fas fa-compass"></i></button>
      </a>
      <a href="<%= request.getContextPath() %>/TuttiPreferitiServlet">
        <button class="button" type="button"><i class="fas fa-heart"></i></button>
      </a>
    </div>

    <!-- Logo -->
    <div id="contenitoreLogo">
      <a href="<%= request.getContextPath() %>/index">
        <img alt="Logo Regina Chocolate" id="logoHeader" src="<%= request.getContextPath() %>/img/logo.png">
      </a>
    </div>

    <!-- Sezione bottoni destra -->
    <div class="sezioneBottoni destra">
      <%
        Utente utente = (Utente) session.getAttribute("utente");
        if (utente != null && "admin".equals(utente.getRuolo())) {
      %>
      <a href="<%= request.getContextPath() %>/AdminDashboardServlet">
        <button class="button" type="button" title="Pannello Admin">
          <i class="fas fa-user-shield"></i>
        </button>
      </a>
      <%
        }
      %>
      <a href="<%= request.getContextPath() %>/pagina-carrello.jsp">
        <button class="button" type="button"><i class="fas fa-shopping-cart"></i></button>
      </a>
      <%
        // Se l’utente è loggato, mostro logout, altrimenti login
        if (session.getAttribute("utente") != null) {
      %>
      <form action="<%= request.getContextPath() %>/LogoutServlet" method="post" style="display:inline">
        <button class="button" type="submit" title="Logout">
          <i class="fas fa-sign-out-alt"></i>
        </button>
      </form>
      <%
      } else {
      %>
      <a href="<%= request.getContextPath() %>/login.jsp">
        <button class="button" type="button"><i class="fas fa-sign-in"></i></button>
      </a>
      <%
        }
      %>
    </div>
  </div>
</header>
<hr>

<h2>Utenti Registrati</h2>
<table border="1">
  <tr><th>Nome</th><th>Cognome</th><th>Email</th></tr>
  <%
    for (Utente u : utenti) {
  %>
  <tr>
    <td><%= u.getNome() %></td>
    <td><%= u.getCognome() %></td>
    <td><%= u.getEmail() %></td>
  </tr>
  <%
    }
  %>
</table>

<h2>Quantità prodotti a magazzino</h2>
<table border="1">
  <tr><th>Nome Prodotto</th><th>Quantità</th></tr>
  <%
    for (Prodotto p : prodotti) {
  %>
  <tr>
    <td><%= p.getNome() %></td>
    <td><%= p.getQuantita() %></td>
  </tr>
  <%
    }
  %>
</table>
</body>
</html>
