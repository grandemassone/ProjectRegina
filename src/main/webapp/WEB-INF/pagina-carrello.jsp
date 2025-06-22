<%@ page import="model.utente.Utente" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.prodotto.Prodotto" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Carrello</title>
</head>
<body>
<!--HEADER-->
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
            <a href="<%= request.getContextPath() %>/RedirectCarrelloServlet">
                <button class="button" type="button"><i class="fas fa-shopping-cart"></i></button>
            </a>

            <% if (utente != null) { %>
            <form action="<%= request.getContextPath() %>/LogoutServlet" method="post" style="display:inline">
                <button class="button" type="submit" title="Logout">
                    <i class="fas fa-sign-out-alt"></i>
                </button>
            </form>
            <% } else { %>
            <a href="<%= request.getContextPath() %>/RedirectLoginServlet">
                <button class="button" type="button"><i class="fas fa-sign-in"></i></button>
            </a>
            <% } %>
        </div>
    </div>
</header>
<hr>

<%
    Map<Prodotto, Integer> carrello = (Map<Prodotto, Integer>) session.getAttribute("carrello");
    DecimalFormat df = new DecimalFormat("0.00");
%>

<div style="max-width: 800px; margin: 0 auto; font-family: 'Cal Sans', sans-serif; padding: 20px">
    <h2>Il tuo carrello</h2>

    <%
        if (carrello == null || carrello.isEmpty()) {
    %>
    <p>Il carrello è vuoto.</p>
    <%
    } else {
        double totale = 0.0;
    %>
    <table style="width:100%; border-collapse: collapse; margin-top: 20px;">
        <tr style="background-color: #f2f2f2;">
            <th style="padding: 10px;">Prodotto</th>
            <th style="padding: 10px;">Quantità</th>
            <th style="padding: 10px;">Prezzo unitario</th>
            <th style="padding: 10px;">Totale</th>
        </tr>
        <%
            for (Map.Entry<Prodotto, Integer> entry : carrello.entrySet()) {
                Prodotto p = entry.getKey();
                int q = entry.getValue();
                double subtotale = p.getPrezzo() * q;
                totale += subtotale;
        %>
        <tr style="border-bottom: 1px solid #ddd; text-align: center">
            <td style="padding: 10px;"><%= p.getNome() %></td>
            <td style="padding: 10px;"><%= q %></td>
            <td style="padding: 10px;"><%= df.format(p.getPrezzo()) %> €</td>
            <td style="padding: 10px;"><%= df.format(subtotale) %> €</td>
        </tr>
        <%
            }
        %>
        <tr style="font-weight: bold; background-color: #fafafa;">
            <td colspan="3" style="text-align: right; padding: 10px;">Totale:</td>
            <td style="padding: 10px;"><%= df.format(totale) %> €</td>
        </tr>
    </table>
    <form action="<%= request.getContextPath() %>/CheckoutServlet" method="post" style="text-align: right; margin-top: 20px;">
        <button type="submit" class="button" style="
        font-size: 1.1rem;
        padding: 12px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        transition: background-color 0.3s ease;">
            Procedi al pagamento <i class="fas fa-credit-card" style="margin-left: 8px;"></i>
        </button>
    </form>
    <form action="<%= request.getContextPath() %>/SvuotaCarrelloServlet" method="post" style="text-align: right; margin-top: 10px;">
        <button type="submit" class="button" style="
        font-size: 1.1rem;
        padding: 12px 20px;
        background-color: #cc0000;
        color: white;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        transition: background-color 0.3s ease;">
            Svuota carrello <i class="fas fa-trash" style="margin-left: 6px;"></i>
        </button>
    </form>

    <%
        }
    %>
</div>

<br>
<hr>
<br>
<br>

<!--FOOTER-->
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
