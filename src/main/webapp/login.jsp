<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cal+Sans&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="<%= request.getContextPath() %>/css/login.css" rel="stylesheet">
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
            <a href="<%= request.getContextPath() %>/pagina-carrello.jsp">
                <button class="button" type="button"><i class="fas fa-shopping-cart"></i></button>
            </a>
            <a href="<%= request.getContextPath() %>/login.jsp">
                <button class="button" type="button"><i class="fas fa-sign-in"></i></button>
            </a>
        </div>
    </div>
</header>

<hr>


<!-- Contenitore dei form -->
<div id="contenitore-form">
    <!-- Form di registrazione -->
    <div class="form-box">
        <h2>Sign in</h2>
        <form action="<%= request.getContextPath() %>/RegisterServlet" method="POST">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" required>
                <div class="error" id="nomeError"></div>
            </div>
            <div class="form-group">
                <label for="cognome">Cognome:</label>
                <input type="text" id="cognome" name="cognome" required>
                <div class="error" id="cognomeError"></div>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <div class="error" id="emailError"></div>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <div class="error" id="passwordError"></div>
            </div>
            <button type="submit">Registrati</button>
        </form>
    </div>

    <!-- Form di login -->
    <div class="form-box">
        <h2>Login</h2>
        <form action="<%= request.getContextPath() %>/LoginServlet" method="POST">
            <div class="form-group">
                <label for="emailLogin">Email:</label>
                <input type="email" id="emailLogin" name="email" required>
            </div>
            <div class="form-group">
                <label for="passwordLogin">Password:</label>
                <input type="password" id="passwordLogin" name="password" required>
            </div>
            <button type="submit">Accedi</button>
        </form>
    </div>
</div>

<br>
<hr>
<br><br>

<!-- Footer -->

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
        <span style="display: flex; float: left; color: rgba(50, 32, 27, 20)">
            ©2025 ®ReginaChocolate IT <br>
            Regina Chocolate S.p.A. Via Antani 34, Angri, Italy
        </span>
        <span style="display: flex; justify-content: end; color: rgba(50, 32, 27, 20)">
            Created by Salvador Davide Passarelli and Salvatore Lepore
        </span>
    </p>
</div>
</body>
</html>
