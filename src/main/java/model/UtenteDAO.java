package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtenteDAO {
    public static Utente doLogin(String email, String password) throws SQLException {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT idUtente, nome, cognome, email FROM utente WHERE email = ? AND passkey = ?");
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Utente u = new Utente();
                u.setId(rs.getInt("idUtente"));
                u.setNome(rs.getString("nome"));
                u.setCognome(rs.getString("cognome"));
                u.setEmail(rs.getString("email"));
                return u;
            }
            return null;
        }
    }
}
