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

        // NON svuotare il carrello qui. Solo inoltra al form-spedizione.
        request.getRequestDispatcher("/WEB-INF/form-spedizione.jsp").forward(request, response);
    }
}
