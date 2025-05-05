package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "TuttiProdottiServlet", value = "/TuttiProdottiServlet")
public class TuttiProdottiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoDAO dao = new ProdottoDAO();
        List<Prodotto> prodotti = dao.doRetrieveAll();

        request.setAttribute("prodotti", prodotti);
        request.getRequestDispatcher("/WEB-INF/tutti-prodotti.jsp").forward(request, response);
    }
}