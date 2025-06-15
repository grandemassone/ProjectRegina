package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrdineDAO {

    public static int salvaOrdine(Utente utente, String destinatario, String indirizzo, String citta, String cap) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            String query = "INSERT INTO ordine (idUtente, destinatario, indirizzo, citta, cap) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            // Se l'utente è guest (id = 0 o non settato), inseriamo NULL
            if (utente.getId() > 0) {
                ps.setInt(1, utente.getId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }

            ps.setString(2, destinatario);
            ps.setString(3, indirizzo);
            ps.setString(4, citta);
            ps.setString(5, cap);

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                throw new SQLException("Errore nel recupero dell'ID dell'ordine generato.");
            }
        }
    }

    public static void salvaDettagliOrdine(int idOrdine, Map<Prodotto, Integer> carrello) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            con.setAutoCommit(false);

            PreparedStatement insertDettaglio = con.prepareStatement(
                    "INSERT INTO ordine_dettaglio (idOrdine, idProdotto, quantita, prezzo_unitario) VALUES (?, ?, ?, ?)"
            );

            PreparedStatement updateQuantita = con.prepareStatement(
                    "UPDATE prodotto SET quantita = quantita - ? WHERE idProdotto = ? AND quantita >= ?"
            );

            for (Map.Entry<Prodotto, Integer> entry : carrello.entrySet()) {
                Prodotto p = entry.getKey();
                int q = entry.getValue();

                insertDettaglio.setInt(1, idOrdine);
                insertDettaglio.setInt(2, p.getId());
                insertDettaglio.setInt(3, q);
                insertDettaglio.setDouble(4, p.getPrezzo());
                insertDettaglio.addBatch();

                updateQuantita.setInt(1, q);
                updateQuantita.setInt(2, p.getId());
                updateQuantita.setInt(3, q);
                updateQuantita.addBatch();
            }

            insertDettaglio.executeBatch();
            int[] results = updateQuantita.executeBatch();

            for (int r : results) {
                if (r == 0) {
                    con.rollback();
                    throw new SQLException("Quantità insufficiente per un prodotto.");
                }
            }

            con.commit();
        }
    }
}
