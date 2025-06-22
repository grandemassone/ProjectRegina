package controller.prodotto;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.prodotto.Prodotto;
import model.prodotto.ProdottoDAO;
import java.io.IOException;

@WebServlet("/ProdottoServlet")
public class ProdottoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera l'ID del prodotto dalla richiesta
        String idProdotto = request.getParameter("id");

        // Recupera il prodotto dal database
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        Prodotto prodotto = prodottoDAO.getProdottoById(Integer.parseInt(idProdotto));

        // Passa l'oggetto prodotto alla pagina JSP per visualizzarlo
        request.setAttribute("prodotto", prodotto);

        // Inoltra la richiesta alla pagina JSP che mostrerà i dettagli
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pagina-prodotto.jsp");
        dispatcher.forward(request, response);
    }
}