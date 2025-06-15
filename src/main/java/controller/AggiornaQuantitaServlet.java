package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.ProdottoDAO;
import model.Utente;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AggiornaQuantitaServlet", value = "/AggiornaQuantitaServlet")
public class AggiornaQuantitaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utente u = (Utente) request.getSession().getAttribute("utente");
        if (u == null || !"admin".equals(u.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/accesso-negato.jsp");
            return;
        }

        try {
            List<Prodotto> prodotti = ProdottoDAO.doRetrieveQuantita();
            for (Prodotto p : prodotti) {
                String paramName = "quantita_" + p.getId();
                String nuovaQuantitaStr = request.getParameter(paramName);
                if (nuovaQuantitaStr != null) {
                    int nuovaQuantita = Integer.parseInt(nuovaQuantitaStr);
                    if (nuovaQuantita != p.getQuantita()) {
                        ProdottoDAO.aggiornaQuantita(p.getId(), nuovaQuantita);
                    }
                }
            }
            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
        } catch (SQLException e) {
            throw new ServletException("Errore nell'aggiornamento delle quantità", e);
        }
    }
}
