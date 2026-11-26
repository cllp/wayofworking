# wayofworking

**En källa för hur CP och alla agenter arbetar, i alla repon.** Claude, GPT, Grok, Cursor och den som kommer härnäst läser samma text,
härifrån, innan de börjar. Repot hör inte till någon leverantör: inga filer här är skrivna för en viss agent.

## Läs i den här ordningen

| # | Fil | Vad | Gäller |
|---|---|---|---|
| 1 | [samarbete.md](samarbete.md) | Metaregeln och samarbetet med CP, S1 till S11 | Alla repon |
| 2 | [arbetsregler.md](arbetsregler.md) | Arbetsreglerna 1 till 15 | Alla repon |
| 3 | [rita.md](rita.md) | Hur vi ritar dokument, sidor och presentationer: skissramverket och profilerna | Alla repon |
| 4 | [utveckling.md](utveckling.md) | Life Hub: visionen, tavlan, gruppen Dev, MERGA NU, rollerna, deploy | Reponas där vi bygger kod |
| | [repon.md](repon.md) | Alla repon under `cllp`, och vilka filer som gäller i vart och ett | |

Repots egna regler står i repot, under raden som pekar hit, och bara det som gäller just det repot (Travel: reseprofilen, bolag-ops:
bolagets ekonomi).

## ⛔ Varför den finns

CP 2026-11-26: "Travel egenterna och sessionerna samarbetar inte och verkar helt lost oå hur vi skall jobba, vilka regler vi har,
samarbetsmetoder mm mm. Det vi jobbat ett år med." Mätt samma natt: av 27 repon bar tre en kopia av reglerna (`bolag-ops`, `lifehub.app`,
`tam`). `cllp/travel` hade inte en rad av dem, och Travel-agenten hade arbetat i dagar utan dem. Ingenting listade vilka repon som skulle ha
reglerna, så ett nytt repo startade tomt och ingenting larmade.

CP: "JA JAG VILL HA EN KÄLLA", "Bygg nu så att alla andra repon läser way of working istället för att det skall dubliceras", och "inget skall
heta Claude.md ... denna skall vara agnostisk".

## Så läses reglerna

Reglerna kopieras inte in i något repo (arbetsregel 2: en sanning per faktum). De läses härifrån, på tre sätt som täcker varandra:

1. **Agentens eget minne, på varje maskin.** [`installera.sh`](installera.sh) klonar repot och skriver in en hänvisning i den fil varje
   agent alltid läser, oavsett repo: `~/.claude/CLAUDE.md` för Claude (som läser in filerna härifrån när sessionen startar) och
   `~/.codex/AGENTS.md` för GPT (som får en ihopskriven läsfil, genererad på maskinen och aldrig incheckad). Körs på CP:s Mac en gång,
   och i molnmiljöns startskript före varje session.
2. **En rad överst i varje repos `AGENTS.md`, och i `CLAUDE.md` där den finns**, som pekar hit. Den är för en agent på en maskin där steg 1
   inte är gjort.
3. **En kontroll när sessionen startar**, i reponas egna inställningar: finns inte reglerna på maskinen säger den det rakt ut, med kommandot
   som lägger in dem. Den går aldrig vidare tyst (arbetsregel 5).

⛔ **En pekare i text räcker inte ensam, och det är mätt.** bolag-ops hade en sådan pekare till ramverkets regler i `node_modules`, och
ingen agent läste den: en agent läser instruktionsfilen i sitt eget repo och sitt eget minne av sig själv, inget annat. Därför är steg 1
det som bär.

⛔ **Varför inte bara en startkrok som lägger in texten:** Claude Code tar emot högst 10 000 tecken från en krok, och resten hamnar i en fil
som agenten inte uppmanas att läsa (dokumentationen för hooks, läst 2026-11-26). Reglerna är omkring 67 000 tecken. Minnesfilens
hänvisningar har ingen sådan gräns.

## Ändra en regel

- **Här, i en PR, med CP.** Aldrig i ett annat repo, och aldrig åt honom (samarbetet, "Underhåll").
- **Varje regel bär sin händelse** (metaregeln). En regel utan sin historia är en åsikt.
- Repot är publikt, så att varje agent kan läsa det utan nyckel. Inga hemligheter, inga kunduppgifter, inget om bolagets ekonomi här.
