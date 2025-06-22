<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.utente.Utente" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ordine Completato</title>
    <link href="<%= request.getContextPath() %>/css/index.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Cal Sans', sans-serif;
            background-color: #fefefe;
            text-align: center;
            padding: 50px;
        }
        .messaggio {
            font-size: 1.5rem;
            color: #3a201b;
            background-color: #e0ffe0;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            margin: 0 auto 40px auto;
            max-width: 600px;
        }
        .button-home {
            padding: 12px 24px;
            font-size: 1.1rem;
            background-color: #3a201b;
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .button-home:hover {
            background-color: #5c3329;
        }
    </style>
</head>
<body>

<%
    Utente utente = (Utente) session.getAttribute("utente");
%>

<div class="messaggio">
    <h2>Grazie per il tuo ordine<% if (utente != null) { %>, <%= utente.getNome() %><% } %>!</h2>
    <p>Il tuo ordine è stato completato con successo. Riceverai una conferma via email a breve.</p>
    <p><i class="fas fa-check-circle" style="color: green; font-size: 2rem;"></i></p>
</div>

<a href="<%= request.getContextPath() %>/index">
    <button class="button-home">
        Torna alla home <i class="fas fa-home" style="margin-left: 8px;"></i>
    </button>
</a>

</body>
</html>
