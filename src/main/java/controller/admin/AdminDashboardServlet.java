package controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.prodotto.Prodotto;
import model.prodotto.ProdottoDAO;
import model.utente.Utente;
import model.utente.UtenteDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AdminDashboardServlet", value = "/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utente u = (Utente) request.getSession().getAttribute("utente");
        if(u == null || !"admin".equals(u.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/WEB-INF/accesso-negato.jsp");
            return;
        }

        try {
            List<Utente> utenti = UtenteDAO.doRetrieveAll();
            List<Prodotto> prodotti = ProdottoDAO.doRetrieveQuantita();
            request.setAttribute("utenti", utenti);
            request.setAttribute("prodotti", prodotti);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin-dashboard.jsp");
            dispatcher.forward(request, response);
        } catch(SQLException e) {
            throw new ServletException("Errore nel caricamento della dashboard", e);
        }
    }
}