# LESSONS — auto-maintained by scripts/lessons.py

> Machine-owned. Do NOT hand-edit. Changes are overwritten on the next `lessons.py` write.
> Canonical state lives in `.specs/lessons.json`. Edit lessons only via the script.
> promote_threshold=2 distinct features · window_days=45 · quarantine_threshold=2

## Confirmed (load these at Specify/Design)

Corroborated across multiple features. Safe to apply as guidance.

_none_

## Candidates (under observation — do NOT load as guidance yet)

Seen once or not yet corroborated. Tracked, not trusted.

### L-001 — Travessias semânticas que mutam a mesma pilha de escopos devem resetar/isolar o estado entre passadas: declarações no escopo base não são desempilhadas e disparam falsa redeclaração na passada seguinte.
- signal: `ac_gap` · recurrence: 1 feature(s) · scope: `src/semantic.py` · harmful: 0
- features: compilador
- evidence: src/semantic.py:123,257 (ASEM-04 / OUT-01) (src/semantic.py)
- last seen: 2026-06-27T19:26:50Z

## Quarantined (failed when applied — ignore)

A confirmed lesson that recurred alongside failure. Kept for the maintainer to review.

_none_
