package model.ordine;

import model.prodotto.Prodotto;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

public class Ordine {

    private int id;
    private int idUtente;
    private Timestamp data;
    private String destinatario;
    private String indirizzo;
    private String citta;
    private String cap;

    private Map<Prodotto, Integer> prodotti = new HashMap<>();

    // Getter e Setter classici

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public Timestamp getData() {
        return data;
    }

    public void setData(Timestamp data) {
        this.data = data;
    }

    public String getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(String destinatario) {
        this.destinatario = destinatario;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getCitta() {
        return citta;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }

    public String getCap() {
        return cap;
    }

    public void setCap(String cap) {
        this.cap = cap;
    }
    
    public void setProdotti(Map<Prodotto, Integer> prodotti) {
        this.prodotti = prodotti;
    }
}
