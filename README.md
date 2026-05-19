#*Neo4j_vjezba*
Ovaj projekt prikazuje modeliranje podataka i izvršavanje Cypher upita unutar Neo4j graf baze. Fokus je na povezivanju entiteta (osobe, filmovi, gradovi), postavljanju indeksa i ograničenja te vizualizaciji rezultata.

Za podizanje okruženja potreban je Docker Desktop.

U terminalu pozicioniranom u korijenski direktorij pokrenite:
docker compose up -d
Otvorite Neo4j Browser na adresi: http://localhost:7474
(Podaci za prijavu nalaze se unutar docker-compose.yml datoteke).

Struktura repozitorija:
docker-compose.yml – Konfiguracija Neo4j Docker kontejnera.
queries.cypher – Svi korišteni upiti (unos, povezivanje, pretraga).
ODGOVORI.md – Tekstualni odgovori na zadana pitanja.
Screenshots/ – Snimke zaslona grafičkih prikaza i rezultata iz baze.


Unos čvorova i definirati relacije između njih.
Rad s indeksima i ograničenjima (Constraints) za optimizaciju performansi.
Filtriranje i analiza podataka kroz vizualni graf u Neo4j Browseru.
