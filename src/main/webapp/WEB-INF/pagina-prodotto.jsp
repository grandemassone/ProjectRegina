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
    <!-- Immagine prodotto -->
    <figure>
        <img src="<%= request.getContextPath() %>/img/<%= prodotto.getNome().toLowerCase().replace(" ", "_") %>.jpg"
             alt="<%= prodotto.getNome() %>" id="immagineProdotto">
        <figcaption style="margin-top: 10px; font-size: x-large"><%=df.format(prodotto.getPrezzo()) %>€</figcaption>
    </figure>


    <!-- Dettagli accanto all'immagine -->
    <div class="contenitore-dettagli">
        <h2 id="h2-prodotto"><%= prodotto.getNome() + " | " + prodotto.getTipologia() %>
        </h2>
        <div style="font-size: 1rem; font-weight: 500; margin-top: 10px; padding: 6px 12px; border-radius: 5px; background-color: #ffffff; color: rgb(58, 32, 27); box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
            <b>
            <p><%= prodotto.getDescrizione() %>
            </p>
            <p>
                <%= prodotto.getQuantita() > 0 ? (prodotto.getQuantita() == 1 ? "!Ultimo pezzo!" : "Sono disponibili " + prodotto.getQuantita() + " pezzi!") : "Non disponibile!"%>
            </p>
            </b>
        </div>
        <!-- Bottoni interazione -->
        <div class="bottoni-interazione">
            <!-- Aggiungi al carrello -->
            <form action="<%= request.getContextPath() %>/AggiungiAlCarrelloServlet" method="post">
                <input type="hidden" name="idProdotto" value="<%= prodotto.getId() %>">

                <button type="submit" class="button">
                    Aggiungi al carrello <br> <i class="fas fa-shopping-cart"></i>
                </button>

                <!-- Selettore quantità sotto al bottone -->
                <div class="quantita-wrapper">
                    <label for="quantita"></label>
                    <div class="selettore-quantita">
                        <button type="button" class="btn-quantita" onclick="decrementa()"
                                style="padding-top: 5px; padding-bottom: 8px">−
                        </button>
                        <input type="text" id="quantitaVisualizzata" value="1" disabled>
                        <input type="hidden" id="quantita" name="quantita" value="1">
                        <button type="button" class="btn-quantita" onclick="incrementa(<%= prodotto.getQuantita() %>)"
                                style="padding-top: 5px; padding-bottom: 8px">+
                        </button>
                    </div>
                </div>
            </form>

            <!-- Aggiungi ai preferiti -->
            <form action="<%= request.getContextPath() %>/PreferitiServlet" method="post">
                <input type="hidden" name="idProdotto" value="<%= prodotto.getId() %>">
                <button type="submit" class="button"><i class="fas fa-heart"></i></button>
            </form>
        </div>
    </div>

</div>

<!-- Footer -->
<br>
<hr>
<br><br>

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
