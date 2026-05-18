### Zadatak 1 — Ports (Portovi)
[cite_start]Neo4j standardno eksponira dva glavna porta za komunikaciju i rad s bazom:

1. [cite_start]**Port 7474 (HTTP)** [cite: 37] [cite_start]— Služi za pristup **Neo4j Browseru**, odnosno vizualnom web sučelju baze podataka[cite: 37]. [cite_start]Kroz ovaj port u pregledniku (na adresi `http://localhost:7474`) pišemo Cypher upite, upravljamo bazom i vizualiziramo grafove[cite: 37, 38, 48].
2. [cite_start]**Port 7687 (Bolt)** [cite: 39] [cite_start]— Služi za **Bolt protokol**, što je binarni protokol visokih performansi koji koriste aplikacijski programski driveri[cite: 39]. [cite_start]Preko ovog porta aplikacije pisane u jezicima kao što su Python, Java, JavaScript ili C# direktno komuniciraju i razmjenjuju podatke s Neo4j bazom[cite: 39].

### Zadatak 2 — Razlika između CREATE i MERGE
* **CREATE**: Ova naredba bezuvjetno kreira novi čvor ili vezu u grafu svaki put kada se pokrene. Čak i ako u bazi već postoji čvor s potpuno istim imenom i svojstvima (npr. grad 'Paris'), `CREATE` će napraviti još jedan identičan čvor, što dovodi do dupliciranja podataka.
* **MERGE**: Ova naredba radi po principu "pronađi ili kreiraj" (idempotentna operacija). Prije nego što bilo što napravi, `MERGE` prvo pretražuje graf kako bi provjerio postoji li već čvor s tim svojstvima. Ako ga pronađe, samo ga dohvaća i ne radi ništa; ako ga ne pronađe, tek ga tada kreira. `MERGE` se koristi za sprječavanje nastanka duplikata u bazi podataka.

### Zadatak 4 — Razlika između MATCH i OPTIONAL MATCH
* **MATCH**: Djeluje kao strogi filtar u grafu (slično kao INNER JOIN u SQL-u). Ako tražimo određeni uzorak (npr. Osoba i njezin Grad), `MATCH` će vratiti samo one retke gdje taj uzorak u potpunosti postoji. Ako neka osoba nema vezu prema gradu, ona će biti potpuno izbačena iz rezultata upita.
* **OPTIONAL MATCH**: Djeluje fleksibilnije (slično kao LEFT JOIN u SQL-u). Ona će pokušati pronaći traženi uzorak ili vezu, ali ako veza ne postoji, upit neće izbaciti polazni čvor iz rezultata. Umjesto toga, vratit će polazni čvor, dok će za dijelove grafa koji nedostaju jednostavno prikazati vrijednost `null`.

// Zadatak 5
U bazi podataka ne postoji nikakva izravna ni neizravna veza između Leonarda DiCaprija i Bong Joon-hoa, stoga upit opravdano vraća prazan rezultat.
### Zadatak 5 — Putovi i traversal

1. **Najkraći put (Leonardo DiCaprio — Bong Joon-ho):**
   U bazi podataka ne postoji izravna niti neizravna veza između ova dva čvora, zbog čega upit opravdano vraća prazan rezultat (*No changes, no records*).

4. **Ponašanje funkcije shortestPath ako put ne postoji:**
   Ako funkcija `shortestPath` ne uspije pronaći nijednu valjanu putanju između dva tražena čvora, upit neće javiti pogrešku niti prekinuti izvršavanje. Baza podataka će uspješno završiti rad, ali će rezultat biti prazan (vratit će 0 redaka), dok će sama varijabla puta poprimiti vrijednost `null`.


   ## Odgovor na Završni zadatak — Glazbena scena

Neo4j bismo za glazbenu bazu podataka koristili umjesto PostgreSQL-a u scenarijima gdje su nam fokus društvene veze, preporuke i duboki traversali kroz mrežu entiteta. Dok se PostgreSQL odlično snalazi s strukturiranim, izoliranim tablicama, problem preporuka ("korisnici koji slušaju bend X, također slušaju i bend Y") u relacijskim bazama zahtijeva višestruke i skupe `JOIN` operacije nad tablicama veza. 

Specifičan problem koji je izuzetno teško i neučinkovito riješiti relacijskim pristupom jest pronalazak putova i preporuka zasnovanih na sličnosti i suradnji (npr. algoritam najkraćeg puta ili preporuke "prijatelj mog prijatelja"). U PostgreSQL-u bi traženje poveznice između dva izvođača kroz neodređen broj koraka (veza `SLICAN` ili `SURAĐIVAO_S`) zahtijevalo pisanje kompleksnih rekurzivnih CTE upita (Common Table Expressions). Ti upiti eksponencijalno gube na performansama s povećanjem dubine pretraživanja jer baza mora konstantno spajati tablice unutar memorije. Neo4j ovaj problem rješava u milisekundama jer su veze pohranjene kao fizički pointeri na disku, pa pronalaženje algoritama poput `shortestPath` ovisi isključivo o veličini lokalne okoline u grafu, a ne o ukupnom broju zapisa u bazi podataka.

