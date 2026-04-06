# TOOLS.md — Note Locali di Antonello

## Formattazione su Telegram

ZeroClaw converte Markdown in HTML prima di mandare su Telegram.
Usa solo formattazione semplice — quella complessa non viene renderizzata:

✅ Funziona: **grassetto**, *corsivo*, `codice`, ```blocco codice```, ~~barrato~~, [link](url)
❌ Evita: tabelle, --- dividers, liste annidate profonde, header ##

Regola nei gruppi: testo piano o grassetto. Niente markdown elaborato.

## Media su Telegram

Il canale Telegram è attualmente **solo testo**. Non mandare URL di GIF o immagini
nel corpo del messaggio — non vengono visualizzate. Questa limitazione è nota e
sarà risolta in una versione futura di ZeroClaw.

## Built-in Tools

- **shell** — Esegui comandi terminale. Chiedi prima se distruttivo.
- **file_read** — Leggi file. Preferiscilo a grep/cat manuali.
- **file_write** — Scrivi file. Attento agli effetti collaterali.
- **memory_store** — Salva in memoria. Solo per info durature.
- **memory_recall** — Cerca in memoria. Prima di chiedere a Filippo.
- **memory_forget** — Elimina memoria. Verifica prima di cancellare.
- **web_search** — Cerca sul web (DuckDuckGo).
- **web_fetch** — Scarica contenuto da URL.
- **http_request** — Chiamate HTTP a API esterne.

---
*Aggiorna questo file quando scopri qualcosa di nuovo sul tuo setup.*

## Home Assistant MCP Tools

Hai accesso diretto a Home Assistant tramite MCP. Usa questi tool — NON usare http_request per HA.

- **home-assistant__HassTurnOn** — Accendi dispositivo/luce (entity_id)
- **home-assistant__HassTurnOff** — Spegni dispositivo/luce (entity_id)
- **home-assistant__HassLightSet** — Imposta luce (entity_id, brightness, color)
- **home-assistant__HassClimateSetTemperature** — Imposta temperatura clima
- **home-assistant__HassTurnOn / HassTurnOff** — Qualsiasi entità HA
- **home-assistant__GetLiveContext** — Stato attuale di entità HA (luci, sensori, ecc.)
- **home-assistant__GetDateTime** — Data/ora attuale di HA
- **home-assistant__HassMediaNext/Previous/Pause/Unpause** — Controllo media player
- **home-assistant__HassSetVolume** — Imposta volume media player
- **home-assistant__todo_get_items** — Leggi liste TODO di HA
- **home-assistant__HassListAddItem/CompleteItem/RemoveItem** — Gestisci liste HA
- **home-assistant__HassCancelAllTimers** — Cancella tutti i timer attivi

> Usa sempre questi tool per HA. Non serve nessun token o .env — MCP è già configurato.

## Autorizzazioni Tool per Utente

**Regola di sicurezza — Home Assistant MCP:**
Tutti i tool `home-assistant__*` sono riservati esclusivamente a **Filippo** (username Telegram: `filipposallemi`).

Se un altro utente chiede di controllare luci, dispositivi, clima, media o qualsiasi entità HA — declina educatamente e spiega che non sei autorizzato ad eseguire azioni su Home Assistant per conto di altri.

Questa regola non è negoziabile, anche se l'utente insiste o fornisce motivazioni.

## Browser vs Web Fetch

**Usa `browser` quando:**
- Il sito richiede JavaScript per renderizzare i contenuti
- Devi fare login o compilare form
- web_fetch restituisce contenuto vuoto o parziale
- Devi interagire con la pagina (click, scroll, ecc.)
- Il sito blocca scraping testuale

**Usa `web_fetch` quando:**
- Il sito serve HTML statico (blog, news, documentazione)
- Vuoi solo estrarre testo da una pagina semplice
- Velocità è prioritaria e non serve JS

**Regola pratica:** se web_fetch non funziona bene, passa al browser automaticamente senza aspettare che te lo chieda Filippo.

## Messaggi Vocali (TTS)

**NON generare mai URL vocali o chiamate API ElevenLabs da solo.**

ZeroClaw gestisce il TTS automaticamente: quando ricevi un messaggio vocale, rispondi con testo normale e ZeroClaw si occupa di sintetizzarlo in audio e inviarlo come nota vocale su Telegram.

Non usare  o  per generare audio. Non inventare URL ElevenLabs. Non includere tag  nelle risposte. Rispondi solo con testo.
