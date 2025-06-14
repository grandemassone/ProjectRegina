package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "CheckoutServlet", value = "/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Logica pagamento da implementare (es. Stripe, PayPal, finto pagamento, ecc.)
        // Per ora, svuotiamo il carrello e reindirizziamo a una pagina di conferma

        HttpSession session = request.getSession();
        session.removeAttribute("carrello");

        // Messaggio di conferma
        request.setAttribute("messaggio", "Ordine completato con successo!");
        request.getRequestDispatcher("/WEB-INF/form-spedizione.jsp").forward(request, response);
    }
}