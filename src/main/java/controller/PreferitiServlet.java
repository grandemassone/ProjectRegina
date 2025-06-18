package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.ProdottoDAO;
import model.Utente;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "PreferitiServlet", value = "/PreferitiServlet")
public class PreferitiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Recupera la sessione esistente, senza crearne una nuova
        HttpSession session = request.getSession(false);

        //Se la sessione non esiste o l'utente non è loggato, blocca l'accesso
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?errore=loginNecessario");
            return;
        }

        //Recupera l'utente loggato
        Utente utente = (Utente) session.getAttribute("utente");
        int idUtente = utente.getId();

        //Recupera l'ID del prodotto dalla richiesta
        String idProdottoParam = request.getParameter("idProdotto");
        if (idProdottoParam == null || idProdottoParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parametro 'idProdotto' mancante.");
            return;
        }

        int idProdotto;
        try {
            idProdotto = Integer.parseInt(idProdottoParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID prodotto non valido.");
            return;
        }

        //Interagisce con il database per aggiungere/rimuovere dai preferiti
        ProdottoDAO dao = new ProdottoDAO();
        try {
            if (dao.isInPreferiti(idUtente, idProdotto)) {
                dao.rimuoviDaPreferiti(idUtente, idProdotto);
            } else {
                dao.aggiungiAPreferiti(idUtente, idProdotto);
            }
        } catch (SQLException e) {
            throw new ServletException("Errore durante la gestione dei preferiti.", e);
        }

        //Resta nella stessa pagina
        response.sendRedirect(request.getHeader("referer"));
    }
}
