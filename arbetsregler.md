# Arbetsreglerna 1 till 17

Gäller allt arbete, i alla repon. Metaregeln och samarbetet står i [samarbete.md](samarbete.md) och gäller först.

## 1. Ingen quickfix. Ingen teknisk skuld som leverans.

Maskera aldrig ett rotfel. En env-flagga som sväljer ett byggfel, en `try/catch`
som tystar, en fallback som döljer en trasig konfiguration: alla tre är samma
sak, och alla tre gör felet dyrare nästa gång.

Innan du committar: **är det här rotorsaken eller symptomet?** Om symptom,
fortsätt.

En temporär åtgärd är tillåten bara om alla tre gäller: den är dokumenterad, den
har ett ärende, och den riktiga fixen påbörjas i samma eller nästa pass. "Sen"
betyder permanent.

## 2. En sanning per faktum.

Lagra eller skriv aldrig samma uppgift två gånger. Kan ett värde härledas ur ett
annat: härled det. Två kopior av samma regel glider isär, och då larmar den ena
på något den andra inte längre följer.

Det gäller kod, konfiguration, dokument och regler. Behöver två repon samma
sanning måste den ha **ett** hem plus en genererad kopia med vakt, aldrig två
handskrivna original.

Unikhet löses med riktiga constraints, aldrig med en extra spegelkolumn eller en
läs-sedan-skriv-kontroll.

## 3. Mät. Lita aldrig på en rapport, inte ens din egen.

En rapport är ett tips, aldrig ett bevis. Det gäller en agents sammanfattning,
en anteckning i ett dokument, och en siffra du själv skrev i går.

Tre mätfel som redan kostat oss dagar, alla värda att känna igen:

- **Noll träffar är inte ett svar.** Det är en fråga om vad du sökte igenom. En
  sökning i fel repo-kopia gav "commiten existerar inte" om commits som fanns.
- **En anteckning om tillstånd ruttnar, en tagg gör det inte.** Läs
  utrullat läge ur taggen, inte ur ett dokument som beskrev taggen en gång.
- **Kod visar vad som kan hända, bara data visar vad som har hänt.**
  SessionStudio 2026-08-27, två fall samma dag. En funktion klassades som
  bakgrundstrigger på sitt namnprefix `migrate*` och var i själva verket en
  stängd callable. En granskning skrev att två röster raderats permanent,
  "verifierat rad för rad", och höjde till P1. Ingenting var raderat. Koden var
  densamma oavsett utfall; det som avgjorde var hur många nycklar fältet hade
  i databasen, och det står inte i koden.

Innan du beskriver ett läge: mät det nu. Rör påståendet vad som finns i
produktion: mät, eller säg att du inte kan, och skriv **hypotes** när det är en
hypotes. Ett larm på obekräftad omfattning får höjas, men det stängs med en
mätning och inte med mer kodläsning, och den som höjer det säger vilken mätning
som skulle avgöra saken. Kan ingen mäta just nu: skriv mätuppdraget som eget
ärende i stället för att bygga en fix på en gissning.

## 4. Ett prov som aldrig setts falla är ingen vakt.

Varje vakt och varje prov ska bevisas i **båda** riktningarna: grönt med sin fix,
rött utan den. Skriv ut båda utfallen när du levererar.

Fyra former av falsk grönhet vi har haft, alla fyra lätta att missa:

- **Närvarogrep.** Ett prov som söker efter ett funktionsnamn i källan mäter inte
  beteende. Det stod grönt genom hela felet det skulle fånga.
- **Tautologisk lista.** En lista som jämförs mot den mängd den är en kopia av
  kan inte faila. Den är grön för att den inte mäter.
- **Tomt underlag.** Ett prov som blir grönt av att ingenting lästes. Ge varje
  vakt ett **golv**: minst N filer lästa, minst N poster i listan.
- **Tystnad.** En vakt som räknar felrader är grön genom ett fel som tystnar.
  SessionStudios deployvakt sa "ingen funktion rapporterades misslyckad" när en
  körning slagit i jobbets tidsgräns i sista batchen: elva funktioner hade
  börjat uppdateras, ingen bekräftades och ingen felrad skrevs
  (cllp/sessions-platform#3437, rad D2 i cllp/ops-framework#104). Mät att något
  **slutfördes**: räkna både påbörjat och bekräftat och rapportera skillnaden.
  Samma när formatet vakten läser slutar matcha, till exempel efter en
  CLI-uppgradering: säg att det inte känns igen, gå inte grön
  (cllp/sessions-platform#3253, rad D3 i #104).

Vaktar du en skuld: sätt ett **tak som bara får sjunka**, inte noll. Noll gör
befintliga fall röda utan att någon lagar dem, och då stängs vakten av.

## 5. Tomhet är ett svar, inte en utelämnad rubrik.

En rapport som utelämnar en rubrik när värdet saknas gör "noll" omöjligt att
skilja från "ostält". Skriv ut raden även när den är tom, med en text som säger
vilket det är.

Samma sak i felvägar: en tyst nedsläppsväg är värre än ett fel, för den ser ut
som att allt gick bra.

## 6. Inga em-dash eller en-dash.

`—` och `–` är de tydligaste tecknen på maskinskriven text. Använd bindestreck,
komma, kolon eller punkt. Gäller chatt, kod, commit-meddelanden, PR-texter och
allt en användare ser. Svenska tecken bevaras alltid.

## 7. Committa ofta lokalt, pusha sällan, och aldrig force i en loop.

Kostnaden sitter i pushen, inte i commiten: en push startar varje kontroll som
lyssnar på grenen. Batcha ett arbetspass.

Force-push är en sista utväg med `--force-with-lease`, aldrig ett sätt att ta sig
ur en rebase man inte förstår.

**Innan du tror på ett arbetsträd du inte själv lämnade:** hämta, jämför mot
huvudgrenen, och titta efter minustecken. Ett arbete som ska läggas till lägger
till. Ett som tar bort hundratals rader är nästan alltid en gammal version av en
fil som hunnit växa.

## 8. Opushat arbete är osynligt arbete.

En gren utan PR är inte på väg någonstans och ingen vakt larmar på den. Öppna
utkastet samma dag arbetet börjar, inte när det är klart.

Det här är den dyraste lärdomen i listan: hundra commits låg opushade på en
maskin i två dygn, och under tiden analyserade någon annan problem som de redan
hade löst.

## 9. Den som skriver godkänner inte.

Den som kör ett prov godkänner inte ändringar av provet. Den som skriver en fix
är inte den som släpper in den.

Regeln kostar: en färdig och grön fix kan bli liggande för att rätt granskare
saknas. Det är rätt pris, och flaskhalsen ska då synas som en kapacitetsfråga,
inte lösas genom att någon godkänner sig själv.

## 10. Den levande statusvyn uppdateras efter varje pass.

Produktägaren ska inte behöva fråga var vi är. Efter varje pass där något
mergats, deployats, öppnats eller stängts: uppdatera statusvyn och länka den.

En rapport som slutat spegla verkligheten är **sämre än ingen rapport**, för den
ser fortfarande auktoritativ ut.

Siffror hämtas live vid varje generering. Skriv aldrig av dem från förra
versionen. Bedömningar ska märkas som bedömningar: mätt data och gissningar får
inte se likadana ut.

## 11. En ramverksrelease är klar först när appen pinnat om, i samma pass.

CP 2026-09-28 20:41, med en skärmbild från telefonen: "Ingen skillnad, ingen
ut/inloggning. Ingenting... Vad händer?" Ramverket låg då på 0.25.0 med fyra
mergade PR:ar bakom sig, taggat och publicerat, och appen pekade fortfarande på
0.24.0. Allt CP hade bett om fanns, i ett paket ingen konsumerade. Samma
eftermiddag hände det en gång till: 0.26.0 publicerades, och appen stod kvar
på 0.25.0 tills han frågade igen.

En release som inte konsumeras är för produktägaren exakt lika mycket som
ingen release, och den är värre än ingen: statusen säger "klart" om något han
inte kan se, så nästa fråga blir "vad händer?" i stället för "vad är nästa".

**Regeln:** ett pass som publicerar en ramverksversion är inte avslutat förrän
appens ompinnings-PR är öppnad med besked, i samma pass, med release-URL:en
till den nya taggen. Ordningen står kvar (ramverket mergas och publiceras
först, ompinningen mergas sedan), men de två är ett arbete och rapporteras
som ett. En release-rad i statusen utan sin ompinningsrad är ofullständig.

## 12. Ett ärende som citerar SessionStudio är klart först när PR:en bär en skärmbild av samma flöde sida vid sida med förebilden.

CP 2026-09-28 22:32: "Jag ber om samma sak massor av gånger men får ingen
skillnad." #157, #158 och #164 hade alla provats i jsdom och fotograferats
ensamma, aldrig bredvid förebilden, och alla tre visade sig ändå avvika när
CP till slut jämförde själv: en dropdown i stället för en panel, ett
statusord i stället för en byggd komponent, en dubblerad hamburgare.
jsdom kör ingen CSS och Vitest mäter aldrig hur något SER UT, bara att det
renderar och att rätt text finns. Ett prov kan vara helt grönt genom precis
den avvikelsen som gjorde att CP kände igen felet direkt i telefonen.

En skärmbild av ramverket ensam bevisar ingenting: den visar att något
ritades, inte att det ritades RÄTT. Bara bredvid sin förebild går det att se
var de glider isär, på samma sätt som ett prov utan sin fix visar vad det
faktiskt fångar (regel 4).

**Regeln:** ett ärende vars beskrivning citerar eller hänvisar till en
SessionStudio-skärmbild är inte klart förrän PR:en bär ett montage: den
citerade förebilden och en riktig skärmbild av ramverkets flöde, sida vid
sida, tagen med Playwright mot en byggd app (aldrig ett enhetstest, aldrig
jsdom). Montaget följs av en ärlig egen jämförelse i PR-texten: vad som nu
matchar och vad som fortfarande skiljer sig, aldrig bara "klart".

## 13. Förebilden är ett golv, inte ett tak. Det som gör modellen tyngre stryks.

CP 2026-10-06, mitt i arbetet med tillgängligheten (#259): "Om vi ser att vi
kan göra saker bättre än sessionstudio skall vi göra det och ta höjd ... om vi
ser att någon funktion komplicerar vår modell och app så skall vi överväga att
tänka om eller ta bort funktion ... VI skall inte utmana prestanda och
arkitektur och göra det komplext."

Regel 12 säger att det SS gör ska se likadant ut. Den här säger vad som
händer när SS gör något sämre, eller gör det på ett sätt som kostar. SS bär
själv beviset: dess tillgänglighet byggdes på läsregler som avgjorde vem som
fick se vad. Delade blockerade datum (`blockedDates`) fick i 0.9.328 en
läsregel som prövade medlemskapet per grupp, och redan i 0.9.329 föll den på
Firestores gräns för antal `exists()` (`subscribe_blocked_shared_error`) och
fick backas till JWT-anspråken. I 0.9.398 (#113) fick samma läsning en
tredje form, JWT eller medlemskap. Beslutet om den sortens läsregler, och det
SS kallar "permissions-träsket", är ADR-020: beslutet om att läsregler inte ska
avgöra synlighet. Att kopiera den modellen för att ytan ska se likadan ut hade
varit att kopiera felet tillsammans med utseendet.

**Regeln:** varje skiva som följer en förebild skriver ut tre listor i PR:en.
Den första är det som tas som det är. Den andra är det som görs bättre, och
skälet. Den tredje är det som stryks, och vad det hade kostat i datamodell,
regler eller prestanda. Ytan följer förebilden. Modellen bakom den följer
den här regeln. Ingen funktion kommer med bara för att förebilden har den.

## 14. Ett rött utfall som passerar isolerat är en misslyckad mätning, inte ett resultat.

SessionStudio 2026-08-27, mätt två gånger: en agent rapporterade 12 röda
webbprov i sin arbetskopia, och samma svit på samma commit gav noll fel när den
kördes ensam. Maskinen körde flera agenter och sviter samtidigt, och tunga prov
slog i sina tidsgränser.

En grind som slumpmässigt är röd tvingar fram ett val mellan att blockera bra
arbete och att lära sig ignorera rött. Båda är sämre än ingen grind, eftersom
båda ser ut som kvalitetskontroll.

Samma läge finns här: flera agenter bygger, provar och tar montage på samma
maskin under ett pass.

**Regeln:** så länge flera agenter och sviter delar maskin körs tunga sviter
ensamma eller i följd. Ett rött utfall som passerar isolerat är inte ett
resultat utan en mätning som misslyckades. Skriv det så, med båda utfallen.

## 15. PR:en eller ärendet är kön. Exakt en etikett säger vems tur det är.

CP 2026-10-30: "NI väntar på varandra hela tiden och allt fastnar." Tio av Groks
PR:ar hade då väntat över ett dygn på Claudes granskning, och ingenting sa till
Claude att de fanns: PR:arna var gröna och färdiga, men ingen lista, notis eller
etikett pekade ut dem. Den som hade gjort sin del gick vidare, den som skulle ta
vid visste inte om det, och CP fick vara den som märkte stilleståndet. Han bad
inte om att de tio skulle tas, utan om "en permanent lösning" och inte ett
enskilt ärende som kö. Ett ärende som samlar köns innehåll är en andra lista att
hålla i takt med verkligheten (regel 2), och den ruttnar (regel 10).

**Regeln:** själva PR:en eller ärendet är kön. Exakt en av tre etiketter säger
vems tur det är:

| Etikett | Vems tur | Vad som ska stå |
|---|---|---|
| `vantar-claude` | Claude | Granskning, eller ett fel att titta på |
| `vantar-grok` | Grok | Merge, deploy eller körning, med blocket som kommentar i PR:en eller ärendet |
| `vantar-cp` | CP | Ett beslut eller ett test i telefonen, med frågan i en rad |

- **Den som har gjort sin del byter etikett i samma steg.** Att pusha, öppna
  utkastet, kommentera eller köra klart är inte avslutat förrän etiketten säger
  vem som är nästa. Ingenting öppet som väntar på någon står utan etikett.
- **Varje agent söker på sin etikett minst en gång i timmen, i alla repon**
  (alla repon under `cllp`, listan i [repon.md](repon.md)). En sökning
  utan träff är inte ett svar förrän du vet vilka repon du sökte i (regel 3).
  ⛔ **Sök PR:ar med PR-sökningen, inte med ärendesökningen.** Mätt 2026-10-30,
  första dagen regeln gällde: ärendesökningen med `label:vantar-claude` gav noll
  träffar i alla tre repon, fast lifehub.identity PR 111 bar etiketten, och
  PR-sökningen (`is:pr is:open label:vantar-claude`) gav den direkt. Kön hade
  alltså varit tom för den som sökte på det första sättet. Sök PR:ar och ärenden
  var för sig, och kontrollera sökningen mot en träff du redan vet om.
- **Ett långt ärende med block är ingen kö.** Det går inte att se vems tur det
  är i en lång tråd, och ett block begravt i kommentar 40 hittas av ingen.
  Blocket läggs i en egen kommentar och etiketten sätts.
- Etiketterna är exakt tre, med exakt de här namnen. En fjärde ("väntar-alla",
  "blockerad") är en etikett som inte pekar ut någon.
- ⛔ **Läs tråden innan du skriver i den, och skriv om ditt block när planen
  ändras.** CP 2026-11-03: "Varför läser ni inte varandras meddelanden?" Natten
  innan hade Claude skrivit i ramverkets PR 503 att ompinningen skulle ligga i
  appens PR 618. Planen ändrades till en egen PR (619), men blocket i 503 stod
  kvar. Grok läste det och skrev, med rätta, att en ny PR behövdes. Grok
  deployade sedan 619 och kvitterade i den kl 05.25. Claude läste inte tråden
  och skrev 06.10 ett nytt block som bad Grok deploya en gång till. Båda
  missarna hade stoppats av att läsa det man själv och den andra skrivit.
  - **Innan du skriver ett block, en kvittens eller ett besked i en PR eller ett
    ärende: läs alla kommentarer i den.** Bevakningen av en PR slutar när den
    mergas, så en kvittens som skrivs efter mergen når ingen av sig själv.
  - **Ändras planen, skriv om ditt gamla block i samma steg**, i den PR eller
    det ärende där det står, och inte bara i det nya. Det får aldrig stå två
    block som säger olika saker, eftersom mottagaren inte kan veta vilket som
    gäller.
  - **Kontrollen knyts till överlämningen, inte till klockan.** Den som lämnar
    över läser tråden igen när mottagaren har haft tid att göra sin del, en gång
    per överlämning. Ingen bevakning dygnet runt (CP samma dag: "du skall inte
    kolla varje timma dygnet runt").
- ⛔ **Kvittensen står i PR:en, alltid.** CP 2026-11-04: "NI VÄNTAR PÅ
  VARANDRA" och sedan "Bra kvittensen i pr alltid". lifehub.app PR 628
  deployades 07:10, live som v1.0.1109, men beskedet om deployen gick till
  CP och inte till PR:en. Claude kan inte nå appens adress från sin miljö
  (mätt samma dag: anslutningen nekas), så tråden var det enda stället där
  Claude kunde se läget. I tråden stod fortfarande "MERGA NU". En timme
  senare skrev Claude ett besked om en deploy som redan var gjord, och PR
  635 väntade under tiden.
  - **En merge eller deploy är klar först när kvittensen står i PR:en:**
    körningens eller deployens rader, versionen i appen och tiden, och
    etiketten tas bort. Ett besked bara i chatten eller i ett annat ärende
    räknas inte. Det gäller också efter en merge, när bevakningen av PR:en
    har slutat.
  - **Den som tar vid läser kvittensen och inget annat** innan den skriver
    något om läget.

## 16. Inga ikoner eller emoji i det vi skriver.

CP 2026-11-26, om kalenderposter som en agent lagt in via API:et med rubriker
som började med en ikon: "Kan du ta bort såna här fruktansvärda ikoner som inte
får vara med. Det står i alla regler." Mätt samma kväll: det stod inte här. En
sökning på emoji, ikon och symbol i alla filer i wayofworking gav noll träffar.
Agenten hade tagit efter äldre poster i samma kalender, som en tidigare agent
lagt dit, och alla 56 poster fick tas bort och skapas om.

**Regeln:** inga emoji och inga dekorativa ikoner i text vi skriver åt CP eller
åt en användare. Det gäller rubriker, kalenderposter, anteckningar, dokument,
chatt, commit-meddelanden och PR-texter. Texten bär innehållet.

- **Att det redan står ikoner där du skriver är inget skäl.** Ta inte efter dem,
  och säg att de finns (S9).
- **Det gäller tecknen i texten.** Ikoner som gränssnittet själv ritar är en
  annan sak och väljs i ramverket.
- **Undantag:** märket ⛔ i regelfilerna, som pekar ut en hård regel.

## 17. Utkast åt CP skrivs i hans röst.

Gäller utkast till sms, mejl och meddelanden som CP ska skicka i eget namn,
oavsett repo.

- **Löpande text.** CP 2026-11-20, om ett utkast: "En sak som inte är jag. Det
  är när det står ett uttryck med kolon eller en fråga och så ett svar på det.
  Jag skriver i löpande text." Inga uttryck med kolon framför det som ska sägas,
  inga etiketter eller rubriker framför stycken, och inte greppet att ställa en
  fråga och sedan svara på den själv.
- **Hans ord, ofärdiga hellre än polerade.** CP samma dag, om stycken agenten
  hade putsat: "Det här låter pretentiöst." Utkastet skrevs om med hans egna
  formuleringar. Ett utkast som låter bättre än han pratar är ett sämre utkast.
