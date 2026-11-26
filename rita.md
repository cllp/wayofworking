# Rita: dokument, sidor och presentationer i CP:s stil

> Metoden står här, i samma källa som reglerna, så att varje agent i varje repo har den när sessionen startar (CP 2026-11-26: "JAG VILL
> ATT ARBETSSÄTT OCKSÅ INNEHÅLLER HUR VI RITAR (Skissramverk, med profilerna)"). Verktyget, profilernas CSS (`profiler/`) och
> komponenterna stannar i https://github.com/cllp/skissramverk, eftersom `npx` läser dem därifrån. Specens form och komponenterna i
> detalj: https://github.com/cllp/skissramverk/blob/main/skills/skissramverk/SKILL.md.

Gäller Claude, Grok och alla andra agenter som gör dokument åt CP.

## ⛔ Alltid skissramverket, för varje artefakt

CP 2026-11-26, när reglerna samlades här: "vi använder ALLTID skissramverket när vi producerar artefakter och att det finns olika
profiler där", och: "Skissramverket kan utökas vid behov med nya profiler." Avsnitten nedan sa redan hur man gör, men inte att det
gäller utan undantag.

**Regeln:** de artefakter vi producerar är HTML, PNG och PDF, och de görs alltid med skissramverket. Ingen handskriven HTML, ingen
egen mall och ingen annan generator.

- **Agenten frågar vilken profil**, enligt nästa avsnitt. Ramverket har ett tekniskt förval, men det ersätter inte frågan (CP samma
  dag: "Behåll att agenten frågar").
- **Nya profiler läggs till vid behov**, i `cllp/skissramverk` (se "Ändra skissramverket"). I dag finns Redaktionell och LifeHub.
- **Word görs bara i `TAM`**, med en egen profil där, och hör inte till skissramverket.
- **Anteckningar görs i markdown** och är inga artefakter. Detsamma gäller ett svar i chatten.
- **Går något inte att göra i ramverket:** säg det och föreslå en komponent eller en profil. Bygg inte vid sidan av.

## ⛔ Externt eller internt, och alltid en version med datum

CP 2026-11-26: "Information är extern eller intern. I externa artefakter står det inte uppgifter som skall till mig, 'kom ihåg' saker
och annat. Artefakter som skal delas sakall bara vara informativa och rena. Artefakter ersätts inte, bara nya versioner tillkommer.
Alla artefakter har alltid en version med datum och kanske t o m tidsstämpel längst ner subtilt." Samma kväll hade en agent lämnat
ett underlag där det som skulle delas stod blandat med punkter till CP, och fick säga i chatten vilka rader som måste strykas innan
det gick vidare.

- **Bestäm först om artefakten är extern eller intern.** Extern är allt som ska delas med någon annan. Är det oklart: fråga.
- **En extern artefakt är bara informativ och ren.** Inga uppgifter till CP, inga "kom ihåg", inga öppna frågor till honom, inga
  arbetsanteckningar och ingenting om hur den togs fram. Det hör hemma i en intern anteckning i markdown bredvid.
- **Artefakter ersätts aldrig.** En ny version är en ny fil, och de tidigare ligger kvar (se "Det viktigaste").
- **Alltid version och datum, gärna klockslag, längst ner och diskret** (`footer` i specen). Det är till för att veta exakt när
  artefakten producerades. Datumet får också stå i sidhuvudet (`meta`) när läsaren har nytta av det.

## Välj stil med beställaren

**Skissramverket** är namnet på hela verktyget och repot. Det finns två val av stil:

- **Redaktionell:** den ursprungliga stilen från TAM. Ljust papper, serifrubriker,
  salvia och ockra, tunna linjer och lätt skissade accenter.
- **LifeHub:** LifeHubs visuella identitet. Skogsgrönt och kräm, Jost och Inter,
  fyllda kort och raka linjer. Mörk och ljus yta är varianter inom samma profil.

Om beställaren inte uttryckligen har angett stil för dokumentet eller uppdraget,
**fråga innan du skapar eller renderar det**:

> Vilken stil vill du använda: Redaktionell eller LifeHub?

Lista alltid båda alternativen. Gissa inte utifrån projektnamn, repo, tidigare dokument
eller renderarens tekniska förval. Ett uttryckligt stilval för hela det aktuella uppdraget
behöver inte frågas om igen. Om LifeHub är valt men ytan inte angiven kan profilens
tekniska förval användas; mörk och ljus är inte ytterligare stilalternativ.

Skicka `profil: redaktionell` eller `profil: lifehub` uttryckligen i specen. `profil: skiss`,
originalets tekniska id före namnbytet, ger ett fel. Om vald stil inte stöds av den renderare
du kör, säg det och ordna rätt rendererrevision; byt aldrig stil tyst.

## Arbetsgång för ett dokument

1. Läs det aktuella projektets regler och dokumentmappens `_projektminne.md`.
2. Bekräfta stil enligt regeln ovan. Läs https://github.com/cllp/skissramverk/blob/main/skills/skissramverk/SKILL.md för spec och layout.
3. Skriv JSON eller YAML i dokumentets eget repo. Använd komponenterna i README.
4. Rendera med den gemensamma renderaren. Kräv exit 0 och `QA: inga fel`.
5. Öppna och granska varje sid-PNG. Kontrollera innehåll, källor, läsordning och layout.
6. Leverera versionsmärkta filer och uppdatera `_projektminne.md`. Skriv aldrig över
   tidigare dokumentversioner.

## Det viktigaste

- **Ett ramverk, en källa.** Alla sidor, presentationer och beslutsunderlag i CP:s stil görs
  med `cllp/skissramverk`. Kopiera inte ramverket in i andra repon. Finns en gammal kopia,
  använd den inte för nya dokument.
- **Kör det direkt från GitHub** i det repo där dokumentet hör hemma:

  ```
  npx --yes github:cllp/skissramverk <spec.json> <utkatalog>
  ```

- **Innehållet stannar i sitt repo.** Spec, skript, PDF och PNG ligger i projektets repo.
  Till `cllp/skissramverk` går bara ramverket: kod, stil, komponenter och neutrala exempel. Inget
  projektinnehåll, inga namn och inga hemligheter i skissramverket.
- **Specen är källan.** Ändra i JSON eller YAML, aldrig i genererad HTML, PNG eller PDF.
  Ny version blir ny fil, skriv aldrig över en tidigare.
- **Läs projektets regler först.** Varje projektmapp har `_projektminne.md` med
  innehållsregler och versionslogg. Uppdatera det när du gör en ny version.

Hela arbetssättet, stilreglerna, specens form och komponenterna står i
https://github.com/cllp/skissramverk/blob/main/skills/skissramverk/SKILL.md. Läs den innan du gör ett dokument.

## Ändra skissramverket

- Ändringar i ramverket (komponenter, tokens, QA) görs med en liten PR i `cllp/skissramverk`, med
  ett neutralt exempel i `examples/` som visar ändringen.
- Rendera alla exempel innan PR: `npm install && npm run exempel`. QA ska säga "inga fel".
- Ändra inte färger, typsnitt eller typskala utan CP:s ja. Det slår igenom i alla dokument.
- En ändring får inte göra att befintliga specar i andra repon ser annorlunda ut,
  om det inte är syftet och CP har sagt ja.

## CP-regler

- Svenska, kort. Inga tankstreck.
- Inga hemligheter i chatt, kod eller repo.
- Skarpa raderingar, utskick och nya repon kräver CP:s ja.
