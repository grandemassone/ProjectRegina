package controller.carrello;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "SvuotaCarrelloServlet", value = "/SvuotaCarrelloServlet")
public class SvuotaCarrelloServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("carrello");
        }
        response.sendRedirect(request.getContextPath() + "/RedirectCarrelloServlet");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Metodo GET non supportato.");
    }
}
