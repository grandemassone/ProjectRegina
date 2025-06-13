-- Attiva db
use db_regina;

-- Tabella principale dei prodotti
CREATE TABLE prodotto
(
    id_prodotto INT PRIMARY KEY,
    nome        VARCHAR(50),
    descrizione VARCHAR(200),
    prezzo      DOUBLE,
    quantita    INT,
    tipologia   VARCHAR(50),
    ingredienti VARCHAR(200)
);

-- Tabella per gli utenti
CREATE TABLE utente
(
    id_utente INT PRIMARY KEY,
    nome      VARCHAR(50)        NOT NULL,
    cognome   VARCHAR(50)        NOT NULL,
    email     VARCHAR(50) UNIQUE NOT NULL,
    passkey   VARCHAR(255)       NOT NULL
);

-- Tabella per i preferiti
CREATE TABLE preferiti
(
    id_utente   INT NOT NULL,
    id_prodotto INT NOT NULL,
    PRIMARY KEY (id_utente, id_prodotto),
    FOREIGN KEY (id_utente) REFERENCES utente (id_utente),
    FOREIGN KEY (id_prodotto) REFERENCES prodotto (id_prodotto)
);

-- Query di prova
select * from prodotto;
select * from utente;
select * from preferiti;

describe prodotto;
describe utente;
describe preferiti;