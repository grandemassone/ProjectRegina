package controller.preferiti;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.preferiti.PreferitiManager;
import model.utente.Utente;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "PreferitiServlet", value = "/PreferitiServlet")
public class PreferitiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/RedirectLoginServlet?errore=loginNecessario");
            return;
        }

        Utente utente = (Utente) session.getAttribute("utente");
        int idUtente = utente.getId();

        String idProdottoParam = request.getParameter("idProdotto");
        if (idProdottoParam == null || idProdottoParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parametro 'idProdotto' mancante.");
            return;
        }

        try {
            int idProdotto = Integer.parseInt(idProdottoParam);
            PreferitiManager.togglePreferito(idUtente, idProdotto);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID prodotto non valido.");
            return;
        } catch (SQLException e) {
            throw new ServletException("Errore nella gestione dei preferiti", e);
        }

        response.sendRedirect(request.getHeader("referer"));
    }
}
