#!/usr/bin/env bash
# Lägger in wayofworking i ett repo (README.md, "Så läses reglerna"). Körs i repots rot:
#
#   bash /väg/till/wayofworking/lagg-in.sh
#
# Gör tre saker, och bara mellan markörer, så att repots egen text står kvar orörd:
#   1. Raden om wayofworking överst i README.md och AGENTS.md (skapas om de saknas) och i CLAUDE.md om den finns.
#   2. Startkroken i .claude/settings.json, som kör start.sh när en session startar. Finns filen läggs kroken till bredvid de andra.
#   3. Ingenting annat. Reglerna själva kopieras aldrig in (arbetsregel 2).
set -euo pipefail

BORJAN="<!-- wayofworking:borjan -->"
SLUT="<!-- wayofworking:slut -->"
KROK='curl -fsSL -m 30 https://raw.githubusercontent.com/cllp/wayofworking/main/start.sh | bash'

block() {
  cat <<EOF
$BORJAN
> ⛔ **Alla agenter läser alltid https://github.com/cllp/wayofworking innan de börjar**, i varje session och i varje repo: samarbetet med
> CP, arbetsreglerna, hur vi ritar och, där vi bygger kod, utvecklingen. Startkroken i \`.claude/settings.json\` lägger in dem av sig själv.
> Saknas de, läs dem där innan du gör något. Det som står nedan gäller bara det här repot, och efter dem.
$SLUT
EOF
}

lagg_overst() {
  local fil="$1" tmp
  tmp="$(mktemp)"
  if [ -f "$fil" ] && grep -qF "$BORJAN" "$fil"; then
    awk -v ny="$(block)" -v b="$BORJAN" -v s="$SLUT" '$0==b{print ny; hoppa=1; next} hoppa && $0==s{hoppa=0; next} !hoppa{print}' "$fil" > "$tmp"
  elif [ -f "$fil" ]; then
    # Efter en första rubrikrad, om filen börjar med en, annars först.
    awk -v ny="$(block)" 'NR==1 && /^# /{print; print ""; print ny; klar=1; next} NR==1 && !klar{print ny; print ""} {print}' "$fil" > "$tmp"
  else
    { block; } > "$tmp"
  fi
  mv "$tmp" "$fil"
}

lagg_overst README.md
lagg_overst AGENTS.md
[ -f CLAUDE.md ] && lagg_overst CLAUDE.md

mkdir -p .claude
node - "$KROK" <<'EOF'
const fs = require("fs");
const [krok] = process.argv.slice(2);
const fil = ".claude/settings.json";
const s = fs.existsSync(fil) ? JSON.parse(fs.readFileSync(fil, "utf8")) : {};
s.hooks ??= {};
s.hooks.SessionStart ??= [];
const finns = s.hooks.SessionStart.some((g) => (g.hooks ?? []).some((h) => h.command === krok));
if (!finns) s.hooks.SessionStart.unshift({ hooks: [{ type: "command", command: krok, timeout: 120 }] });
fs.writeFileSync(fil, JSON.stringify(s, null, 2) + "\n");
EOF
echo "wayofworking: inlagt i $(basename "$PWD") (README.md, AGENTS.md$([ -f CLAUDE.md ] && echo ", CLAUDE.md"), .claude/settings.json)"
