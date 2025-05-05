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
        } catch (Exception e) {
            e.printStackTrace(); // Oppure usa un logger per registrare l'errore
        }
        for (Prodotto prodotto : prodotti) {
            System.out.println(prodotto.getNome());
            System.out.println(prodotto.getPrezzo());
            System.out.println(prodotto.getQuantita());
            System.out.println(prodotto.getDescrizione());
        }
    }
}
