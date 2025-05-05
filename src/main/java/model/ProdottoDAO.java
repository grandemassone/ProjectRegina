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


}
