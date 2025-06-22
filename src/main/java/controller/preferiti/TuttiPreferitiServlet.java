package controller.preferiti;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.prodotto.Prodotto;
import model.prodotto.ProdottoDAO;
import model.utente.Utente;

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
        if(session == null || session.getAttribute("utente") == null) {
            // Creo (o riutilizzo) la session per passare il messaggio
            session = request.getSession(true);
            session.setAttribute("loginMessage",
                    "Devi prima effettuare il login per vedere i preferiti!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Utente utente = (Utente) session.getAttribute("utente");
        int idUtente = utente.getId();

        ProdottoDAO dao = new ProdottoDAO();
        List<Prodotto> preferiti;
        try {
            preferiti = dao.doRetrieveAllPreferiti(idUtente);
        } catch(SQLException e) {
            throw new ServletException("Errore nel recupero dei preferiti", e);
        }

        request.setAttribute("preferiti", preferiti);
        request.getRequestDispatcher("/WEB-INF/pagina-preferiti.jsp").forward(request, response);
    }
}