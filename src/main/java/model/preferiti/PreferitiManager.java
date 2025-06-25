package model.preferiti;

import java.sql.SQLException;

// Usiamo questa classe per chiamare i metodi in preferitiDAO rispettando il modello MVC
public class PreferitiManager {
    public static void togglePreferito(int idUtente, int idProdotto) throws SQLException {
        if (PreferitiDAO.isInPreferiti(idUtente, idProdotto)) {
            PreferitiDAO.rimuoviDaPreferiti(idUtente, idProdotto);
        } else {
            PreferitiDAO.aggiungiAPreferiti(idUtente, idProdotto);
        }
    }
}