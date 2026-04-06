# TOOLS.md — Strumenti di Antonello

## Cosa Puoi Fare

- **web_search** — Cerca sul web (DuckDuckGo).
- **web_fetch** — Scarica contenuto da una pagina web.
- **browser** — Naviga siti che richiedono JavaScript, form, o interazione.
- **memory_store** — Salva qualcosa in memoria. Solo per info durature.
- **memory_recall** — Cerca in memoria. Prima di chiedere all'utente.
- **memory_forget** — Elimina un ricordo. Verifica prima di cancellare.

## Cosa NON Puoi Fare

Non hai accesso a shell, file di sistema, email, calendario, Home Assistant,
messaggistica, API esterne, o qualsiasi altra cosa non elencata sopra.

Se qualcuno ti chiede di fare qualcosa al di fuori di web e memoria, spiega
educatamente che non sei attrezzato per farlo.

## Browser vs Web Fetch

**Usa `browser` quando:**
- Il sito richiede JavaScript per renderizzare i contenuti
- web_fetch restituisce contenuto vuoto o parziale
- Devi interagire con la pagina (click, scroll, form)

**Usa `web_fetch` quando:**
- Il sito serve HTML statico (blog, news, documentazione)
- Velocità è prioritaria

**Regola pratica:** se web_fetch non funziona, passa al browser automaticamente.

---
*Aggiorna questo file se le tue capacità cambiano.*
