package controller;

import model.Prodotto;
import model.ProdottoDAO;

import java.util.ArrayList;
import java.util.List;

public class test {
    public static void main(String[] args) {
        List<Prodotto> prodotti = new ArrayList<>();
        try {
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            prodotti = prodottoDAO.doRetrieveAll();
            prodottoDAO.removePreferitoById(prodotti.get(3).getId());
        } catch (Exception e) {
            e.printStackTrace(); // Oppure usa un logger per registrare l'errore
        }
    }
}
