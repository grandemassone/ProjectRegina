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
        try(Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto");
            ResultSet rs = ps.executeQuery();

            //Iterazione sui risultati della query
            while(rs.next()) {
                Prodotto p = new Prodotto();
                p.setId(rs.getInt("idProdotto"));
                p.setNome(rs.getString("nome"));
                p.setDescrizione(rs.getString("descrizione"));
                p.setPrezzo(rs.getDouble("prezzo"));
                p.setQuantita(rs.getInt("quantita"));
                p.setTipologia(rs.getString("tipologia"));
                p.setIngredienti(rs.getString("ingredienti"));
                prodotti.add(p);
            }
        } catch(SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore nel recupero dei dati dal database");
        }

        return prodotti; //Ritorno della lista di prodotti
    }

    public Prodotto getProdottoById(int idProdotto) {
        Prodotto prodotto = null;

        // Tenta la connessione al database
        try(Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE idProdotto = ?");
            ps.setInt(1, idProdotto);  // Imposta l'ID del prodotto nella query

            ResultSet rs = ps.executeQuery();

            // Se il risultato esiste, crea l'oggetto Prodotto
            if(rs.next()) {
                prodotto = new Prodotto();
                prodotto.setId(rs.getInt("idProdotto"));
                prodotto.setNome(rs.getString("nome"));
                prodotto.setDescrizione(rs.getString("descrizione"));
                prodotto.setPrezzo(rs.getDouble("prezzo"));
                prodotto.setQuantita(rs.getInt("quantita"));
                prodotto.setTipologia(rs.getString("tipologia"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore nel recupero del prodotto dal database");
        }

        return prodotto;  // Ritorna l'oggetto Prodotto (può essere null se non trovato)
    }

    public boolean isInPreferiti(int idUtente, int idProdotto) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM preferiti WHERE id_utente = ? AND id_prodotto = ?");
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    public void aggiungiAPreferiti(int idUtente, int idProdotto) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO preferiti (id_utente, id_prodotto) VALUES (?, ?)");
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        }
    }

    public void rimuoviDaPreferiti(int idUtente, int idProdotto) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM preferiti WHERE id_utente = ? AND id_prodotto = ?");
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        }
    }

    public List<Prodotto> doRetrieveAllPreferiti(int idUtente) throws SQLException {
        List<Prodotto> prodotti = new ArrayList<>();

        String sql =
                "SELECT * FROM prodotto JOIN preferiti ON prodotto.idProdotto = preferiti.id_prodotto WHERE preferiti.id_utente = ?";;

        // Stampo in log per sicurezza
        System.out.println("SQL preferiti: " + sql);

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("idProdotto"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setPrezzo(rs.getDouble("prezzo"));
                    p.setQuantita(rs.getInt("quantita"));
                    p.setTipologia(rs.getString("tipologia"));
                    p.setIngredienti(rs.getString("ingredienti"));
                    prodotti.add(p);
                }
            }
        }

        return prodotti;
    }
    public static List<Prodotto> doRetrieveQuantita() throws SQLException {
        List<Prodotto> prodotti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT nome, quantita FROM prodotto");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Prodotto p = new Prodotto();
                p.setNome(rs.getString("nome"));
                p.setQuantita(rs.getInt("quantita"));
                prodotti.add(p);
            }
        }
        return prodotti;
    }
    public static Prodotto doRetrieveById(int id) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE idProdotto = ?");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Prodotto p = new Prodotto();
                p.setId(rs.getInt("idProdotto"));
                p.setNome(rs.getString("nome"));
                p.setDescrizione(rs.getString("descrizione"));
                p.setPrezzo(rs.getDouble("prezzo"));
                p.setQuantita(rs.getInt("quantita"));
                p.setTipologia(rs.getString("tipologia"));
                return p;
            }
            return null;
        }
    }

}