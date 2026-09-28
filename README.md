# Registro Zaccaria

## 1) Crea il progetto Supabase

- Vai su https://supabase.com
- Crea un nuovo progetto
- Apri il menu SQL Editor
- Incolla il codice di `supabase/schema.sql`
- Esegui lo script

## 2) Abilita Auth

Nel pannello Supabase:
- Authentication → Providers
- Abilita Email
- Se vuoi, abilita anche Google

## 3) Crea lo storage

- Storage → New bucket
- Nome: `appunti`
- Privato: sì

## 4) Collega l'HTML

Nel file `index.html` modifica:

```js
const SUPABASE_URL = 'https://YOUR_PROJECT.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY';
```

con i valori reali del tuo progetto.

## 5) Login

Puoi usare:

```js
const { data, error } = await supabase.auth.signUp({
  email: 'student@esempio.it',
  password: 'Password123!'
});
```

o anche:

```js
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'student@esempio.it',
  password: 'Password123!'
});
```

## 6) Schema SQL

Il file `supabase/schema.sql` contiene la struttura corretta per:
- studenti
- voti
- lezioni
- appunti
- avvisi
- promemoria
- presenze
- sicurezza RLS

Questo è il codice che va incollato in Supabase SQL Editor.
