# Skill: Controllo Compiti Classter (Jacopo)

## Obiettivo
Verificare i compiti pendenti di Jacopo su Classter e comunicarli a Filippo su Telegram.

## Credenziali
- URL: https://stellamaris.classter.com/StudentDuties
- Username: variabile d'ambiente `CLASSTER_USER`
- Password: variabile d'ambiente `CLASSTER_PASS`

## Procedura

### Step 1 — Login
1. Apri https://stellamaris.classter.com con il browser tool
2. Individua i campi username e password
3. Inserisci le credenziali dalle variabili d'ambiente
4. Esegui il login
5. Verifica che il login sia andato a buon fine prima di procedere

### Step 2 — Navigazione ai compiti
1. Naviga a https://stellamaris.classter.com/StudentDuties
2. Se vieni reindirizzato al login, ripeti Step 1

### Step 3 — Filtraggio compiti pendenti
1. Trova il filtro "Completed" e imposta il valore su **"No"**
2. Clicca il bottone **"Show Homework"**
3. Attendi che la pagina carichi i risultati

### Step 4 — Estrazione dati
Per ogni compito trovato, estrai:
- Materia
- Descrizione del compito
- Data di consegna (se presente)

### Step 5 — Gestione stato con memoria
1. Richiama dalla memoria i compiti già notificati in precedenza (namespace: `classter`)
2. Identifica i compiti **nuovi** (non ancora notificati)
3. Salva in memoria tutti i compiti attuali con data e dettagli

### Step 6 — Comunicazione a Filippo
**Se ci sono compiti nuovi:**
Manda un messaggio Telegram a Filippo con il riepilogo:
```
📚 Compiti di Jacopo — [data odierna]

[Materia]: [descrizione] — consegna: [data]
...

Dimmi quando Jacopo ha finito così li segno come completati.
```

**Se non ci sono compiti nuovi:**
Non mandare nessun messaggio (evita notifiche inutili).

**Se non ci sono compiti affatto:**
Manda solo se è la prima volta oggi: "📚 Nessun compito pendente per Jacopo oggi."

## Gestione errori
- Se il login fallisce: notifica Filippo con "⚠️ Non riesco ad accedere a Classter, verifica le credenziali."
- Se il sito non risponde: riprova una volta dopo 30 secondi, poi notifica se fallisce ancora.
- Se il browser non parte: usa web_fetch come fallback per tentare l'accesso.

## Stato compiti
I compiti restano "pendenti" in memoria finché Filippo non dice esplicitamente "Jacopo ha finito [materia]" o "segna tutti come fatti".
Solo allora aggiorna la memoria e considera quei compiti chiusi.
