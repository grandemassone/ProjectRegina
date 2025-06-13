<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="java.util.List" %>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cal+Sans&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="<%= request.getContextPath() %>/css/index.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/img/favicon.ico" rel="icon" type="image/x-icon">
    <title>I miei preferiti</title>
</head>
<body>
<header>
    <div id="contenitoreHeader">
        <div class="sezioneBottoni sinistra">
            <a href="<%= request.getContextPath() %>/TuttiProdottiServlet">
                <button class="button" type="button"><i class="fas fa-compass"></i></button>
            </a>
            <a href="<%= request.getContextPath() %>/TuttiPreferitiServlet">
                <button class="button active" type="button"><i class="fas fa-heart"></i></button>
            </a>
        </div>
        <div id="contenitoreLogo">
            <a href="<%= request.getContextPath() %>/index">
                <img alt="Logo Regina Chocolate" id="logoHeader" src="<%= request.getContextPath() %>/img/logo.png">
            </a>
        </div>
        <div class="sezioneBottoni destra">
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

<h2>I tuoi prodotti preferiti</h2>
<hr style="height: 2px; border: none; background: linear-gradient(to right, white 0%, white 35%, #321F1B 50%, white 65%, white 100%); margin: 20px auto;">

<div id="contenitoreProdotti" style="margin-top: 0; margin-bottom: 75px;">
    <%
        @SuppressWarnings("unchecked")
        List<Prodotto> preferiti = (List<Prodotto>) request.getAttribute("preferiti");
    %>

    <% if (preferiti != null && !preferiti.isEmpty()) { %>
    <% for (Prodotto p : preferiti) {
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
                <span style="color: rgb(85,46,35);">
                    <%= p.getNome() %>
                </span><br/>
            <%= String.format("%.2f€", p.getPrezzo()) %>
        </figcaption>
    </figure>
    <% } %>
    <% } else { %>
    <p style="text-align: center; margin-top: 50px;">
        <i class="fas fa-heart-broken" style="font-size: 2em; color: #ccc;"></i><br/>
        Non hai ancora aggiunto prodotti ai preferiti.
    </p>
    <% } %>
</div>

<hr><br><br>

<footer>
    <div id="contenitoreFooter">
        <div class="footer-sezione">
            <h3>Metodi di pagamento</h3>
            <div class="icone-pagamento">
                <i class="fab fa-cc-visa"></i>
                <i class="fab fa-cc-mastercard"></i>
                <i class="fab fa-cc-paypal"></i>
                <i class="fab fa-cc-apple-pay"></i>
            </div>
        </div>
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
    <p style="font-size: 11px">
        <span style="display: flex; float: left; color: rgba(50, 32, 27, 0.2);">
            ©2025 ®ReginaChocolate IT<br/>
            Regina Chocolate S.p.A. Via Antani 34, Angri, Italy
        </span>
        <span style="display: flex; justify-content: end; color: rgba(50, 32, 27, 0.2);">
            Created by Salvador Davide Passarelli and Salvatore Lepore
        </span>
    </p>
</div>

</body>
</html>
