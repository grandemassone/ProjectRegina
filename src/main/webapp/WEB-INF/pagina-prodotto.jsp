<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="java.text.DecimalFormat" %>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cal+Sans&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="<%= request.getContextPath() %>/css/pagina-prodotto.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/img/favicon.ico" rel="icon" type="image/x-icon">
    <title>Dettagli Prodotto</title>
</head>
<body>
<header>
    <div id="contenitoreHeader">
        <!-- Sezione bottoni sinistra -->
        <div class="sezioneBottoni sinistra">
            <a href="<%= request.getContextPath() %>/TuttiProdottiServlet">
                <button class="button" type="button"><i class="fas fa-compass"></i></button>
            </a>
            <a href="<%= request.getContextPath() %>/pagina-preferiti.jsp">
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
            <a href="<%= request.getContextPath() %>/pagina-carrello">
                <button class="button" type="button"><i class="fas fa-shopping-cart"></i></button>
            </a>
            <a href="<%= request.getContextPath() %>/pagina-registrazione">
                <button class="button" type="button"><i class="fas fa-sign-in"></i></button>
            </a>
        </div>
    </div>
</header>
<hr>

<!-- Recupera il prodotto dalla request -->
<%
    Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
    DecimalFormat df = new DecimalFormat("0.00");
%>

<div class="contenitore-prodotto">
    <div class="contenitore-immagine">
        <img src="<%= request.getContextPath() %>/img/<%= prodotto.getNome().toLowerCase().replace(" ", "_") %>.jpg"
             alt="<%= prodotto.getNome() %>" id="immagineProdotto">
    </div>

    <div class="contenitore-dettagli">
        <div class="descrizione-prodotto">
            <h2 id="h2-prodotto"><%= prodotto.getNome() %></h2>
            <p><%= prodotto.getDescrizione() %></p>
        </div>

        <div class="bottoni-interazione">
            <form action="AggiungiAlCarrelloServlet" method="post">
                <input type="hidden" name="idProdotto" value="<%= prodotto.getId() %>">
                <button type="submit">Aggiungi al carrello</button>
            </form>
            <form action="RimuoviProdottoServlet" method="post">
                <input type="hidden" name="idProdotto" value="<%= prodotto.getId() %>">
                <button type="submit">Rimuovi</button>
            </form>
        </div>
    </div>
</div>


<hr><br><br>

<!--Footer-->
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
            ©2025 ReginaChocolate IT <br>
            Regina Chocolate S.p.A. Via Antani 34, Angri, Italy
        </span>
        <span style="display: flex; justify-content: end; color: rgba(50, 32, 27, 20)">
            Created by Salvador Davide Passarelli and Salvatore Lepore
        </span>
    </p>
</div>
</body>
<script>
    function incrementa(max) {
        let visibile = document.getElementById('quantitaVisualizzata');
        let nascosto = document.getElementById('quantita');
        let valore = parseInt(visibile.value);
        if (valore < max) {
            visibile.value = valore + 1;
            nascosto.value = valore + 1;
        }
    }

    function decrementa() {
        let visibile = document.getElementById('quantitaVisualizzata');
        let nascosto = document.getElementById('quantita');
        let valore = parseInt(visibile.value);
        if (valore > 1) {
            visibile.value = valore - 1;
            nascosto.value = valore - 1;
        }
    }
</script>
</html>
