#!/usr/bin/env bash
# Lägger in reglerna ur cllp/wayofworking i varje agents eget minne på den här maskinen (README.md, "Så läses reglerna").
#
#   bash installera.sh            klonar eller uppdaterar repot och skriver in hänvisningarna
#   bash installera.sh --kontroll skriver ingenting, och är rött om reglerna inte är inlagda eller ligger efter
#
# ⛔ Skriver bara mellan markörerna. Det som står i ~/.claude/CLAUDE.md och ~/.codex/AGENTS.md utanför dem rörs inte.
# ⛔ Tomt eller trasigt är rött, aldrig grönt (arbetsregel 5): saknas en fil, eller är den kortare än golvet, avbryts allt.
set -euo pipefail

REPO="https://github.com/cllp/wayofworking"
FILER=(samarbete.md arbetsregler.md rita.md utveckling.md)
GOLV_BYTE=1000
BORJAN="<!-- wayofworking:borjan, genererad av installera.sh, ändra aldrig här utan i $REPO -->"
SLUT="<!-- wayofworking:slut -->"

if [ -n "${WAYOFWORKING_DIR:-}" ]; then KAT="$WAYOFWORKING_DIR"
elif [ -d "$HOME/AI_Workfolder" ]; then KAT="$HOME/AI_Workfolder/wayofworking"
else KAT="$HOME/wayofworking"; fi

fel() { echo "⛔ wayofworking: $*" >&2; exit 1; }

kontroll=0
[ "${1:-}" = "--kontroll" ] && kontroll=1

if [ "$kontroll" = 0 ]; then
  if [ -d "$KAT/.git" ]; then git -C "$KAT" pull -q --ff-only || fel "kunde inte uppdatera $KAT (git pull --ff-only)"
  else git clone -q --depth 1 "$REPO" "$KAT" || fel "kunde inte klona $REPO till $KAT"; fi
fi

for f in "${FILER[@]}"; do
  [ -f "$KAT/$f" ] || fel "$KAT/$f saknas"
  [ "$(wc -c < "$KAT/$f")" -ge "$GOLV_BYTE" ] || fel "$KAT/$f är kortare än $GOLV_BYTE byte"
done

# Claude läser in filerna själv vid start, via hänvisningar i användarens minnesfil.
claude_block() {
  echo "$BORJAN"
  echo "Reglerna för allt arbete åt CP, i alla repon. Läs dem före första svaret. Källa: $REPO"
  for f in "${FILER[@]}"; do echo "@$KAT/$f"; done
  echo "$SLUT"
}

# GPT läser ingen hänvisning, så filerna skrivs ihop. Det är en läsfil på maskinen, aldrig incheckad någonstans.
codex_block() {
  echo "$BORJAN"
  echo "Reglerna för allt arbete åt CP, i alla repon. Läs dem före första svaret. Källa: $REPO"
  for f in "${FILER[@]}"; do echo; cat "$KAT/$f"; done
  echo "$SLUT"
}

# Byter blocket mellan markörerna, eller lägger det först i filen.
skriv_block() {
  local fil="$1" block="$2" tmp
  mkdir -p "$(dirname "$fil")"
  touch "$fil"
  tmp="$(mktemp)"
  if grep -qF "<!-- wayofworking:borjan" "$fil"; then
    awk -v ny="$block" 'index($0,"<!-- wayofworking:borjan")==1{print ny; hoppa=1; next} hoppa && index($0,"<!-- wayofworking:slut -->")==1{hoppa=0; next} !hoppa{print}' "$fil" > "$tmp"
  else
    { printf '%s\n\n' "$block"; cat "$fil"; } > "$tmp"
  fi
  mv "$tmp" "$fil"
}

if [ "$kontroll" = 1 ]; then
  for fil in "$HOME/.claude/CLAUDE.md" "$HOME/.codex/AGENTS.md"; do
    grep -qF "<!-- wayofworking:borjan" "$fil" 2>/dev/null || fel "$fil saknar reglerna. Kör: curl -fsSL https://raw.githubusercontent.com/cllp/wayofworking/main/installera.sh | bash"
  done
  echo "wayofworking: reglerna är inlagda ($KAT, ${#FILER[@]} filer)"
  exit 0
fi

skriv_block "$HOME/.claude/CLAUDE.md" "$(claude_block)"
skriv_block "$HOME/.codex/AGENTS.md" "$(codex_block)"
echo "wayofworking: reglerna inlagda ur $KAT ($(git -C "$KAT" rev-parse --short HEAD)), ${#FILER[@]} filer, i ~/.claude/CLAUDE.md och ~/.codex/AGENTS.md"
