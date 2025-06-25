package model.preferiti;

import model.ConPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PreferitiDAO {

    public static boolean isInPreferiti(int idUtente, int idProdotto) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT 1 FROM preferiti WHERE id_utente = ? AND id_prodotto = ?");
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    public static void aggiungiAPreferiti(int idUtente, int idProdotto) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO preferiti (id_utente, id_prodotto) VALUES (?, ?)");
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        }
    }

    public static void rimuoviDaPreferiti(int idUtente, int idProdotto) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM preferiti WHERE id_utente = ? AND id_prodotto = ?");
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        }
    }

    public static List<Integer> getIdPreferiti(int idUtente) throws SQLException {
        List<Integer> ids = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT id_prodotto FROM preferiti WHERE id_utente = ?");
            ps.setInt(1, idUtente);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ids.add(rs.getInt("id_prodotto"));
            }
        }
        return ids;
    }
}
