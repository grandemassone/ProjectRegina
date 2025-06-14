package controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.ConPool;
import model.Utente;
import model.UtenteDAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isBlank() || password.isBlank()) {
            request.setAttribute("error", "Email e password sono obbligatorie.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            Utente u = UtenteDAO.doRetrieveByEmail(email);

            if (u != null) {
                String hashedInputPassword = HashUtil.toHash(password);
                if (hashedInputPassword.equals(u.getPasskey())) {
                    request.getSession().setAttribute("utente", u);
                    response.sendRedirect(request.getContextPath() + "/index");
                    return;
                }
            }
            request.setAttribute("error", "Credenziali non valide.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Errore durante il login", e);
        }
    }
}
