package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.ProdottoDAO;
import model.Utente;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PreferitiServlet", value = "/PreferitiServlet")
public class PreferitiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Integer> preferiti = (List<Integer>) session.getAttribute("preferiti");
        if (preferiti == null) {
            preferiti = new ArrayList<>();
            session.setAttribute("preferiti", preferiti);
        }
        String idProdottoParam = request.getParameter("idProdotto");
        if (idProdottoParam == null || idProdottoParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parametro 'idProdotto' mancante.");
            return;
        }
        int idProdotto = Integer.parseInt(idProdottoParam);

        if (session.getAttribute("utente") != null) {
            // utente loggato → salva nel DB
            Utente utente = (Utente) session.getAttribute("utente");
            int idUtente = utente.getId();
            ProdottoDAO dao = new ProdottoDAO();

            try {
                if (dao.isInPreferiti(idUtente, idProdotto)) {
                    dao.rimuoviDaPreferiti(idUtente, idProdotto);
                } else {
                    dao.aggiungiAPreferiti(idUtente, idProdotto);
                }
            } catch(SQLException e) {
                throw new RuntimeException(e);
            }
        } else {
            // utente non loggato → salva in sessione
            if (preferiti.contains(idProdotto)) {
                preferiti.remove(Integer.valueOf(idProdotto));
            } else {
                preferiti.add(idProdotto);
            }
        }
        response.sendRedirect(request.getHeader("referer"));
    }
}
