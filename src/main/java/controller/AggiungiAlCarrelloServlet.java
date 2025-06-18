package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AggiungiAlCarrelloServlet", value = "/AggiungiAlCarrelloServlet")
public class AggiungiAlCarrelloServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Recupera sessione corrente o la crea
        HttpSession session = request.getSession();

        // Recupera id prodotto e quantità dal form
        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));

        try {
            // Recupera il prodotto dal database
            Prodotto prodotto = ProdottoDAO.doRetrieveById(idProdotto);

            //Non succede mai perché facciamo già il controllo in JavaScript
            if (prodotto == null || prodotto.getQuantita() < quantita) {
                request.setAttribute("error", "Prodotto non disponibile o quantità richiesta troppo alta.");
                request.getRequestDispatcher("/pagina-carrello.jsp").forward(request, response);
                return;
            }

            // Recupera o inizializza il carrello dalla sessione (usiamo una mappa <Prodotto, Quantità>)
            Map<Prodotto, Integer> carrello = (Map<Prodotto, Integer>) session.getAttribute("carrello");
            if (carrello == null) {
                carrello = new HashMap<>();
            }

            // Aggiungi il prodotto o aggiorna la quantità
            boolean prodottoPresente = false;
            for (Prodotto p : new ArrayList<>(carrello.keySet())) {
                if (p.getId() == prodotto.getId()) {
                    carrello.put(p, carrello.get(p) + quantita);
                    prodottoPresente = true;
                    break;
                }
            }

            if (!prodottoPresente) {
                carrello.put(prodotto, quantita);
            }

            session.setAttribute("carrello", carrello);

        } catch (SQLException e) {
            throw new ServletException("Errore nel recupero del prodotto", e);
        }
        response.sendRedirect(request.getHeader("referer"));
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Metodo GET non supportato.");
    }

}