package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAO {

    //Metodo per passare la lista dei prodotti alla jsp
    public List<Prodotto> doRetrieveAll() {
        List<Prodotto> prodotti = new ArrayList<>();

        //Tento la connessione al database
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto");
            ResultSet rs = ps.executeQuery();

            //Iterazione sui risultati della query
            while (rs.next()) {
                Prodotto p = new Prodotto();
                p.setId(rs.getInt("id_prodotto"));
                p.setNome(rs.getString("nome"));
                p.setDescrizione(rs.getString("descrizione"));
                p.setPrezzo(rs.getDouble("prezzo"));
                p.setQuantita(rs.getInt("quantita"));
                p.setTipologia(rs.getString("tipologia"));
                p.setPreferito(rs.getInt("preferito"));
                prodotti.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore nel recupero dei dati dal database");
        }

        return prodotti; //Ritorno della lista di prodotti
    }

    public Prodotto getProdottoById(int id) {
        Prodotto prodotto = null;

        // Tenta la connessione al database
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE id_prodotto = ?");
            ps.setInt(1, id);  // Imposta l'ID del prodotto nella query

            ResultSet rs = ps.executeQuery();

            // Se il risultato esiste, crea l'oggetto Prodotto
            if (rs.next()) {
                prodotto = new Prodotto();
                prodotto.setId(rs.getInt("id_prodotto"));
                prodotto.setNome(rs.getString("nome"));
                prodotto.setDescrizione(rs.getString("descrizione"));
                prodotto.setPrezzo(rs.getDouble("prezzo"));
                prodotto.setQuantita(rs.getInt("quantita"));
                prodotto.setTipologia(rs.getString("tipologia"));
                prodotto.setPreferito(rs.getInt("preferito"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore nel recupero del prodotto dal database");
        }

        return prodotto;  // Ritorna l'oggetto Prodotto (può essere null se non trovato)
    }

    public boolean setPreferitoById(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE prodotto SET preferito = 1 WHERE id_prodotto = ?"
            );
            ps.setInt(1, id);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;  // true se almeno una riga è stata aggiornata
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore nell'aggiornamento del campo preferito", e);
        }
    }

    public boolean removePreferitoById(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE prodotto SET preferito = 0 WHERE id_prodotto = ?"
            );
            ps.setInt(1, id);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;  // true se almeno una riga è stata aggiornata
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore nell'aggiornamento del campo preferito", e);
        }
    }
}
