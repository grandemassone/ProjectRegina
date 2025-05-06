package model;

public class Utente {
    private int idUtente;
    private String nome;
    private String cognome;
    private String email;
    private String passkey;

    //Costruttore, getter e setter
    public Utente() {
    }
    public int getId() {
        return idUtente;
    }
    public void setId(int id_utente) {
        this.idUtente = id_utente;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getCognome() {
        return cognome;
    }
    public void setCognome(String cognome) {
        this.cognome = cognome;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPasskey() {
        return passkey;
    }
    public void setPasskey(String passkey) {
        this.passkey = passkey;
    }
}
