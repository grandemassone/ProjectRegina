package model;

public class Prodotto {
    private int idProdotto;
    private String nome;
    private String descrizione;
    private double prezzo;
    private int quantita;
    private String tipologia;
    private int preferito;

    //Costruttore, setter e getter
    public Prodotto() {}
    public int getId() {
        return idProdotto;
    }
    public void setId(int id) {
        this.idProdotto = id;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getDescrizione() {
        return descrizione;
    }
    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }
    public double getPrezzo() {
        return prezzo;
    }
    public void setPrezzo(double prezzo) {
        if (prezzo > 0) {
            this.prezzo = prezzo;
        } else {
            throw new IllegalArgumentException("Prezzo negativo");
        }
    }
    public int getQuantita() {
        return quantita;
    }
    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }
    public String getTipologia() {
        return tipologia;
    }
    public void setTipologia(String tipologia) {
        this.tipologia = tipologia;
    }
    public int getPreferito() {
        return preferito;
    }
    public void setPreferito(int preferito) {
        if (preferito == 0 || preferito == 1) {
            this.preferito = preferito;
        } else {
            throw new IllegalArgumentException("Il campo 'preferito' può essere solo 0 o 1");
        }
    }
}
