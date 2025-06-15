<%@ page import="model.Utente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conferma Ordine</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cal+Sans&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="<%= request.getContextPath() %>/css/index.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/img/favicon.ico" rel="icon" type="image/x-icon">
</head>
<body>

<!-- HEADER -->
<header>
    <div id="contenitoreHeader">
        <div class="sezioneBottoni sinistra">
            <a href="<%= request.getContextPath() %>/TuttiProdottiServlet">
                <button class="button" type="button"><i class="fas fa-compass"></i></button>
            </a>
            <a href="<%= request.getContextPath() %>/TuttiPreferitiServlet">
                <button class="button" type="button"><i class="fas fa-heart"></i></button>
            </a>
        </div>
        <div id="contenitoreLogo">
            <a href="<%= request.getContextPath() %>/index">
                <img alt="Logo Regina Chocolate" id="logoHeader"
                     src="<%= request.getContextPath() %>/img/logo.png">
            </a>
        </div>
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
            <% } %>
            <a href="<%= request.getContextPath() %>/pagina-carrello.jsp">
                <button class="button" type="button"><i class="fas fa-shopping-cart"></i></button>
            </a>
            <% if (utente != null) { %>
            <form action="<%= request.getContextPath() %>/LogoutServlet" method="post" style="display:inline">
                <button class="button" type="submit" title="Logout"><i class="fas fa-sign-out-alt"></i></button>
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

<!-- FORM -->
<%
    Utente u = (Utente) session.getAttribute("utente");
%>

<h2>Conferma Ordine</h2>
<form action="ConfermaOrdineServlet" method="post">
    <% if (u == null) { %>
    <h3>Dati Utente</h3>
    Nome: <input type="text" name="nome" required><br><br>
    Cognome: <input type="text" name="cognome" required><br><br>
    Email: <input type="email" name="email" required><br>
    <% } %>

    <h3>Indirizzo di Spedizione</h3>
    Indirizzo: <input type="text" name="indirizzo" required><br><br>
    Città: <input type="text" name="citta" required><br><br>

    Regione:
    <select id="regione" name="regione" required>
        <option value="">Seleziona regione</option>
    </select><br><br>

    Provincia:
    <select id="provincia" name="provincia" required>
        <option value="">Seleziona provincia</option>
    </select><br><br>

    CAP: <input type="text" name="cap" required><br><br>

    <button type="submit">Conferma e Paga</button>
</form>

<!-- FOOTER -->
<br>
<hr>
<br>
<br>
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
    <p style="font-size: 11px; color: rgba(50, 32, 27, 0.2);">
        <span style="float: left;">©2025 ®ReginaChocolate IT<br>Regina Chocolate S.p.A. Via Antani 34, Angri, Italy</span>
        <span style="float: right;">Created by Salvador Davide Passarelli and Salvatore Lepore</span>
    </p>
</div>

<!-- AJAX REGIONI E PROVINCE -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const regioneSelect = document.getElementById("regione");
        const provinciaSelect = document.getElementById("provincia");

        fetch("<%= request.getContextPath() %>/resources/regioni-province.json")
            .then(response => response.json())
            .then(data => {
                for (let regione in data) {
                    const option = document.createElement("option");
                    option.value = regione;
                    option.textContent = regione;
                    regioneSelect.appendChild(option);
                }

                regioneSelect.addEventListener("change", () => {
                    const selectedRegione = regioneSelect.value;
                    const province = data[selectedRegione] || [];
                    provinciaSelect.innerHTML = '<option value="">Seleziona provincia</option>';
                    province.forEach(prov => {
                        const opt = document.createElement("option");
                        opt.value = prov;
                        opt.textContent = prov;
                        provinciaSelect.appendChild(opt);
                    });
                });
            })
            .catch(error => {
                console.error("Errore nel caricamento delle province:", error);
            });
    });
</script>

</body>
</html>
