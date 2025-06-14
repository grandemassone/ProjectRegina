package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Utente;
import model.UtenteDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Estrai i dati dal form
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validazione base dei campi
        if (nome == null || cognome == null || email == null || password == null ||
                nome.isBlank() || cognome.isBlank() || email.isBlank() || password.isBlank()) {

            request.setAttribute("error", "Tutti i campi sono obbligatori.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            // Controlla se l'email è già registrata
            if (UtenteDAO.doRetrieveByEmail(email) != null) {
                request.setAttribute("error", "Email già registrata.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            // Crea e salva il nuovo utente
            Utente nuovoUtente = new Utente();
            nuovoUtente.setNome(nome);
            nuovoUtente.setCognome(cognome);
            nuovoUtente.setEmail(email);
            nuovoUtente.setPasskey(HashUtil.toHash(password));

            UtenteDAO.doSave(nuovoUtente);

            // Mostra messaggio di successo e reindirizza al login
            HttpSession session = request.getSession();
            session.setAttribute("loginMessage", "Registrazione completata con successo. Effettua il login.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");

        } catch (SQLException e) {
            throw new ServletException("Errore durante la registrazione", e);
        }
    }
}
