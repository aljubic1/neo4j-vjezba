# *Neo4j_vjezba*

Ovaj projekt prikazuje modeliranje podataka i izvršavanje Cypher upita unutar Neo4j graf baze. Fokus je na povezivanju entiteta (osobe, filmovi, gradovi), postavljanju indeksa i ograničenja te vizualizaciji rezultata.

Za podizanje okruženja potreban je Docker Desktop.

1. U terminalu pozicioniranom u korijenski direktorij pokrenite:
docker compose up -d
2. Otvorite Neo4j Browser na adresi: http://localhost:7474
(Podaci za prijavu nalaze se unutar docker-compose.yml datoteke).

Struktura repozitorija:
* docker-compose.yml – Konfiguracija Neo4j Docker kontejnera.
* queries.cypher – Svi korišteni upiti (unos, povezivanje, pretraga).
* ODGOVORI.md – Tekstualni odgovori na zadana pitanja.
* Screenshots/ – Snimke zaslona grafičkih prikaza i rezultata iz baze.

