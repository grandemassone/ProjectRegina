package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Prodotto;
import model.ProdottoDAO;
import model.Utente;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "TuttiPreferitiServlet", value = "/TuttiPreferitiServlet")
public class TuttiPreferitiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Controllo login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            // Creo (o riutilizzo) la session per passare il messaggio
            session = request.getSession(true);
            session.setAttribute("loginMessage",
                    "Devi prima effettuare il login per vedere i preferiti!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Utente utente = (Utente) session.getAttribute("utente");
        int idUtente = utente.getId();

        ProdottoDAO dao = new ProdottoDAO();
        List<Prodotto> preferiti;
        try {
            preferiti = dao.doRetrieveAllPreferiti(idUtente);
        } catch (SQLException e) {
            throw new ServletException("Errore nel recupero dei preferiti", e);
        }

        request.setAttribute("preferiti", preferiti);
        request.getRequestDispatcher("/WEB-INF/pagina-preferiti.jsp").forward(request, response);
    }
}