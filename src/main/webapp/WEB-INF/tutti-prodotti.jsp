<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.prodotto.Prodotto" %>
<%@ page import="java.util.List" %>
<%@ page import="model.utente.Utente" %>
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
    <title>Tutti i prodotti</title>
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
            <a href="<%= request.getContextPath() %>/RedirectCarrelloServlet">
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
            <a href="<%= request.getContextPath() %>/RedirectLoginServlet">
                <button class="button" type="button"><i class="fas fa-sign-in"></i></button>
            </a>
            <%
                }
            %>
        </div>
    </div>
</header>
<h2>
    Scopri tutti i prodotti di Regina Chocolate
</h2>
<hr style="height: 2px; border: none; background: linear-gradient(to right, white 0%, white 35%, #321F1B 50%, white 65%, white 100%); margin: 20px auto;">

<!-- Filtro per tipologia -->
<div style="margin: 20px; display: flex; justify-content: end;">
    <label for="filtroTipologia"></label>
    <select id="filtroTipologia">
        <option value="">Tutti i prodotti</option>
        <option value="Tavoletta">Tavoletta🍫</option>
        <option value="Dolcetto">Dolcetto🍬</option>
        <option value="Pasqua">Pasqua🐇</option>
        <option value="Preparato">Preparato🍮</option>
        <option value="Borsa">Borsa👜</option>
    </select>
</div>



<!-- Contenitore Prodotti -->
<div id="contenitoreProdotti" style="margin-top: 0px; margin-bottom: 75px;">
    <%
        List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    %>

    <% if (prodotti != null && !prodotti.isEmpty()) { %>
    <% for (Prodotto p : prodotti) {
        String nome = p.getNome();
        String imgName = (nome != null) ? nome.toLowerCase().replaceAll(" ", "_") : "default";
    %>
    <figure class="prodotto" data-tipologia="<%= p.getTipologia() %>">
        <a href="<%= request.getContextPath() %>/ProdottoServlet?id=<%= p.getId() %>">
        <img alt="Immagine di <%= nome %>" src="<%= request.getContextPath() %>/img/<%= imgName %>.jpg" style="object-fit: contain;">
    </a>
    <figcaption>
        <span style="color: rgb(85,46,35);">
        <%= p.getNome() %>
        </span>
        <br>
        <%= String.format("%.2f€", p.getPrezzo()) %>
    </figcaption>
</figure>
    <% } %>
    <% } else { %>
    <p>Nessun prodotto disponibile.</p>
    <% } %>
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
    <p style="font-size: 11px">
        <span style="display: flex; float: left; color: rgba(50, 32, 27, 20);">
            ©2025 ®ReginaChocolate IT <br>
            Regina Chocolate S.p.A. Via Antani 34, Angri, Italy
        </span>
        <span style="display: flex; justify-content: end; color: rgba(50, 32, 27, 20)">
            Created by Salvador Davide Passarelli and Salvatore Lepore
        </span>
    </p>
</div>
</body>

<!-- Script per filtro tipologia -->
<script>
    document.getElementById("filtroTipologia").addEventListener("change", function () {
        const filtro = this.value;
        document.querySelectorAll(".prodotto").forEach(function (prodotto) {
            const tipo = prodotto.dataset.tipologia;
            if (!filtro || tipo === filtro) {
                prodotto.style.display = "inline-block";
            } else {
                prodotto.style.display = "none";
            }
        });
    });
</script>
</html>