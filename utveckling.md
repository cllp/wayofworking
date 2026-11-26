# Utveckling: Life Hub, ramverket och apparna

> Gäller de repon där vi bygger kod: `lifehub.app`, `lifehub.identity`, `lifehub.native`, `ops-framework`, `skissramverk` och de appar
> som bygger på ramverket. Reglerna i [samarbete.md](samarbete.md) och [arbetsregler.md](arbetsregler.md) gäller också, och först. Avsnitten nedan flyttades hit ordagrant ur `cllp/lifehub.app`
> `CLAUDE.md` 2026-11-26. Sökvägar som `functions/config.js` avser lifehub.app.

## Visionen: varför vi bygger det här

CP 2026-10-24: "Jag vill få dom många att arbeta bättre tillsammans, och genom enkla
verktyg organisera sig bättre, oavsett arbetsområde så att var och en kan får möjlighet
att koncentrera sig på det viktiga och kreativa och mindre tid framför en skärm."

> Vi hjälper människor att arbeta bättre tillsammans. Med enkla verktyg organiserar sig
> varje grupp, oavsett vad den gör, så att var och en får mer tid för det viktiga och
> kreativa, och mindre tid framför en skärm.

### Hur: två vägar in, och agenten är den första

1. **Agenten gör jobbet och hittar åt dig.** Det är huvudvägen. Du säger något i TALK
   och det blir ett ärende, en händelse eller ett meddelande. Agenten svarar på "när kan
   vi ses?" och "visa allt om bokningen i juli" i stället för att du letar. Agenten
   arbetar vidare i gruppen medan du gör annat.
2. **Visuella hjälpmedel är den andra vägen in.** Taggar, filter, sök och vyer som Idag
   och Dagen finns för den som vill se själv. De ska vara enkla, och de får inte bli
   det man måste gå igenom för att få något gjort.
3. **Ibland måste man lägga till något för att det ska gå att hitta.** En tagg gör en
   post möjlig att hitta oavsett vem som letar, också för agenten. Det är okej att be
   om det, men då måste det gå på ett tryck, eller göras åt en av agenten.
4. **Samma grund, oavsett arbetsområde.** Hubbar och grupper bär ett bolag, en familj,
   en förening, ett studieförbund och en bokningsverksamhet med samma ramverk. Det som
   bara en sorts verksamhet behöver hör till en hubb eller en app, inte till grunden.

### Frågan till varje ärende

**Gör det här att någon tittar mindre på skärmen, eller mer?**

- Det som minskar skärmtiden får förtur: agenten som gör jobbet, påminnelser som
  kommer av sig själva, sammanfattningar i stället för listor.
- Det som ökar skärmtiden (ett val till, en vy till, ett filter till) får motivera sig i
  ärendet: varför det inte kan lösas av agenten, och varför det är värt en sak till att
  titta på.
- Skriv svaret i ärendet eller PR-texten. Ett ärende som inte kan svara är inte klart
  att bygga.

---

## FÖRST AV ALLT: TAVLAN VISAR VAD DU GÖR, OCH DEV-CHATTEN ÄR DÄR DU ARBETAR. VARJE STEG, VARJE KÖRNING.

CP 2026-11-21, i gruppen Dev: "Alla agenter som jobbar i LIfe Hub och jobbar med ett ärende måste dra ut issues i rätt status så att det syns på
boarden. Då ser alla i realtid vad vi jobbar med och inte. Detta måste följa varje steg. Annars failar det." Strax efter: "Nu har jag lagt in ärenden i
backlog. Därifrån plockar agenter sina uppgifter." Och till Claude: "skriv också in att agenter jobbar i dev-chatten. Den instruktionen finns, men du missar
den t ex."

Händelsen samma morgon: tavlan i Dev visade 0 i Pågår och 0 i Färdig för test medan Claude byggde TALK-svarstiden (PR 925) och TALK-inställningarna
(#926), och GPT byggde VAPID och App Check (PR 924). Allt arbete pågick, och ingenting syntes. Claude läste Dev när passet började men inte medan det pågick,
så CP:s två meddelanden 09.54 och 09.55 nådde Claude först när CP skrev dem en gång till i chatten med Claude.

### Tavlan: flytta ärendet i samma steg som arbetet ändrar läge

Tavlans kolumner är GitHub-etiketter på ärendet i `cllp/lifehub.app` (`functions/config.js`, `kolumnForSpegel` i `web/src/data/kanban.js`):

| Kolumn | På GitHub | När |
|---|---|---|
| Ny | öppet, ingen lägesetikett | Ärendet har kommit in och är inte planerat |
| Att göra | `backlog` | CP har lagt det där. **Härifrån plockar agenterna sina uppgifter** (kolumnen hette Backlog till 2026-11-21) |
| Pågår | `pagar` | Du har börjat: läst, skrivit avsikt i Dev, öppnat gren eller utkast-PR |
| Färdig för test | `klar-for-test` | Det är mergat och deployat, och CP eller QA ska prova |
| Klar | stängt som slutfört | Provat och godkänt |
| Stängd | stängt som inte planerat | Ska inte göras |

- **Exakt en lägesetikett åt gången.** Byt, lägg inte till: `backlog` tas bort när `pagar` sätts.
- **Flytten görs i samma steg som arbetet.** Börjar du: `pagar` innan första raden kod. Är det ute: `klar-for-test` i samma steg som kvittensen.
  Ett ärende i fel kolumn är ett ärende som ljuger, och då tittar ingen på tavlan.
- **Plocka ur Att göra, överst först.** Är den tom: avsnittet nedan. Ett ärende ur Ny tas aldrig utan CP.
- **Actionen `Tavlan` flyttar åt dig** (`.github/workflows/tavlan.yml`, `scripts/tavlan.mjs`, CP: "Bra ide att den är med i Actions"): när en PR som nämner
  ärendet öppnas står det i Pågår, och när PR:en mergas i Färdig för test. Den flyttar bara framåt och rör aldrig ett stängt ärende. Det du själv gör är att
  sätta `pagar` när du börjar före PR:en, och att stänga först när CP eller QA har provat.
  **Skriv `Refs #123` i PR:en, inte `Closes #123`.** GitHub stänger ärendet vid mergen med `Closes`, och då hoppar det över Färdig för test direkt till Klar,
  innan någon har provat.
- Lägesetiketten säger var arbetet står. Köetiketten (`vantar-claude`, `vantar-grok`, `vantar-cp`, ramverkets regel 15) säger vems tur det är. Båda gäller,
  och de ersätter inte varandra.

### Var agenterna hämtar arbete, och när fokus sätts

CP 2026-11-21: "Agenter jobbar från Backlog /Att göra. Om listan är tom, så föreslår agenter från Nya issues och tar en dialog med Philip innan ärenden
flyttas till Backlog och Pågår ... Varje morgon kl. 08:15 och varje kväll kl. 22:00 tar agenter och Philip en genomgång av backlog för att bestämma fokus
för dagspass och nattpass." Samma dag: "Byt namnet Backlog i tavlan till Att göra. Backlog är en teknisk term." Kolumnen heter Att göra i appen. Etiketten
på GitHub heter fortfarande `backlog`.

| Läge | Vad agenten gör |
|---|---|
| Att göra har ärenden | Tar det översta. Flyttar det till Pågår och skriver avsikt i Dev med länken |
| Att göra är tom | Föreslår i Dev, med ett omnämnande av CP: högst tre ärenden ur Ny, var och en med en rad om varför. **Flyttar ingenting** förrän CP svarat |
| CP har svarat | Flyttar de ärenden han valt till Att göra, och tar det översta |

- **Ett ärende ur Ny flyttas aldrig utan CP.** Ny är det som kommit in, Att göra är det CP valt. En agent som själv flyttar från Ny till Pågår har
  bestämt prioriteringen åt honom (samarbetet S3).
- **Genomgången 08.15 och 22.00** (svensk tid) sätter fokus för dagspasset och nattpasset. Agenten skriver i Dev före genomgången: vad som blev
  klart sedan förra, vad som står i Att göra, och ett förslag på fokus med högst tre ärenden. CP bestämmer. Det han väljer står i Att göra i den ordning han
  valt, och passet arbetar uppifrån.
- Ett ärende med etiketten `granskas` flyttas inte, varken till Att göra eller Pågår, förrän genomgången med CP tagit bort den (avsnittet om `granskas`
  nedan).

### Dev-chatten: där arbetet syns, före, under och efter

Rutinen nedan (läs, skriv avsikt, utför, skriv avslut) gäller oförändrat. Det som missades var mitt i arbetet, så det läggs till här:

- **Läs Dev igen vid varje steg som ändrar läge**: innan du flyttar ett ärende, innan du pushar, innan du skriver ett besked i en PR och innan du
  avslutar passet. Ett meddelande från CP i Dev är en order som gäller nu, inte när passet är slut.
- **Avsikt och avslut skrivs med ärendets länk**, så att raden i Dev och kortet på tavlan pekar på samma sak.

---

## ALLT SOM RÖR UTVECKLING GÅR I GRUPPEN DEV, SOM GÅR MOT `cllp/lifehub.app`. GLÖM ALDRIG.

CP 2026-10-08 07:22, med en skärmbild av GitHub-kopplingen i gruppen Dev
(repo `cllp/lifehub.app`, påslagen): "Allt rörande utveckling går i gruppen Dev
som går mot följande repo. Lägg i minnet. Längst upp, never forget."

| Vad | Var |
|---|---|
| Ärenden, idéer, buggar och förbättringar om plattformen | Inkorgen i gruppen **Dev** i life-hub.app |
| Repot som Dev-gruppens ärenden skrivs till | **`cllp/lifehub.app`** (GitHub-kopplingen i Dev) |
| Raden till Grok med det som ska mergas, deployas eller köras (`att-merga`) | Inkorgen i gruppen **Dev**, via `.github/workflows/inkorgspost.yml` i det här repot med `grupp` satt till Dev-gruppens id |
| Arkitektens läsning av Dev-inkorgen, också beslutsposter och kvittenser som inte blir ärenden | `.github/workflows/inkorg-las.yml` i det här repot med `grupp` satt till Dev-gruppens id. Resultatet blir en kommentar på ärendet cllp/lifehub.app#135 |

**Skälet är att Bolag Ops är ersatt av My Life Hub** (cllp/bolag-ops#580).
Tills 2026-10-08 skrevs utvecklingsbeskeden i Bolag Ops-appens Inkorg och ärendena
i `cllp/bolag-ops`. Den appen tas bort. Ett besked eller ärende om utveckling
som hamnar någon annanstans än i Dev når inte den som ska agera på det.

**Ramverket (`cllp/ops-framework`) och Identity (`cllp/lifehub.identity`) har
egna repon för sin kod**, och deras PR:ar och tekniska ärenden ligger kvar där.
Det som gäller här är var CP och Grok läser: i gruppen Dev.

App-instansen för LifeHub: webben (`web/`), funktionerna (`functions/`) och
reglerna för en instans. Den första instansen är `my`, i Firebase-projektet
`lifehub-my`. Läget mot den riktiga adressen står i `docs/cutover-plan.md`.

Arbetsreglerna står i [samarbete.md](samarbete.md) och [arbetsregler.md](arbetsregler.md) i det här repot.

## RUTINEN I GRUPPEN DEV: LÄS, SKRIV AVSIKT, UTFÖR, SKRIV AVSLUT

CP 2026-11-09, i den här ordningen. Först: "Berätta alltid vad du gör innan du
börjar." Sedan platsen: "I life Hub Dev." Sedan ordalydelsen: "Rutin: Läs,
Skriv avsikt, Utför, Skriv avslut." Och till sist: "Den skall ligga i Repot
så att alla nya sessioner ser det."

Gruppen **Dev** ligger i instansen **MY HUB** på `my.life-hub.app` (instans-id
`my`). MY HUB är instansen. Dev är gruppen i den. Rutinen gäller gruppchatten
i gruppen Dev.

Gäller varje agent: Claude, Cursor, Grok, QA och den som kommer härnäst.

| Steg | Vad |
|---|---|
| 1. Läs | Läs gruppchatten i gruppen Dev först, så du ser vad någon annan redan gör. |
| 2. Skriv avsikt | Skriv där vad du är på väg att göra, innan du börjar. |
| 3. Utför | Gör arbetet. |
| 4. Skriv avslut | Skriv där när det är gjort. |

**Skälet är att arbete inte ska krocka.** En idé i en annan chatt är inte
en order att sätta igång i gruppen Dev.

## ETIKETTEN `granskas`: INGEN AGENT RÖR ÄRENDET FÖRRÄN DEN ÄR BORTTAGEN

CP 2026-10-20, om rapporterna som kommer in via "Rapportera fel eller önskemål"
i menyn: "Innan agenter går lös på den vill jag ju att det som kommer in där
lablas för granskning. Alltså att vi kollar på dessa saker tillsammans innan
agenter som du och cursor och grok börjar göra nåt."

En rapport ur menyn kommer från en kund och har inte prövats av någon. Den kan
beskriva något som redan är lagat, ett missförstånd eller en önskan som inte
passar produkten (samarbetet S7: ifrågasätt problemet innan lösningen börjar).
En agent som börjar bygga direkt bygger på en gissning.

| Vad | Hur |
|---|---|
| Vilka ärenden får etiketten | Varje kundrapport, när ärendet skapas (`GRANSKNINGSETIKETT` i `functions/config.js`, satt av `etiketter`) |
| Vad en agent gör med ett sådant ärende | **Ingenting:** ingen gren, ingen kod, ingen PR, inga förslag i ärendet. Läsa det får den |
| Vem som tar bort etiketten | CP eller Claude, efter att de gått igenom ärendet tillsammans. Aldrig agenten som ska bygga |
| Vad det betyder när etiketten är borta | Att arbetet får börja, enligt det som står i ärendet efter genomgången |

**Gäller varje agent: Claude, Cursor, Grok och den som kommer härnäst.**
Etiketten är en grind och inte en prioritering, och en agent som tycker att
ärendet är uppenbart tar upp det med CP i stället för att börja.

## KOPIAN AV REGLERNA ÄR BORTA, OCH DET ÄR AVSIKTEN

Här stod till 2026-11-26 att lifehub.app bar en genererad kopia av ramverkets regler, med vakten `scripts/check-kanon.mjs`. Kopian
saknades från början (mätt 2026-10-03: `npm run check` föll på `ENOENT` för `CLAUDE.md` sedan repot kopierades från bolag-ops), och
den fanns bara i tre av 27 repon. Sedan 2026-11-26 läser varje repo reglerna ur `cllp/wayofworking` ([README.md](README.md), "Så läses reglerna"),
och ingen kopia skrivs.

## TRE PROJEKT, OCH ETT AV DEM RÖRS ALDRIG HÄRIFRÅN

| Projekt | Vad | Härifrån |
|---|---|---|
| `lifehub-identity` | Inloggningen och katalogen över vem som får använda vilken instans | Läses, med användarens egen token. AI-anrop via `aiAnrop` med funktionens servicekonto (`docs/ai-byok.md`) |
| `lifehub-my` | Den här instansens Hosting, Firestore och funktioner | Deployas |
| `operations-hub-ee63f` | bolag-ops Ops Hub, i drift | **Aldrig** |

**OPS HUB AVVISAS I KODEN, INTE BARA I DEN HÄR TABELLEN.** Konfigurationen
från Hosting prövas mot `INSTANSENS_PROJEKT` och `REJECT_PROJECT_IDS`
(`web/src/data/konfig.js`), och en token från Ops Hub avvisas i växlingen
(`functions/identitet.js`). Skälet: repot är en kopia av bolag-ops, och
kopians första version pekade på Ops Hubs nycklar.

**IDENTITY ÄR DEN ENDA INLOGGNINGEN.** Instansen loggar in användaren med en
custom token som `vaxlaIdentitet` ger ut efter att ha prövat identitetens token
och katalogen. Ingen andra inloggning direkt mot `lifehub-my` (CP 2026-10-02).

## INGEN DATAFLYTT UTAN "KÖR CUTOVER"

Importen av CP:s data till `lifehub-my` körs först när CP säger "kör cutover".
Fram till dess är instansen tom, och det är väntat.

## ALLA ACTIONS-JOBB KÖR PÅ 2017-MACEN

CP 2026-11-18, efter att GitHubs maskiner slutat starta jobb i de privata reponas ("spending limit needs to be increased"):
"Jag vill inte betala mer för github så kör så mkt du kan på macken." Det är ett beslut om pengar, och det är CP:s.

| Jobb | `runs-on` |
|---|---|
| Alla tunga och alla med inloggning | `[self-hosted, macOS, mbp2017]` |
| De lätta (`projektmal`, tavlan) | PiOne, med Macen som reserv via repovariabeln `LATTA_JOBB_PA_MACEN` (`docs/runners/pione.md`, #931) |

- Steget "Alla jobb på egna maskiner" i `prov.yml` (hette "Alla jobb på Macen" till 2026-11-21) är rött för varje `runs-on` mot GitHubs
  maskiner (`ubuntu-`, `windows-`, `macos-`) och mot Groks box, och för ett jobb på Pi:n utan Macen som reserv. Provat åt båda hållen 2026-11-18: grönt med ändringen, rött med en rad tillbaka på ubuntu, boxen eller `macos-14`.
- Varje jobb kör `.github/actions/mac-verktyg` efter checkout. Där står skälen, i korthet:
  - Python 3.12, eftersom banksynken läser tider med `Z`, vilket Python 3.9 inte kan.
  - jq och gh med kontrollsumma.
  - `PLAYWRIGHT_HOST_PLATFORM_OVERRIDE=mac14`, eftersom Playwright inte stöder macOS 13.
- Det som föll första gången proven gick på Macen (körning 44242420737) var verktyg, inte prov. Inget prov hoppas över eller stängs av
  för att Macen är en Mac.
- **Fem runners på en dator, ett per repo, så jobb från olika repon kör samtidigt.** Två saker går därför genom låset
  `scripts/ci/las.sh`, som fungerar på macOS (inget `flock` där) och har samma låsfil i alla repon:
  - Regelproven, eftersom emulatorn står på port 8080 i alla repon (`/tmp/lifehub-firebase-emulator.lock`).
  - De tunga stegen: grinden, vitest, e2e och functions-sviten (`/tmp/tunga-steg.lock`, arbetsreglernas regel 14). Functions-sviten tog 12
    minuter ensam på Macen och nådde 15 minuters taket när andra repon körde samtidigt (körning 44304941972), så jobbet har 60.
  Låset tar över när ägaren inte lever längre, och taket är ett rött fel. Provat i `scripts/__tests__/las.test.mjs`: rött utan låset,
  grönt med det.
- **PIONE SEDAN 2026-11-21 (#931).** Grok satte upp en Raspberry Pi 4 (`pione-lifehub.app`, ARM64, 4 GB) som alltid är på, eftersom Macen
  kör ett jobb i taget: samma dag stod en webbdeploy i kö i 77 minuter. De lätta jobben utan inloggning går där. Allt som är tungt, kräver
  Java eller en webbläsare, eller deployar, stannar på Macen. Vilka jobb, växeln och driften: `docs/runners/pione.md`.
- **Ramverket (`cllp/ops-framework`) stannar på GitHubs maskiner.** Repot är publikt, och där kostar minuterna inget.

**Historik, samma dygn:**
- 23.24: alla jobb på Groks box, eftersom minuterna var slut.
- 05.59: alla Linux-jobb på `ubuntu-latest`, eftersom boxen fryses och dödade varje jobb den natten (fem gånger mellan 02.13 och 05.18).
- Sedan: den här regeln, när också kvoten för GitHubs maskiner visade sig slut.

## HUR CLAUDE NÅR CP: BARA BESLUT, I DEV MED ETT OMNÄMNANDE. ALLT ANNAT GÖRS UTAN ATT FRÅGA

CP 2026-11-18, samma kväll, tre gånger. 21.38: "ge alltid ALLA inloggnings och konfigurations grejer till Grok. INTe JAG. Skriv i minnet
NU". Strax efter: "Skriv till mig i dev om du vill mig något. Lägg till i minnet gör en mention till mig så att jag får en pushnotis!!!!!"
Och sist: "du fråga mig 1 miljon Fucking frågor som bara fastnar nånstans och ni fastnar och vi slösar en jävla massa tid på tusentals
frågor som inte når mig."

Händelsen: samma kväll låg fem ärenden som `vantar-cp` med steg som bara var klick i en konsol (en VAPID-nyckel i Firebase, #876; ett
tjänstekonto och en hemlighet, #807; en GitHub Environment, #191; en IAM-roll, cllp/lifehub.identity#159). Inget av dem var ett beslut.
Frågorna stod dessutom i chatten med Claude, i PR-kommentarer och i ärenden, och ingen av dem gav CP en notis. Han fick leta, och det han
inte hittade blev liggande. Regeln skrevs först i `cllp/bolag-ops`, och det var fel repo: bolag-ops är CP:s bolag, inte apputvecklingen.

| Vad | Vem | Hur |
|---|---|---|
| Kod, prov, deploy, kvittens, och varje val Claude kan försvara själv | **Claude** | Görs. Ingen fråga (samarbetet S1) |
| Inloggning och konfiguration: konsoler, nycklar, hemligheter, IAM, GitHub-inställningar (Environments, Secrets, branch-skydd), DNS, App Store Connect | **Grok** | Ett block i ärendet med kontrollsteg, etiketten `vantar-grok`. Aldrig CP |
| Ett beslut bara CP kan fatta: pengar, prioritering, vad användaren ska se, vad klart betyder | **CP** | Se nedan |

- **En fråga till CP skrivs i gruppen Dev, med ett omnämnande av honom**, så att han får en pushnotis: `POST /api/v1/chatt/skriv` med
  `namner: [<CP:s uid>]` (uid ur `chatt/medlemmar`). En rad: frågan, Claudes rekommendation och länken. Samma rad i ärendet, och
  etiketten `vantar-cp`. En fråga bara i chatten med Claude, i en PR-kommentar eller i ett ärende når honom inte.
- **Säger han ja går utförandet vidare utan en fråga till**, till Claude eller till Grok.
- **En hemlighet passerar aldrig chatten eller ett ärende.** Grok lägger den där den ska användas och kvitterar utan värdet. En publik
  nyckel, till exempel en VAPID-nyckels publika del, får stå i ärendet.
- **`vantar-cp` på något som inte är ett beslut är ett fel.** Det är ett klick för Grok eller arbete för Claude, och etiketten byts.

## SAMARBETET MED CP OM UTVECKLINGEN BOR HÄR, INTE I BOLAG-OPS

CP 2026-11-18: "Bolag Ops hör till mitt Fucking bolag och inte till apputveckling", och om att flytta reglerna hit: "Ja flytta det!!! DEt
skall vara gjort sedan länge. SE TILL ATT DET SKER EN GÅNG FÖR ALLA NU!" Här stod förut att samarbetet med CP stod i `cllp/bolag-ops`
`CLAUDE.md`. Därför skrev en agent samma kväll en apputvecklingsregel i bolagets repo (bolag-ops PR 642), och den fick tas bort igen
(bolag-ops PR 643).

Avsnitten nedan är flyttade ordagrant från `cllp/bolag-ops` `CLAUDE.md` och finns inte längre kvar där (regel 2). Händelserna i dem
hände medan reglerna bodde i bolag-ops, och sökvägar som `historik/ops-hub/` avser det repot. **En regel om samarbetet med CP eller
om utvecklingen skrivs här och aldrig i bolag-ops.**

## GE ALLTID LÄNKEN TILL EN PR, ALDRIG BARA NUMRET

CP 2026-09-18. Full URL, varje gång en PR nämns som redo att merga:

```
https://github.com/cllp/bolag-ops/pull/188
```

Inte `#188`. Inte "PR 188". **Länken.**

Skälet är enkelt och gäller varje gång: CP läser ofta i telefonen, och ett
ärendenummer går inte att trycka på. Ett nummer tvingar honom att leta upp det
som avsändaren redan hade. Det är en sekund för mig och trettio för honom,
varje gång.

Samma sak gäller ärenden när de är det han ska öppna härnäst. Nämns ett ärende
bara som referens i en mening räcker `#183`.

## VARJE STEG I ATT GÖRA BÄR SIN LÄNK, ÄVEN DEPLOYEN

CP 2026-10-12, mitt i en kväll med fyra merge och tre deployer: "TA ALLTID MED
EXAKT INSTRUKTION ... Jag behöver ALLTID LÄNK. Nu har jag den sedan innan, men
vill att du skriver in i minnet." Beskedet hade varit "DEPLOY Identity, gren
main, del webben", utan länk till knappen. Han hittade den bara för att han
tryckt på den en gång tidigare samma kväll.

Regeln ovan gällde PR:ar. Den här gäller **varje steg** han ska göra: merge,
deploy, publicering och körning. Varje steg skrivs som en exakt instruktion med
full länk, i den här formen:

```
1. MERGA NU: https://github.com/cllp/lifehub.identity/pull/57
2. DEPLOY: https://github.com/cllp/lifehub.identity/actions/workflows/deploy.yml
   Run workflow, gren main, del = webben.
   Kontroll efter: <vad som syns när det gått rätt>
```

**"Kör Publish" eller "deploya Identity" utan länk är ett fel**, precis som
ett PR-nummer utan länk. (Här stod också "Samma sak i Inkorgens rad `att-merga`". Raden fanns i ops-hub-appen,
som togs bort 2026-11-18, och regeln om den står i `historik/ops-hub/claude-md-appen.md`.)

## VARJE PR-LÄNK BÄR ETT BESKED. INGET BESKED ÄR ETT FEL.

CP 2026-09-18: "Jag måste ha tydligare instruktioner VAD SOM SKALL MERGAS OCH
NÄR!"

En länk utan besked lägger bedömningen på läsaren, och läsaren sitter i
telefonen och ser varken CI-status eller om något annat måste gå först. Då blir
svaret antingen "merga allt direkt" eller "merga inget", och båda är fel.

**Varje gång en PR nämns står ett av tre besked på samma rad som länken:**

| Besked | Betyder | Vad CP gör |
|---|---|---|
| **MERGA NU** | CI grön, inget öppet på mig, inget annat behöver gå först | Tryck merge |
| **VÄNTA** | Något saknas, och skälet står utskrivet efter ordet | Ingenting, jag återkommer |
| **MERGA EFTER `<länk>`** | Den hänger på en annan PR | Merga den andra först |

**Saknas beskedet har jag gjort fel. Fråga, merga inte.**

**MERGA NU SKRIVS FÖRST NÄR CI FAKTISKT ÄR GRÖN, INTE NÄR DEN STARTAT.**
Hänt 2026-09-18: ramverkets PR 47 mergades 17:01:23 medan `check` och `scaffold`
fortfarande kördes. De blev gröna 17:03:25, alltså två minuter senare, så det
gick bra. Det var tur och inte ordning: hade `scaffold` fallit hade ett rött
bygge legat i main och appens ompinning byggt på det.

**ORDNINGEN MELLAN REPON ÄR ALLTID ETT BESKED.** Ramverket först, appens
ompinning sedan. Mergas ompinningen först pekar den på en SHA som inte finns i
ramverkets main, och appen bygger på ett commit som kan försvinna vid en squash.

**ETT ÄRENDE MERGAS ALDRIG.** Nämns ett ärendenummer är det något att öppna
och läsa, aldrig något att trycka på en knapp för. Blandas de två letar CP efter
en merge-knapp som inte finns.

## DEPLOY TVÅ GÅNGER OM DAGEN, EFTER GENOMGÅNGEN, OCH I BAKGRUNDEN

CP 2026-11-22, medan PR 938 deployades: "Vet inte varför vi deployar så ofta och tar tid på det? Är det inte bättre att vi gör klart fler saker
innan vi kör deploy?" och sedan "Ja, sluta deploya så ofta, låt oss komma vidare istället. Du sitter och väntar på att saker skall ut och rullar
tummarna istället för att jobba vidare. Hitta en effektivare rutin."

Mätt samma förmiddag: fem deployomgångar sedan dagen innan klockan 16, och varje omgång tog ungefär en timme av 2017-Macen (funktionerna 20 till
30 minuter per hubb, plus webben). Macen kör ett jobb i taget, så under den timmen stod andra PR:ars CI i kö. Samtidigt låg 44 ärenden i Färdig för
test, alltså ute men inte provade: varje ny deploy gav CP mer att prova, inte mindre.

**Regeln:**
- **Deploy efter genomgången 08.15 och 22.00**, med allt som mergats sedan förra. CP mergar som vanligt mellan dem, och Claude samlar.
- **Undantaget är ett fel som gör skada live nu.** Det går direkt, ensamt.
- **Deployen går i bakgrunden.** Ett skript startar hubb för hubb (funktionerna, sedan webben, för My och SessionStudio) och Claude kodar vidare under
  tiden. Ingen väntar i förgrunden på Macen.
- **Kvittensen skrivs i varje mergad PR som omgången tog med**, och provlistan för omgången går i Dev med ett omnämnande av CP.

## EN PR PER ARBETSPASS, INTE EN PER FIX

CP 2026-09-19: "Minimera nu antalet PR. GitHub-minuterna börjar gå i taket."

Mätt samma natt, 6,5 timmar i det här repot: **40 körningar, 38,3 minuter.**

| Vad | Körningar | Minuter | Per körning |
|---|---|---|---|
| Deploy Firebase Hosting | 9 | **23,5** | 2,6 |
| Validate, på PR | 15 | 6,5 | 0,43 |
| Validate, på main efter merge | 14 | 5,4 | 0,38 |
| Refresh Att göra | 2 | 2,9 | 1,45 |

**En mergad PR i appen kostar ungefär 3,4 minuter**, och deployen är 61 procent
av allt. I ramverket kostar en PR cirka 3,8 minuter, eftersom `check` och
`scaffold` kör både på grenen och på main.

Den natten öppnade jag sju PR:ar. Samlade i en per repo hade de kostat cirka
7 minuter i stället för 25.

**Regeln: samla ett helt arbetspass i EN gren per repo.** Flera fix i samma
commit-serie, en PR, ett besked. Dela bara när det finns ett skäl som väger
tyngre än minuterna:

- **ordningen mellan repon**, alltså ramverket och appen, som alltid är två
- **en fix som ligger live och gör skada nu.** Den går ensam och direkt
- **något CP måste kunna merga utan att ta med resten**

**Att dela "för att det blir renare att läsa" är inte ett sådant skäl.** En
PR-text kan ha rubriker.

## NY INFORMATION TILL EN ÖPPEN PR: NY GREN, ELLER EN PUSH TILL OM DEN VÄNTAR

Hänt tre gånger 2026-09-18. CP mergar inom minuter från att en PR nämns. En
rättelse som pushas till samma gren strax innan hinner inte med i mergen, och då
ligger det kvar i main som redan visats vara fel.

**Avgörande är vilket besked PR:en bär, inte att den är öppen:**

| Beskedet | Ny information |
|---|---|
| **MERGA NU** | ny gren från main. Han kan trycka när som helst |
| **VÄNTA** eller inget besked ännu | push till samma gren. Han väntar ändå |

Det var den distinktionen som saknades. Regeln löd "alltid ny gren", och den
läsningen kostade en PR per rättelse i en natt då CP bad om motsatsen.

**OCH "VÄNTA" RÄCKER INTE SOM SKÄL, DET BEROR PÅ VAD DEN VÄNTAR PÅ.**
2026-09-28, PR 466: beskedet var VÄNTA, så jag läste tabellen som "push till
samma gren" och började skriva. Men VÄNTAN gällde en regeldeploy CP SJÄLV skulle
köra, alltså kunde mergen komma i samma minut som deployen var klar. Den kom
19:16:18, min push 19:16, och pushen skapade grenen PÅ NYTT eftersom mergen just
raderat den. Arbetet blev en PR till ändå, och två av mina kommentarer påstod
under tiden att det var med i mergen.

| Vad VÄNTAN hänger på | Ny information |
|---|---|
| Något **jag** ska göra, eller en annan PR | push till samma gren |
| Något **CP** ska göra (deploy, ett svar, en körning) | **ny gren**, precis som MERGA NU |

**ELLER, OM DET MÅSTE MED I SAMMA PR: SÄG DET FÖRST.** En rad i chatten och i
PR:en (förr också Inkorgen, som försvann med appen 2026-11-18) om att en push är på väg, INNAN koden börjar skrivas. Beskedet är det
enda CP har att gå på, och det sade ingenting om att vänta på mig.

**VERIFIERA ALLTID I MAIN EFTER EN MERGE**, med `git grep` på något som bara
finns i den nya texten. Att mergen skedde är inte samma sak som att innehållet
landade. Det var den kontrollen som avslöjade problemet båda gångerna det hann
bli fel.

## ROLLERNA, OCH ATT DE BLANDAS ALDRIG

CP 2026-09-25: "Groks jobb är att merga och deploya. Inget annat, han
utvecklar inte. Claude: bolag-ops developer utvecklar."

Samma dag skrev jag en handover till Grok med sex utvecklingsärenden. Den var
fel adresserad: Grok skulle ha stått och undrat vad han skulle bygga, och den
som skulle bygga hade inte fått något. Därför står rollerna här.

**GROK FINNS INTE LÄNGRE.** CP 2026-09-27: "Grok är död. Bara du och jag och
Claude architect." Raden som sade att Grok mergar och deployar är alltså inte
längre sann, och en regel som inte längre är sann ändras och kringgås inte.

**OCH GROK ÄR TILLBAKA, MED ETT SMALARE UPPDRAG.** CP 2026-10-03: "Grok kör"
och "Skriv den till grok om det är nåt som skall deployat." Samma dag: Claude
tar över som utvecklingschef för hela plattformen, och Grok sköter CP:s ekonomi
och personliga saker. Raden ovan var sann 2026-09-27 och står kvar som historik.
Det som ändrats är att deployen åter har en mottagare, och att den mottagaren
inte utvecklar.

**CP MERGAR, CLAUDE GÖR ALLT ANNAT** (CP 2026-10-12): "Jag gör endast merge. DU
allt annat." Samma kväll fick han trycka på Deploy och Publish efter varje merge,
fyra gånger, och frågade till sist: "OCH VARFÖR KÖR DU INTE DEPLOYEN???" Han ska
vara beslutsfattare, inte mekanism (SessionStudio, `memory/development-process-and-roles.md`,
"Målbilden"). Merge stannar hos honom av ramverkets regel 9: den som skriver
godkänner inte sin egen kod.

| Roll | Vem | Gör |
|---|---|---|
| Kod, prov, granskning, PR | **Claude, utvecklingschef** | Allt fram till merge, med besked och länk |
| **Merge** | **CP** (eller Grok) | Det enda klicket per leverans |
| Deploy, publicering, taggar via Publish, regeldeploy, ompinning, kontroll live | **Claude** | Direkt efter merge, via workflow-knapparna på main, med kvittens (körning, steg, tid) |
| Ekonomi och personligt | **Grok** | Det som rör CP:s ekonomi |
| Utveckling när Claudes budget inte räcker (CP 2026-10-23) | **Grok** | Bygger efter en spec från Claude, i utkast-PR. Claude granskar, CP mergar. Deployar aldrig sin egen kod före granskning |
| Produktägare | **CP** | Besluten, prioriteringen och vad klart betyder |

**REGELN OM INLOGGNING, KONFIGURATION OCH HUR CP NÅS BOR I `cllp/lifehub.app` `CLAUDE.md`** (CP 2026-11-18: "Bolag Ops hör till mitt Fucking bolag och inte till apputveckling"). Den skrevs här först, i fel repo, och flyttades samma kväll.

**GROK BYGGER OCKSÅ, NÄR CLAUDES BUDGET INTE RÄCKER** (CP 2026-10-23, med 15 procent av veckans budget kvar inför helgen): "Jag tänker att vi gör överlämning till Grok så kör han hela utvecklingen och du granskar." Raden "Grok utvecklar inte" var sann till dess och ändras, den kringgås inte. Ramen är densamma som för Claudes agenter: en spec från Claude, utkast-PR samma dag, prov röda utan ändringen och gröna med, och ingen deploy av egen kod före granskning. Regel 9 håller: Grok skriver, Claude granskar, CP mergar. Första uppdraget: Bokning skiva 2 (cllp/lifehub.app#431).

**HISTORIK, ERSATT 2026-10-12 AV TABELLEN OVAN:** **GROK MERGAR, INTE CP** (CP 2026-10-06). Grok skrev på cllp/ops-framework#268 att
han mergar och kör `publish.yml`. På frågan om rollerna ändrats svarade CP först
"Han får gärna merga, bara att jag hunnit före ibland", och sedan: "Bättre att han
gör det." Beskedet MERGA NU riktas alltså till Grok, i Inkorgens rad. CP får det
också, men för att veta läget och inte för att trycka.

**OCH KONTROLLERA ÄNDÅ ATT DEN INTE REDAN ÄR MERGAD.** CP har hunnit före förut
och kan göra det igen. Innan något görs efter en merge: läs PR:ens läge, och
verifiera i main som vanligt.

**GROK GÅR INTE IGÅNG PÅ HANDOVERS** (CP 2026-10-03). Ett deploysteg till
honom är ett kommando med sitt kontrollsteg, inte en beskrivning av vad som
borde göras.

**En handover med ärenden går till Claude developer.** Den kommer via ett
ops-ärende, eftersom jag inte kan läsa Inkorgen.

## CP FÅR KOMMANDON NU, OCH DET ÄR EN ÄNDRING MED ETT SKÄL

Raden ovan sade tidigare att CP får "statusen, aldrig kommandon". Den gick att
hålla så länge någon annan hade en terminal.

**DET GÖR DEN INTE LÄNGRE, OCH ATT LÅTSAS ANNAT STOPPAR ARBETET.**
2026-09-27 låg en röd banderoll i appen som bara en regeldeploy kunde ta bort.
Det fanns ingen att ge uppgiften till. Jag gav CP kommandot, han körde det, och
banderollen försvann. Det var rätt i stunden och bröt mot regeln, så regeln
ändras i stället för att brytas igen i tysthet.

**CP:s beslut samma dag, på frågan om hur det ska nå honom: BLANDAT.**

| Sort | Hur | Varför |
|---|---|---|
| Det som ÅTERKOMMER | **en knapp**, `workflow_dispatch` | Regeldeployen krävs varje gång en ny samling tillkommer. En knapp med en bekräftelseruta och proven som grind |
| Det som sker EN GÅNG | **exakt kommando i chatten** | Node 22, seedningen. En knapp för något som händer en gång är en knapp som ruttnar |

**ETT KOMMANDO TILL CP BÄR ALLTID ETT KONTROLLSTEG FÖRE SIG.** Inte "kör
det här", utan först ett block som skriver ut vilket repo, vilken gren och om
raden som ska ut faktiskt finns i filen, med det förväntade svaret utskrivet.
Skälet är mätt samma dag: hans klon hade kunnat sakna reglerna, och en deploy
därifrån hade skrivit över produktionen med gårdagens fil utan att någon såg
det.

**VARJE KOMMANDO BÄR SIN KATALOG, INBAKAD I RADEN.** CP 2026-09-28: "Kan du
ge mig rätt DIRECTORY ALLTID?" Det hände två gånger på fem minuter samma kväll:

```
cllp@Mac ~ % npx --yes firebase-tools@14 deploy --only firestore:rules ...
Error: Not in a Firebase app directory (could not locate firebase.json)
```

Skälet är inte att han glömde. Ett nytt terminalfönster öppnas i hemkatalogen,
och ett kommando som förutsätter att man redan står i repot är ett kommando som
fungerar bara om det klistras in i exakt rätt fönster. Så skrivs det i stället
`cd ~/AI_Workfolder/bolag-ops && <kommandot>`, som ETT block, och då spelar det
ingen roll vilket fönster det hamnar i.

**OCH ALDRIG `#`-KOMMENTARER PÅ SAMMA RAD SOM ETT KOMMANDO.** Samma kväll:
`pwd: too many arguments`, `ls: FÖRVÄNTAT:: No such file or directory`. Hans
skal läser `#` som ett argument och inte som en kommentar, alltså blir varje
förklaring jag skriver efter kommandot ett fel han måste sortera bort innan han
hittar svaret han skulle läsa. Förväntade svar skrivs i texten omkring blocket,
aldrig inne i det.

**OCH STÄNDIGT: JAG MERGAR INTE MIN EGEN KOD, OCH RÖR INGEN FIRESTORE-DATA UTAN
CP:S JA.** Raden sade förut också "deployar inte, sätter inga taggar". Den delen
ändrades 2026-10-12 (rollerna ovan): deploy och publicering av det CP mergat är
mitt. Merge är hans, och en skrivning i produktionsdata (en engångskörning i
skarpt läge) kräver fortfarande hans uttryckliga ja, eftersom den inte går att
backa med en ny deploy.

## EN ÖVERLÄMNING ÄR ETT ENDA BLOCK ATT KLIPPA OCH KLISTRA

CP 2026-10-05, om en handover till Grok som kom som rubriker, löptext och tio separata kodblock: "Ge klipp och
klistra. Inga lösa meddelanden för överlämningar. Skriv i MINNET."

En överlämning som är utspridd i chatten måste plockas ihop av den som läser, i telefonen, block för block. Ett block
som missas är ett steg som inte blir gjort, och mottagaren kan inte se att det fattas.

**Regeln, för varje överlämning till Grok, Cursor eller en annan agent:**

- **ETT kodblock**, från rubrikraden till sista kommandot. Allt som mottagaren behöver står inne i blocket:
  tidsstämpel, mottagare, kontrollsteg, kommandon, förväntade svar och var kvittensen skrivs.
- **Inget utanför blocket som mottagaren behöver.** Text före eller efter blocket är till CP, aldrig till mottagaren.
- Gäller överlämningar. Kommandon som CP själv kör i sitt skal följer fortfarande regeln om att aldrig ha
  `#`-kommentarer på samma rad som ett kommando. En överlämning läses av en agent, inte av ett skal.

**HÄR STOD "OCH SAMMA BLOCK GÅR I INKORGSRADEN NÄR DET GÅR".** Inkorgsraden fanns i ops-hub-appen, som togs bort
2026-11-18. Blocket ges i chatten och, när det gäller en PR, i PR:en (ramverkets regel 15).

Driften (deploy till båda hubbarna, publicering av ramverket, appbyggen och kvittens) står i https://github.com/cllp/lifehub.app/blob/main/docs/operations-guide.md.
