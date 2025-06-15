package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Prodotto;
import model.Utente;
import model.UtenteDAO;
import model.OrdineDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

@WebServlet(name = "ConfermaOrdineServlet", value = "/ConfermaOrdineServlet")
public class ConfermaOrdineServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        try {
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

                Utente esistente = UtenteDAO.doRetrieveByEmail(email);
                if (esistente != null) {
                    utente = esistente;
                } else {
                    utente = new Utente();
                    utente.setNome(nome);
                    utente.setCognome(cognome);
                    utente.setEmail(email);
                    utente.setPasskey("temporary"); // placeholder
                    UtenteDAO.doSave(utente);
                }

                session.setAttribute("utente", utente);
            }

            String destinatario = utente.getNome() + " " + utente.getCognome();
            String indirizzo = request.getParameter("indirizzo");
            String citta = request.getParameter("citta");
            String cap = request.getParameter("cap");

            if (indirizzo == null || citta == null || cap == null ||
                    indirizzo.isEmpty() || citta.isEmpty() || cap.isEmpty()) {
                request.setAttribute("errore", "Tutti i campi di spedizione sono obbligatori.");
                request.getRequestDispatcher("/form-spedizione.jsp").forward(request, response);
                return;
            }

            Map<Prodotto, Integer> carrello = (Map<Prodotto, Integer>) session.getAttribute("carrello");
            if (carrello == null || carrello.isEmpty()) {
                request.setAttribute("errore", "Il carrello è vuoto.");
                request.getRequestDispatcher("/pagina-carrello.jsp").forward(request, response);
                return;
            }

            int idOrdine = OrdineDAO.salvaOrdine(utente, destinatario, indirizzo, citta, cap);
            OrdineDAO.salvaDettagliOrdine(idOrdine, carrello);

            session.removeAttribute("carrello");
            request.setAttribute("messaggio", "Ordine registrato con successo.");
            request.getRequestDispatcher("/WEB-INF/ordine-confermato.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Errore durante il salvataggio dell'ordine", e);
        }
    }
}