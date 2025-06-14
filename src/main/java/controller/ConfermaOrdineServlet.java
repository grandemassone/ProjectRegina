package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Utente;

import java.io.IOException;

@WebServlet(name = "ConfermaOrdineServlet", value = "/ConfermaOrdineServlet")
public class ConfermaOrdineServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        // Se non è loggato, recupera anche i dati utente dal form
        if (utente == null) {
            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String email = request.getParameter("email");

            if (nome == null || cognome == null || email == null ||
                    nome.isEmpty() || cognome.isEmpty() || email.isEmpty()) {
                request.setAttribute("errore", "Tutti i campi utente sono obbligatori.");
                request.getRequestDispatcher("/form-spedizione.jsp").forward(request, response);
                return;
            }

            // (Opzionale) creare un utente "temporaneo" per la sessione
            utente = new Utente();
            utente.setNome(nome);
            utente.setCognome(cognome);
            utente.setEmail(email);
            session.setAttribute("utenteTemp", utente); // o usare solo per visualizzazione
        }

        // Dati spedizione obbligatori per tutti
        String indirizzo = request.getParameter("indirizzo");
        String citta = request.getParameter("citta");
        String cap = request.getParameter("cap");

        if (indirizzo == null || citta == null || cap == null ||
                indirizzo.isEmpty() || citta.isEmpty() || cap.isEmpty()) {
            request.setAttribute("errore", "Tutti i campi di spedizione sono obbligatori.");
            request.getRequestDispatcher("/form-spedizione.jsp").forward(request, response);
            return;
        }

        // A questo punto l'ordine è valido (salvataggio nel database opzionale)
        // Pulisce il carrello e mostra pagina di conferma
        session.removeAttribute("carrello");
        request.setAttribute("messaggio", "Ordine confermato! Riceverai una email a breve.");
        request.getRequestDispatcher("/WEB-INF/ordine-confermato.jsp").forward(request, response);
    }

}
