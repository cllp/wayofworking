#!/usr/bin/env bash
# Körs av startkroken i varje repo när en session startar (README.md, "Så läses reglerna"):
#
#   curl -fsSL https://raw.githubusercontent.com/cllp/wayofworking/main/start.sh | bash
#
# Lägger in reglerna på maskinen (installera.sh), och skriver ut samarbetet ordagrant plus en order att läsa de andra filerna.
# Det som skrivs ut hamnar i agentens sammanhang. ⛔ Claude Code tar emot högst 10 000 tecken från en krok (dokumentationen för hooks,
# läst 2026-11-26), så bara samarbetet skrivs ut i sin helhet. Proven i prov.sh mäter att utskriften håller sig under taket.
#
# ⛔ Går något fel skrivs det ut som en order att stanna, aldrig tyst (arbetsregel 5). Kroken avslutar alltid med 0, så att texten når
# agenten: ett fel från en krok visas inte för agenten som en vanlig utskrift.
set -uo pipefail

KALLA="https://raw.githubusercontent.com/cllp/wayofworking/main"
FILER=(samarbete.md arbetsregler.md rita.md utveckling.md)

stanna() {
  cat <<EOF
⛔⛔ WAYOFWORKING: REGLERNA GICK INTE ATT LÄSA IN. STANNA.

$1

Börja inget arbete. Läs reglerna själv på https://github.com/cllp/wayofworking (samarbete.md, arbetsregler.md, rita.md och utveckling.md,
i den ordningen), och säg till CP i ditt första svar att startkroken föll och varför.
EOF
  exit 0
}

if [ -n "${WAYOFWORKING_DIR:-}" ]; then KAT="$WAYOFWORKING_DIR"
elif [ -d "$HOME/AI_Workfolder" ]; then KAT="$HOME/AI_Workfolder/wayofworking"
else KAT="$HOME/wayofworking"; fi
export WAYOFWORKING_DIR="$KAT"

if [ -f "$KAT/installera.sh" ] && [ -z "${WAYOFWORKING_LOKAL:-}" ]; then
  ut="$(bash "$KAT/installera.sh" 2>&1)" || stanna "$ut"
elif [ -z "${WAYOFWORKING_LOKAL:-}" ]; then
  ut="$(curl -fsSL -m 30 "$KALLA/installera.sh" | bash 2>&1)" || stanna "$ut"
fi
for f in "${FILER[@]}"; do [ -s "$KAT/$f" ] || stanna "$KAT/$f saknas efter hämtningen."; done

cat <<EOF
⛔⛔ WAYOFWORKING: REGLERNA FÖR ALLT ARBETE ÅT CP, I ALLA REPON. LÄS INNAN DU GÖR NÅGOT.

Källan är https://github.com/cllp/wayofworking ($(git -C "$KAT" rev-parse --short HEAD 2>/dev/null || echo okänd version)), på maskinen i $KAT.

1. Samarbetet står nedan, i sin helhet.
2. Läs med ditt läsverktyg, före första svaret, i den här ordningen:
   - $KAT/arbetsregler.md (arbetsreglerna 1 till 15)
   - $KAT/rita.md (hur vi ritar dokument och sidor)
   - $KAT/utveckling.md (Life Hub: tavlan, gruppen Dev, MERGA NU, rollerna, deploy; gäller reponas där vi bygger kod)
3. Repots egna regler står i repots README.md, AGENTS.md och CLAUDE.md, under raden om wayofworking. De gäller efter dessa.

Har du inte läst filerna i punkt 2 har du inte läst reglerna. Säg det hellre än att gissa.

────────────────────────────────────────────────────────────────────────

EOF
cat "$KAT/samarbete.md"
exit 0
