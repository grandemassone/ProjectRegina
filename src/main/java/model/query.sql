-- Attiva db
use db_regina;

-- Tabella principale dei prodotti
CREATE TABLE prodotto
(
    idProdotto  INT PRIMARY KEY,
    nome        VARCHAR(50),
    descrizione VARCHAR(200),
    prezzo      DOUBLE,
    quantita    INT,
    tipologia   VARCHAR(50),
    ingredienti VARCHAR(200)
);
drop table utente;

-- Tabella per gli utenti
CREATE TABLE utente
(
    idUtente INT PRIMARY KEY AUTO_INCREMENT,
    nome     VARCHAR(50)        NOT NULL,
    cognome  VARCHAR(50)        NOT NULL,
    email    VARCHAR(50) UNIQUE NOT NULL,
    passkey  VARCHAR(255)       NOT NULL,
    admin    VARCHAR(20) DEFAULT 'user'
);

-- Tabella per i preferiti
CREATE TABLE preferiti
(
    id_utente   INT NOT NULL,
    id_prodotto INT NOT NULL,
    PRIMARY KEY (id_utente, id_prodotto),
    FOREIGN KEY (id_utente) REFERENCES utente (idUtente),
    FOREIGN KEY (id_prodotto) REFERENCES prodotto (idProdotto)
);

CREATE TABLE ordine
(
    idOrdine    INT AUTO_INCREMENT PRIMARY KEY,
    idUtente    INT,
    data         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    destinatario VARCHAR(100),
    indirizzo    VARCHAR(100),
    citta        VARCHAR(50),
    cap          VARCHAR(10),
    FOREIGN KEY (idUtente) REFERENCES utente (idUtente)
);

CREATE TABLE ordine_dettaglio
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    idOrdine        INT,
    idProdotto      INT,
    quantita        INT,
    prezzo_unitario DOUBLE,
    FOREIGN KEY (idOrdine) REFERENCES ordine (idOrdine),
    FOREIGN KEY (idProdotto) REFERENCES prodotto (idProdotto)
);

-- Query di prova
select * from prodotto;
select * from utente;
select * from preferiti;
select * from ordine;
select * from ordine_dettaglio;

describe prodotto;
describe utente;
describe preferiti;
describe ordine;
describe ordine_dettaglio;