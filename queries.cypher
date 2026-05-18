// ==========================================
// Zadatak 2 — Kreiranje čvorova
// ==========================================

// Kreiranje filmova iz predloška
CREATE (:Film {naslov: 'Inception', godina: 2010, ocjena: 8.8, zanr: 'sci-fi'}),
       (:Film {naslov: 'The Dark Knight', godina: 2008, ocjena: 9.0, zanr: 'akcija'}),
       (:Film {naslov: 'Interstellar', godina: 2014, ocjena: 8.6, zanr: 'sci-fi'}),
       (:Film {naslov: 'Parasite', godina: 2019, ocjena: 8.6, zanr: 'triler'}),
       (:Film {naslov: 'The Godfather', godina: 1972, ocjena: 9.2, zanr: 'drama'}),
       (:Film {naslov: 'Memento', godina: 2000, ocjena: 8.4, zanr: 'triler'});

// Kreiranje osoba iz predloška
CREATE (:Osoba {ime: 'Christopher Nolan', dob: 54}),
       (:Osoba {ime: 'Bong Joon-ho', dob: 55}),
       (:Osoba {ime: 'Francis Ford Coppola', dob: 85}),
       (:Osoba {ime: 'Leonardo DiCaprio', dob: 50}),
       (:Osoba {ime: 'Christian Bale', dob: 50});

// Kreiranje gradova iz predloška
CREATE (:Grad {naziv: 'Los Angeles'}),
       (:Grad {naziv: 'London'}),
       (:Grad {naziv: 'Seoul'});

// TVOJI NOVI ČVOROVI (2 Osobe i 1 Grad)
CREATE (o1:Osoba {ime: 'Michael Caine', dob: 93})
CREATE (o2:Osoba {ime: 'Morgan Freeman', dob: 88})
CREATE (g1:Grad {naziv: 'Paris'})

// UPIT ZA PROVJERU (Ovo obavezno pokreni u Neo4j Browseru i napravi screenshot!)
MATCH (n) RETURN count(n) AS ukupno_cvorova;
// Gradovi iz predloška
CREATE (:Grad {naziv: 'Los Angeles'}),
       (:Grad {naziv: 'London'}),
       (:Grad {naziv: 'Seoul'});

// Moj dodatni grad po vlastitom izboru
CREATE (:Grad {naziv: 'Paris'});

// ==========================================
// Korak 3 — Kreiranje čvorova
// ==========================================
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'The Dark Knight'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Interstellar'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Memento'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Bong Joon-ho'}), (f:Film {naslov: 'Parasite'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Francis Ford Coppola'}), (f:Film {naslov: 'The Godfather'})
CREATE (o)-[:REZIRAO]->(f)

//Kreiranje veza GLUMIO_U:
MATCH (o:Osoba {ime: 'Leonardo DiCaprio'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:GLUMIO_U]->(f);
MATCH (o:Osoba {ime: 'Christian Bale'}), (f:Film {naslov: 'The Dark Knight'})
CREATE (o)-[:GLUMIO_U]->(f);
MATCH (o:Osoba {ime: 'Christian Bale'}), (f:Film {naslov: 'The Dark Knight'})
MERGE (o)-[:GLUMIO_U]->(f)   // MERGE - ne kreira duplikat ako vec postoji


//Kreiranje veza ZIVI_U:
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (g:Grad {naziv: 'London'})
CREATE (o)-[:ZIVI_U]->(g);
MATCH (o:Osoba {ime: 'Leonardo DiCaprio'}), (g:Grad {naziv: 'Los Angeles'})
CREATE (o)-[:ZIVI_U]->(g);
MATCH (o:Osoba {ime: 'Bong Joon-ho'}), (g:Grad {naziv: 'Seoul'})
CREATE (o)-[:ZIVI_U]->(g)

//Kreiranje veza PRIJATELJ (s property-em):
MATCH (a:Osoba {ime: 'Christopher Nolan'}), (b:Osoba {ime: 'Christian Bale'})
CREATE (a)-[:PRIJATELJ {od: 2000}]->(b);
MATCH (a:Osoba {ime: 'Leonardo DiCaprio'}), (b:Osoba {ime: 'Christopher Nolan'})
CREATE (a)-[:PRIJATELJ {od: 2010}]->(b)

//Nakon unosa, vizualizirajte graf u Neo4j Browseru pokretanjem:
MATCH (n)-[r]->(m) RETURN n, r, m

//11.	dodati veze GLUMIO_U za dva čvora Osoba koje ste sami kreirali u Zadatku 2 (povežite ih s postojećim ili novim filmovima)
// Povezivanje Michaela Cainea s filmovima The Dark Knight i Inception
MATCH (o:Osoba {ime: 'Michael Caine'}), (f1:Film {naslov: 'The Dark Knight'}) CREATE (o)-[:GLUMIO_U]->(f1);
MATCH (o:Osoba {ime: 'Michael Caine'}), (f2:Film {naslov: 'Inception'}) CREATE (o)-[:GLUMIO_U]->(f2);
// Povezivanje Morgana Freemana s filmom The Dark Knight
MATCH (o:Osoba {ime: 'Morgan Freeman'}), (f:Film {naslov: 'The Dark Knight'}) CREATE (o)-[:GLUMIO_U]->(f);

// Provjera ukupnog broja veza po tipu
MATCH ()-[r]->() RETURN type(r) AS tip, count(*) AS broj ORDER BY broj DESC;


//Svi filmovi u bazi:
MATCH (f:Film)
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.ocjena DESC

//Filmovi s ocjenom većom od 8.7:
MATCH (f:Film)
WHERE f.ocjena > 8.7
RETURN f.naslov, f.ocjena
ORDER BY f.ocjena DESC

//Svi filmovi određenog redatelja:
MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WHERE o.ime = 'Christopher Nolan'
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.godina

//Tko je glumio u sci-fi filmovima:
MATCH (o:Osoba)-[:GLUMIO_U]->(f:Film)
WHERE f.zanr = 'sci-fi'
RETURN o.ime AS glumac, f.naslov AS film

//Filmovi i njihovi redatelji — obostrani prikaz:
MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
RETURN o.ime AS redatelj, collect(f.naslov) AS filmovi
ORDER BY redatelj

//OPTIONAL MATCH — čvorovi koji možda nemaju vezu:
MATCH (o:Osoba)
OPTIONAL MATCH (o)-[:REZIRAO]->(f:Film)
RETURN o.ime, count(f) AS broj_reziranih_filmova
ORDER BY broj_reziranih_filmova DESC



Zadatak 4
//1.	pronaći sve filmove žanra 'triler' sortirane po godini uzlazno
MATCH (f:Film)
WHERE f.zanr = 'triler'
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.godina ASC;

//1.	pronaći ime redatelja i naziv grada u kojem živi (MATCH s dvije veze u nizu)
MATCH (o:Osoba)-[:REZIRAO]->(:Film)
MATCH (o)-[:ZIVI_U]->(g:Grad)
RETURN DISTINCT o.ime AS redatelj, g.naziv AS grad;

//15.	pronaći sve filmove snimljene između 2008. i 2015. godine (WHERE s AND uvjetom)
MATCH (f:Film)
WHERE f.godina >= 2008 AND f.godina <= 2015
RETURN f.naslov, f.godina;

//16.	pronaći redatelje koji su snimili više od jednog filma (koristite collect ili count)
MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WITH o.ime AS redatelj, count(f) AS broj_filmova
WHERE broj_filmova > 1
RETURN redatelj, broj_filmova;


-------------------
//Varijabilna dužina puta — tko je u dvije veze od filma Inception
MATCH (f:Film {naslov: 'Inception'})-[*1..2]-(n)
RETURN DISTINCT labels(n) AS tip, n.naslov AS naslov, n.ime AS ime

//Najkraći put između dvije osobe:
MATCH p = shortestPath(
  (a:Osoba {ime: 'Christopher Nolan'})
  -[*]-
  (b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p) AS duljina_puta

//nisu povezani

//Postoji li direktna veza između dviju osoba:
MATCH (a:Osoba {ime: 'Leonardo DiCaprio'})
MATCH (b:Osoba {ime: 'Christopher Nolan'})
RETURN EXISTS {
  MATCH (a)-[:PRIJATELJ|GLUMIO_U|ZIVI_U*1..3]-(b)
} AS povezani

//true

//Svi putovi između dvije osobe — ne samo najkraći:
MATCH p = (a:Osoba {ime: 'Leonardo DiCaprio'})
          -[*1..4]-
          (b:Osoba {ime: 'Bong Joon-ho'})
RETURN p, length(p) AS duljina
ORDER BY duljina
LIMIT 5



//Zadatak 5 — Putovi i traversal
//18.	pronaći najkraći put između Leonarda DiCaprija i Bong Joon-hoa i napraviti screenshot vizualizacije puta
MATCH p = shortestPath((a:Osoba {ime: 'Leonardo DiCaprio'})-[*]-(b:Osoba {ime: 'Bong Joon-ho'}))
RETURN p;
//provjera povezanosti
MATCH (a:Osoba {ime: 'Leonardo DiCaprio'})
MATCH (b:Osoba {ime: 'Bong Joon-ho'})
RETURN EXISTS {
  MATCH (a)-[:PRIJATELJ|GLUMIO_U|ZIVI_U*1..3]-(b)
} AS povezani

//false -nisu povezani

//19.	pronaći sve čvorove koji su u najviše 2 veze udaljeni od čvora Grad {naziv: 'London'}
MATCH (g:Grad {naziv: 'London'})-[*1..2]-(n)
RETURN DISTINCT labels(n) AS tip, coalesce(n.naslov, n.ime, n.naziv) AS naziv;

//20.	provjeriti jesu li Francis Ford Coppola i Leonardo DiCaprio međusobno povezani u najviše 4 koraka
MATCH (a:Osoba {ime: 'Francis Ford Coppola'}), (b:Osoba {ime: 'Leonardo DiCaprio'})
RETURN EXISTS { MATCH (a)-[*1..4]-(b) } AS povezani;

//21.	u ODGOVORI.md objasniti što se dogodi ako shortestPath ne pronađe put između dva čvora i što vraća upit (1–2 rečenice)


//Korak 6 — Agregacije s WITH
//Broj filmova po žanru:
MATCH (f:Film)
RETURN f.zanr AS zanr, count(f) AS broj_filmova
ORDER BY broj_filmova DESC

//Prosječna ocjena po žanru — samo žanrovi s više od jednog filma:
MATCH (f:Film)
WITH f.zanr AS zanr, count(f) AS broj, avg(f.ocjena) AS prosjecna_ocjena
WHERE broj > 1
RETURN zanr, broj, round(prosjecna_ocjena * 10) / 10 AS ocjena
ORDER BY prosjecna_ocjena DESC


//Redatelji s brojem filmova i listom naslova:
MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WITH o.ime AS redatelj, count(f) AS filmova, collect(f.naslov) AS naslovi
RETURN redatelj, filmova, naslovi
ORDER BY filmova DESC

//Top 3 filma po ocjeni za svaki žanr:
MATCH (f:Film)
WITH f.zanr AS zanr, collect(f ORDER BY f.ocjena DESC)[0..3] AS top_filmovi
RETURN zanr,
       [film IN top_filmovi | film.naslov + ' (' + toString(film.ocjena) + ')']
       AS top3

//// ======================================================================================
// NAPOMENA O SYNTAX ERRORU (collect):
// Stari upit je bacao grešku jer funkcija collect() u Cypheru ne dopušta unutar sebe ORDER BY.
// Popravak: Prvo sortiramo filmove pomoću WITH, a tek onda radimo collect() nad sortiranim nizom.
// ======================================================================================
MATCH (f:Film)
WITH f ORDER BY f.ocjena DESC
WITH f.zanr AS zanr, collect(f)[0..3] AS top_filmovi
RETURN zanr, [film IN top_filmovi | film.naslov + ' (' + toString(film.ocjena) + ')'] AS top3;


Zadatak 6 — Agregacije
22.	prikazati ukupan broj filmova i prosječnu ocjenu svih filmova u bazi (jedan upit, bez grupiranja)
23.	prikazati broj filmova po žanru i maksimalnu ocjenu unutar svakog žanra (WITH + max)
24.	pronaći osobu koja živi u gradu s najviše osoba — koristite WITH i ORDER BY count DESC LIMIT 1
25.	prikazati listu svih glumaca za svaki film (MATCH s vezom GLUMIO_U, collect glumaca po filmovima)
// ==========================================
// Zadatak 6 — Agregacije
// ==========================================

// 1. Ukupan broj filmova i prosječna ocjena svih filmova u bazi
MATCH (f:Film)
RETURN count(f) AS ukupan_broj_filmova, avg(f.ocjena) AS prosjecna_ocjena;

// 2. Broj filmova po žanru i maksimalna ocjena unutar svakog žanra
MATCH (f:Film)
WITH f.zanr AS zanr, count(f) AS broj_filmova, max(f.ocjena) AS maksimalna_ocjena
RETURN zanr, broj_filmova, maksimalna_ocjena
ORDER BY broj_filmova DESC;

// 3. Osoba koja živi u gradu s najviše osoba
MATCH (o:Osoba)-[:ZIVI_U]->(g:Grad)
WITH g, count(o) AS broj_stanovnika
ORDER BY broj_stanovnika DESC
LIMIT 1
MATCH (stanovnik:Osoba)-[:ZIVI_U]->(g)
RETURN stanovnik.ime AS ime_osobe, g.naziv AS najpopularniji_grad;

// 4. Lista svih glumaca za svaki film
MATCH (o:Osoba)-[:GLUMIO_U]->(f:Film)
RETURN f.naslov AS film, collect(o.ime) AS lista_glumaca;

// ======================================================================================
// NAPOMENA O SYNTAX ERRORU (collect):
// Stari upit iz predloška je bacao grešku jer funkcija collect() u Cypheru ne dopušta unutar sebe ORDER BY.
// Popravak: Prvo sortiramo filmove pomoću WITH, a tek onda radimo collect() nad sortiranim nizom.
// ======================================================================================
MATCH (f:Film)
WITH f ORDER BY f.ocjena DESC
WITH f.zanr AS zanr, collect(f)[0..3] AS top_filmovi
RETURN zanr, [film IN top_filmovi | film.naslov + ' (' + toString(film.ocjena) + ')'] AS top3;


//Korak 7 — Indeksi i Constraints
//Kreiranje RANGE indeksa za pretragu filmova po ocjeni:
CREATE INDEX film_ocjena FOR (f:Film) ON (f.ocjena);
CREATE INDEX film_naslov FOR (f:Film) ON (f.naslov);
CREATE INDEX osoba_ime FOR (o:Osoba) ON (o.ime)

//Kreiranje UNIQUENESS constraint-a — osigurava jedinstvenost naslova:
CREATE CONSTRAINT film_naslov_unique
FOR (f:Film) REQUIRE f.naslov IS UNIQUE

//Kreiranje NOT NULL constraint-a — naslov filma mora uvijek postojati:
CREATE CONSTRAINT film_naslov_nn
FOR (f:Film) REQUIRE f.naslov IS NOT NULL

//Provjera svih indeksa i constraint-a u bazi:

SHOW INDEXES
SHOW CONSTRAINTS

//Test MERGE s constraint-om — pokušajmo dodati film s naslovom koji već postoji:

// Ovo ce baciti gresku jer Inception vec postoji (UNIQUE constraint)
CREATE (f:Film {naslov: 'Inception', godina: 2025, ocjena: 5.0})

// MERGE ce pronaci postojeci film umjesto kreiranja duplikata:
MERGE (f:Film {naslov: 'Inception'})
ON MATCH SET f.opis = 'Klasik Christophera Nolana'
ON CREATE SET f.godina = 2010, f.ocjena = 8.8
RETURN f

MERGE s ON MATCH i ON CREATE 
klauzulama je posebno korisno za upsert operacije — update ako čvor postoji, insert ako ne postoji. Ovo je čest pattern u ETL pipelinima koji učitavaju podatke u Neo4j.


// ======================================================================================
// Zadatak 7 — Indeksi i Constraints
// ======================================================================================

// Uspješno kreiranje NOT NULL ograničenja na naslov filma
CREATE CONSTRAINT film_naslov_nn FOR (f:Film) REQUIRE f.naslov IS NOT NULL;

// --------------------------------------------------------------------------------------
// NAPOMENA O GREŠCI (Neo.ClientError.Schema.IndexAlreadyExists):
// Sljedeća naredba bi bacila grešku jer u bazi već postoji obični indeks "film_naslov":
// CREATE CONSTRAINT film_naslov_unique FOR (f:Film) REQUIRE f.naslov IS UNIQUE;
//
// OBJAŠNJENJE: UNIQUE constraint u Neo4j-u u pozadini automatski pokušava kreirati vlastiti 
// indeks jedinstvenosti. Budući da isti indeks već postoji na polju f.naslov, baza brani 
// kreiranje constrainta dok se obični indeks prvo ne ukloni naredbom DROP INDEX.
// Ova naredba je stoga svjesno preskočena kako se ne bi narušila struktura grafa.
// --------------------------------------------------------------------------------------

// Kreiranje ostalih važećih indeksa
CREATE INDEX film_ocjena FOR (f:Film) ON (f.ocjena);
CREATE INDEX osoba_ime FOR (o:Osoba) ON (o.ime);

// Provjera trenutnog stanja svih ograničenja u sustavu
SHOW CONSTRAINTS;

// ======================================================================================
// Zadatak 7 — Indeksi i Constraints
// ======================================================================================

// --------------------------------------------------------------------------------------
// NAPOMENA O GREŠCI (Property existence constraint requires Neo4j Enterprise Edition):
// Sljedeća naredba za NOT NULL ograničenje je zakomentirana jer Community Edition (besplatna verzija)
// ne podržava provjeru postojanja svojstva (NODE PROPERTY EXISTENCE):
//
// CREATE CONSTRAINT film_naslov_nn FOR (f:Film) REQUIRE f.naslov IS NOT NULL;
// --------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------
// NAPOMENA O GREŠCI (Neo.ClientError.Schema.IndexAlreadyExists):
// Sljedeća naredba bi također bacila grešku jer u bazi već postoji obični indeks "film_naslov":
//
// CREATE CONSTRAINT film_naslov_unique FOR (f:Film) REQUIRE f.naslov IS UNIQUE;
// --------------------------------------------------------------------------------------

// Kreiranje bazičnih indeksa koji provjereno rade u besplatnoj (Community) verziji:
CREATE INDEX film_ocjena FOR (f:Film) ON (f.ocjena);
CREATE INDEX osoba_ime FOR (o:Osoba) ON (o.ime);

// Provjera trenutnog stanja svih ograničenja i indeksa u sustavu
SHOW INDEXES;



-----------------------------------
//Završni zadatak — vlastiti graf: Glazbena scena
// =============================================================================
// ZAVRŠNI ZADATAK — GLAZBENA SCENA
// =============================================================================

// 1. KREIRANJE CONSTRAINT-A I INDEKSA (Zahtjev iz zadatka)
CREATE CONSTRAINT izvodac_ime_unique FOR (i:Izvodac) REQUIRE i.ime IS UNIQUE;
CREATE INDEX album_ocjena_idx FOR (a:Album) ON (a.ocjena);


// 2. UNOS PODATAKA (6 Izvođača, 4 Žanra, 10 Albuma + Veze)

// Kreiranje čvorova: Žanrovi (minimalno 4)
CREATE (z1:Zanr {naziv: 'Rock'})
CREATE (z2:Zanr {naziv: 'Heavy Metal'})
CREATE (z3:Zanr {naziv: 'Grunge'})
CREATE (z4:Zanr {naziv: 'Electronic'});

// Kreiranje čvorova: Izvođači (minimalno 6)
CREATE (i1:Izvodac {ime: 'Pink Floyd', drzava: 'UK', godina_osnivanja: 1965})
CREATE (i2:Izvodac {ime: 'Led Zeppelin', drzava: 'UK', godina_osnivanja: 1968})
CREATE (i3:Izvodac {ime: 'Metallica', drzava: 'USA', godina_osnivanja: 1981})
CREATE (i4:Izvodac {ime: 'Iron Maiden', drzava: 'UK', godina_osnivanja: 1975})
CREATE (i5:Izvodac {ime: 'Nirvana', drzava: 'USA', godina_osnivanja: 1987})
CREATE (i6:Izvodac {ime: 'Daft Punk', drzava: 'France', godina_osnivanja: 1993});

// Kreiranje čvorova: Albumi (minimalno 10) i veza OBJAVIO (minimalno 10)
MATCH (i:Izvodac {ime: 'Pink Floyd'}), (z:Zanr {naziv: 'Rock'})
CREATE (a:Album {naziv: 'The Dark Side of the Moon', godina: 1973, ocjena: 9.6})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);

MATCH (i:Izvodac {ime: 'Pink Floyd'}), (z:Zanr {naziv: 'Rock'})
CREATE (a:Album {naziv: 'Wish You Were Here', godina: 1975, ocjena: 9.5})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);

MATCH (i:Izvodac {ime: 'Led Zeppelin'}), (z:Zanr {naziv: 'Rock'})
CREATE (a:Album {naziv: 'Led Zeppelin IV', godina: 1971, ocjena: 9.3})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);

MATCH (i:Izvodac {ime: 'Led Zeppelin'}), (z:Zanr {naziv: 'Rock'})
CREATE (a:Album {naziv: 'Physical Graffiti', godina: 1975, ocjena: 8.8})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);

MATCH (i:Izvodac {ime: 'Metallica'}), (z:Zanr {naziv: 'Heavy Metal'})
CREATE (a:Album {naziv: 'Master of Puppets', godina: 1986, ocjena: 9.4})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);

MATCH (i:Izvodac {ime: 'Metallica'}), (z:Zanr {naziv: 'Heavy Metal'})
CREATE (a:Album {naziv: 'Ride the Lightning', godina: 1984, ocjena: 9.1})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);

MATCH (i:Izvodac {ime: 'Iron Maiden'}), (z:Zanr {naziv: 'Heavy Metal'})
CREATE (a:Album {naziv: 'The Number of the Beast', godina: 1982, ocjena: 9.0})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);

MATCH (i:Izvodac {ime: 'Iron Maiden'}), (z:Zanr {naziv: 'Heavy Metal'})
CREATE (a:Album {naziv: 'Powerslave', godina: 1984, ocjena: 8.9})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);

MATCH (i:Izvodac {ime: 'Nirvana'}), (z:Zanr {naziv: 'Grunge'})
CREATE (a:Album {naziv: 'Nevermind', godina: 1991, ocjena: 9.5})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);

MATCH (i:Izvodac {ime: 'Daft Punk'}), (z:Zanr {naziv: 'Electronic'})
CREATE (a:Album {naziv: 'Random Access Memories', godina: 2013, ocjena: 8.6})
CREATE (i)-[:OBJAVIO]->(a), (a)-[:PRIPADA_ZANRU]->(z);


// Kreiranje veza SLICAN (minimalno 4)
MATCH (i1:Izvodac {ime: 'Pink Floyd'}), (i2:Izvodac {ime: 'Led Zeppelin'}) CREATE (i1)-[:SLICAN]->(i2);
MATCH (i1:Izvodac {ime: 'Metallica'}), (i2:Izvodac {ime: 'Iron Maiden'}) CREATE (i1)-[:SLICAN]->(i2);
MATCH (i1:Izvodac {ime: 'Nirvana'}), (i2:Izvodac {ime: 'Led Zeppelin'}) CREATE (i1)-[:SLICAN]->(i2);
MATCH (i1:Izvodac {ime: 'Metallica'}), (i2:Izvodac {ime: 'Led Zeppelin'}) CREATE (i1)-[:SLICAN]->(i2);

// Kreiranje veza SURAĐIVAO_S (minimalno 2)
MATCH (i1:Izvodac {ime: 'Pink Floyd'}), (i2:Izvodac {ime: 'Daft Punk'}) CREATE (i1)-[:SURAĐIVAO_S]->(i2);
MATCH (i1:Izvodac {ime: 'Metallica'}), (i2:Izvodac {ime: 'Nirvana'}) CREATE (i1)-[:SURAĐIVAO_S]->(i2);


// =============================================================================
// OBAVEZNI UPITI ZA ROZISTAVANJE GRAFA
// =============================================================================

// Zadatak 1: MATCH upit za sve albume određenog izvođača sortirane po godini
MATCH (i:Izvodac {ime: 'Pink Floyd'})-[:OBJAVIO]->(a:Album)
RETURN a.naziv AS Album, a.godina AS Godina, a.ocjena AS Ocjena
ORDER BY a.godina ASC;

// Zadatak 2: MATCH upit s WHERE uvjetom koji filtrira albume s ocjenom > 8.0
MATCH (a:Album)
WHERE a.ocjena > 8.0
RETURN a.naziv AS Album, a.ocjena AS Ocjena
ORDER BY a.ocjena DESC;

// Zadatak 3: OPTIONAL MATCH za prikaz izvođača s brojem objavljenih albuma (uključujući i 0 albuma)
// (Dodajemo privremenog izvođača bez albuma kako bi se vidio efekt OPTIONAL MATCH-a)
CREATE (:Izvodac {ime: 'Testni Bend Bez Albuma', drzava: 'HR', godina_osnivanja: 2026});

MATCH (i:Izvodac)
OPTIONAL MATCH (i)-[:OBJAVIO]->(a:Album)
RETURN i.ime AS Izvođač, count(a) AS Broj_Albuma
ORDER BY Broj_Albuma DESC;

// Zadatak 4: shortestPath između dva izvođača kroz veze SLICAN i SURAĐIVAO_S
MATCH p = shortestPath((i1:Izvodac {ime: 'Daft Punk'})-[*]-(i2:Izvodac {ime: 'Iron Maiden'}))
RETURN p, length(p) AS duljina_puta;

// Zadatak 5: Agregacijski upit - broj albuma i prosječna ocjena po žanru (filtrirano > 7.5)
MATCH (a:Album)-[:PRIPADA_ZANRU]->(z:Zanr)
WITH z.naziv AS Žanr, count(a) AS Broj_Albuma, avg(a.ocjena) AS Prosječna_Ocjena
WHERE Prosječna_Ocjena > 7.5
RETURN Žanr, Broj_Albuma, round(Prosječna_Ocjena * 10) / 10 AS Zaokružena_Ocjena
ORDER BY Zaokružena_Ocjena DESC;

```
