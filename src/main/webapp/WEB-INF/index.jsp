<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.List" %>

<%
    // Preleva l'utente loggato una sola volta
    Utente u = (Utente) session.getAttribute("utente");
%>

<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <!-- Fa in modo che i testi usino subito il font corretto appena caricato-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <!-- Carico il font carl-sans da googl font -->
    <link href="https://fonts.googleapis.com/css2?family=Cal+Sans&display=swap" rel="stylesheet">
    <!-- Prendo le icone vettoriali fas-fa -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/index.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/img/favicon.ico" rel="icon" type="image/x-icon">
    <title>Regina Chocolate</title>
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
                <img alt="Logo Regina Chocolate" id="logoHeader"
                     src="<%= request.getContextPath() %>/img/logo.png">
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

            <% if (u != null) { %>
            <form action="<%= request.getContextPath() %>/LogoutServlet" method="post" style="display:inline">
                <button class="button" type="submit" title="Logout">
                    <i class="fas fa-sign-out-alt"></i>
                </button>
            </form>
            <% } else { %>
            <a href="<%= request.getContextPath() %>/login.jsp">
                <button class="button" type="button"><i class="fas fa-sign-in"></i></button>
            </a>
            <% } %>
        </div>
    </div>
</header>

<hr>
<!-- Saluto dopo che l'utente si logga o registra -->
<% if (u != null) { %>
<div id="salutoPagina" style="display: block;
font-family: 'Cal Sans', sans-serif;
font-size: 1.2rem;
color: rgb(58, 32, 27);
padding: 10px 20px;
border-radius: 12px;
margin: 20px auto;
text-align: center;
animation: fadeIn 1s ease-in;">
    Ciao, <strong>${utente.nome} ${utente.cognome}</strong>!
</div>
<% } %>

<!-- Singola immagine centrata -->
<div id="immagineCentrale">
    <img alt="Immagine Principale" id="immagineHeader"
         src="<%= request.getContextPath() %>/img/banner1.png">
</div>

<hr>

<h2 style="margin-top: 50px; text-align:center;">Scopri i nostri prodotti</h2>

<!-- Contenitore Prodotti -->
<div id="contenitoreProdotti">
    <%
        List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    %>

    <% if (prodotti != null && !prodotti.isEmpty()) { %>
    <% for (int i = 0; i < prodotti.size() && i < 6; i++) {
        Prodotto p = prodotti.get(i);
        String nome = p.getNome();
        String imgName = nome != null
                ? nome.toLowerCase().replaceAll("\\s+", "_")
                : "default";
    %>
    <figure class="prodotto">
        <a href="<%= request.getContextPath() %>/ProdottoServlet?id=<%= p.getId() %>">
            <img alt="Immagine di <%= nome %>"
                 src="<%= request.getContextPath() %>/img/<%= imgName %>.jpg"
                 style="object-fit: contain;">
        </a>
        <figcaption>
            <span style="color: rgb(85,46,35);"><%= p.getNome() %></span><br>
            <%= String.format("%.2f€", p.getPrezzo()) %>
        </figcaption>
    </figure>
    <% } %>
    <% } else { %>
    <p style="text-align:center;">Nessun prodotto disponibile.</p>
    <% } %>
</div>

<br><br><br>

<div class="bottoneProdotti" style="text-align:center; margin-bottom:50px;">
    <a href="<%= request.getContextPath() %>/TuttiProdottiServlet">
        <button class="button" type="button" style="font-family: 'Cal Sans', sans-serif;">
            Tutti i prodotti
        </button>
    </a>
</div>

<hr><br><br>

<footer>
    <div id="contenitoreFooter">
        <!-- Metodi di pagamento -->
        <div class="footer-sezione">
            <h3>Metodi di pagamento</h3>
            <div class="icone-pagamento">
                <i class="fab fa-cc-visa"></i>
                <i class="fab fa-cc-mastercard"></i>
                <i class="fab fa-cc-paypal"></i>
                <i class="fab fa-cc-apple-pay"></i>
            </div>
        </div>

        <!-- Social media -->
        <div class="footer-sezione">
            <h3>Seguici</h3>
            <div class="icone-social">
                <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
                <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
                <a href="https://tiktok.com" target="_blank"><i class="fab fa-tiktok"></i></a>
            </div>
        </div>
    </div>
</footer>

<div>
    <p style="font-size: 11px; color: rgba(50, 32, 27, 0.2);">
        <span style="float: left;">©2025 ®ReginaChocolate IT<br>Regina Chocolate S.p.A. Via Antani 34, Angri, Italy</span>
        <span style="float: right;">Created by Salvador Davide Passarelli and Salvatore Lepore</span>
    </p>
</div>
</body>
</html>
