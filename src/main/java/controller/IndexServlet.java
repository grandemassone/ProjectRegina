
package controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.prodotto.Prodotto;
import model.prodotto.ProdottoDAO;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "IndexServlet", urlPatterns = {"/index"})
public class IndexServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoDAO dao = new ProdottoDAO();
        List<Prodotto> prodotti = dao.doRetrieveAll();

        request.setAttribute("prodotti", prodotti);
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }
}