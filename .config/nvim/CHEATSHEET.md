# NVIM CHEATSHEET - Configurazione Completa

> Setup ottimizzato per Web Development (HTML, CSS, JavaScript, TypeScript, React, Node.js)

---

## 🚀 AVVIO RAPIDO

```bash
# Aprire file o progetto
nvim .                    # Apri directory corrente
nvim file.js              # Apri file specifico

# All'interno di nvim
:q                        # Esci
:w                        # Salva
:wq o ZZ                  # Salva ed esci
:q!                       # Esci senza salvare
```

---

## ⌨️ MODALITÀ NVIM

| Modalità | Descrizione | Entrata |
|----------|-------------|---------|
| **Normal** | Navigazione, comandi | `Esc` o `Ctrl+[` |
| **Insert** | Scrittura testo | `i`, `a`, `o` |
| **Visual** | Selezione testo | `v`, `V`, `Ctrl+v` |
| **Command** | Comandi `:` | `:` |

### Transizioni Modalità
```
Normal → Insert:
  i    = inizio riga (before cursor)
  a    = dopo cursore
  o    = nuova riga sotto
  O    = nuova riga sopra
  I    = inizio riga
  A    = fine riga

Insert → Normal:
  Esc  = torna a Normal
  Ctrl+[ = alternativa a Esc

Normal → Visual:
  v    = selezione carattere per carattere
  V    = selezione per righe
  Ctrl+v = selezione a blocchi
```

---

## 📁 NAVIGAZIONE FILE

### File Explorer (nvim-tree)
```
<Space>e           = Apri/chiudi file explorer
```
**Nella finestra explorer:**
- `Enter` = apri file o espandi directory
- `a` = crea nuovo file
- `d` = elimina file
- `r` = rinomina
- `q` = chiudi explorer

### Fuzzy Finder (Telescope)
```
<Space>ff          = Trova file (fuzzy search)
<Space>fg          = Cerca nel contenuto (live grep)
<Space>fb          = Cerca nei buffer aperti
<Space>ft          = Trova TODO/FIXME nel progetto
```

**Uso di Telescope:**
1. Premi `<Space>ff`
2. Digita parte del nome file
3. Usa `↑` `↓` per navigare
4. `Enter` per aprire
5. `Esc` per chiudere

---

## 🔖 HARPOON (File Favorites)

Segnalibri per file frequenti - tipo "favorites" di VS Code.

```
<Space>ha          = Aggiungi file corrente a Harpoon
<Space>h1          = Vai al file 1
<Space>h2          = Vai al file 2
<Space>h3          = Vai al file 3
<Space>h4          = Vai al file 4
<Space>hh          = Apri menu Harpoon
```

**Flusso di lavoro:**
1. Apri il file che usi spesso (es. `App.jsx`)
2. Premi `<Space>ha` per aggiungerlo
3. In qualsiasi momento premi `<Space>h1` per tornarci
4. Aggiungi altri file a h2, h3, h4

---

## ⚡ FLASH (Salto Rapido)

Navigazione ultra-veloce nel testo.

```
s + 2 lettere      = Salta a qualsiasi posizione
S + 2 lettere      = Salto all'indietro
```

**Esempio pratico:**
1. Sei a riga 10, vuoi andare a riga 50
2. Premi `s` poi le 2 lettere che vedi vicino alla destinazione
3. Appariranno labels (a, b, c...) sul testo
4. Premi la label per saltare lì

---

## 💬 COMMENTI

Commenta/decommenta codice rapidamente.

```
gcc                = Commenta/decommenta riga corrente
gc                 = Commenta selezione (modalità Visual)
gcap               = Commenta paragrafo (blocco di testo)
```

**Esempio:**
```javascript
// Prima
const x = 5;

// Dopo gcc
// const x = 5;

// Selezione multipla:
// 1. Vai in visual mode (V)
// 2. Seleziona righe
// 3. gc per commentare tutte
```

---

## 🔧 EDITING

### Parentesi Automatiche (nvim-autopairs)
Automatico - non serve premere nulla:
```javascript
// Tu scrivi:
function(

// Diventa automaticamente:
function(|)          // cursore dentro

// Anche per:
"  →  "|"
'  →  '|'
{  →  {|}
[  →  [|]
```

### Movimento Base
```
h j k l            = Sinistra, Giù, Su, Destra
w                  = Parola successiva
b                  = Parola precedente
e                  = Fine parola
0                  = Inizio riga
$                  = Fine riga
gg                 = Inizio file
G                  = Fine file
Ctrl+d             = Metà pagina giù
Ctrl+u             = Metà pagina su
```

### Modifica
```
yy                 = Copia riga
dd                 = Taglia riga (cancella)
p                  = Incolla dopo
P                  = Incolla prima
u                  = Undo (annulla)
Ctrl+r             = Redo (ripeti)
r                  = Sostituisci carattere
x                  = Cancella carattere
>>                 = Indenta riga
<<                 = Rimuovi indentazione
```

### Cerca nel file
```
/parola            = Cerca "parola" in avanti
?parola            = Cerca all'indietro
n                  = Prossimo risultato
N                  = Risultato precedente
:noh               = Cancella highlight ricerca
```

---

## 🐛 DEBUG ERRORI (Trouble)

Lista centralizzata di errori, warning e diagnostic.

```
<Space>xx          = Apri/chiudi lista errori
<Space>xd          = Errori solo del file corrente
<Space>xw          = Errori di tutto il workspace
<Space>xq          = Lista quickfix
```

**Nella finestra Trouble:**
- `Enter` = vai all'errore
- `q` = chiudi

---

## 🎨 LSP (IntelliSense)

Funziona automaticamente per: HTML, CSS, JS, TS, React, JSON

```
gd                 = Go to Definition (vai alla definizione)
gr                 = Find References (trova riferimenti)
K                  = Hover Documentation (documentazione)
<Space>rn          = Rename Symbol (rinomina simbolo)
<Space>ca          = Code Action (azioni rapide)
<Space>cf          = Format Code (formatta codice)
```

### Autocomplete
Appare automaticamente mentre scrivi:
- `Tab` = conferma selezione
- `Ctrl+Space` = forza apertura menu
- `↑` `↓` = navigazione

---

## 📦 COMANDI NPM

```
<Space>ni          = npm install
<Space>nr          = npm run (scegli script)
<Space>nd          = npm run dev
<Space>nb          = npm run build
```

---

## 🔄 BUFFER (Tab)

Gestione file aperti.

```
gt                 = Prossimo buffer
gT                 = Buffer precedente
<Space>bd          = Chiudi buffer
<Space>bn          = Prossimo buffer
<Space>bp          = Buffer precedente
```

**Bufferline:** mostra tab in alto con i file aperti.

---

## 🌳 GIT (Gitsigns)

Indicatori a sinistra:
- `+` = righe aggiunte (verde)
- `-` = righe rimosse (rosso)
- `~` = righe modificate (giallo)

---

## 🎯 WHICH-KEY (Help)

**Premi `<Space>` e aspetta mezzo secondo** - apparirà un menu con tutti i comandi disponibili!

---

## 📝 EMMET (Espansioni HTML)

Per file HTML, JSX, CSS.

```html
<!-- Scrivi: -->
div.container>ul>li*3

<!-- Premi Tab, diventa: -->
<div class="container">
  <ul>
    <li></li>
    <li></li>
    <li></li>
  </ul>
</div>
```

**Altri esempi:**
```
.class              →  <div class="class"></div>
#id                 →  <div id="id"></div>
button#btn.primary  →  <button id="btn" class="primary"></button>
```

---

## 🔍 FORMATTAZIONE (Prettier)

Formattazione automatica al salvataggio per:
- JavaScript / TypeScript
- React (JSX/TSX)
- HTML / CSS / JSON / YAML
- Markdown

**Formatta manualmente:**
```
<Space>cf          = Formatta file corrente
```

---

## ✅ TODO COMMENTS

Evidenzia automaticamente nei commenti:
- `TODO:` - giallo
- `FIXME:` - rosso  
- `HACK:` - viola
- `NOTE:` - blu
- `BUG:` - rosso

**Esempi:**
```javascript
// TODO: Implementare autenticazione
// FIXME: Questo bug causa crash
// NOTE: Ricordarsi di aggiornare la doc
```

---

## 🖥️ SPLIT WINDOW

```
Ctrl+h/j/k/l       = Muovi tra finestre
```

**Crea split da terminale WezTerm:**
```
Cmd+D              = Split verticale (pane a destra)
Cmd+Shift+D        = Split orizzontale (pane sotto)
Cmd+Alt+H/J/K/L    = Navigazione tra pane
```

---

## 🎓 FLUSSO DI LAVORO COMPLETO

### Scenario: Lavorare su un progetto React

```bash
# 1. Apri progetto
cd /percorso/mio-progetto-react
nvim .

# 2. In nvim:
<Space>e           = Apri explorer
# Naviga con j/k, premi Enter su App.jsx

# 3. Aggiungi file frequenti a Harpoon:
<Space>ha          = Aggiungi App.jsx
<Space>h1          = Torna ad App.jsx quando vuoi

# 4. Cerca file:
<Space>ff          = Trova componente

# 5. Modifica codice:
i                  = Modalità insert
# Scrivi codice, autocomplete apparirà automaticamente
Esc                = Torna a Normal
:w                 = Salva (formatta automaticamente)

# 6. Navigazione codice:
gd                 = Vai alla definizione di una funzione
K                  = Leggi documentazione
<Space>xx          = Controlla errori

# 7. Commenta codice:
gcc                = Commenta riga

# 8. Usa npm:
<Space>nd          = Avvia dev server

# 9. Salta rapidamente:
s + 2 lettere      = Flash jump a qualsiasi punto
```

---

## 📋 RIEPILOGO TASTI LEADER

Tutti i comandi con `<Space>` (leader):

| Comando | Azione |
|---------|--------|
| `<Space>w` | Salva |
| `<Space>q` | Esci |
| `<Space>e` | Toggle Explorer |
| `<Space>ff` | Trova File |
| `<Space>fg` | Live Grep |
| `<Space>fb` | Trova Buffer |
| `<Space>ft` | Trova TODO |
| `<Space>xx` | Toggle Errori |
| `<Space>xd` | Errori Documento |
| `<Space>rn` | Rinomina |
| `<Space>ca` | Code Action |
| `<Space>cf` | Formatta |
| `<Space>ha` | Harpoon Add |
| `<Space>h1-4` | Harpoon 1-4 |
| `<Space>hh` | Harpoon Menu |
| `<Space>ni` | NPM Install |
| `<Space>nr` | NPM Run |
| `<Space>nd` | NPM Dev |
| `<Space>nb` | NPM Build |
| `<Space>bd` | Chiudi Buffer |
| `<Space>bn` | Next Buffer |
| `<Space>bp` | Prev Buffer |

---

## ❌ RISOLUZIONE PROBLEMI

### Errore "module not found"
```bash
# Riavvia nvim, lazy installerà automaticamente
nvim

# Oppure aggiorna forzatamente
:MasonUpdate
:Lazy sync
```

### LSP non funziona
```bash
# Installa i server LSP
:Mason
# Seleziona i server con 'i' (install)
```

### Formattazione non funziona
```bash
# Prettier deve essere installato globalmente
npm install -g prettier

# Oppure nel progetto
npm install --save-dev prettier
```

---

## 🎨 COLORI E TEMA

- **Theme**: TokyoNight (coerente con WezTerm)
- **Background**: Trasparente (eredita WezTerm)
- **Opacity**: 0.8 in WezTerm

---

**Creato per**: Configurazione NVIM Web Development  
**Ultimo aggiornamento**: Febbraio 2026
