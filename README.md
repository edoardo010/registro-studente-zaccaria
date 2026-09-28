# Registro Zaccaria

## Configurazione Supabase

1. Crea un progetto su Supabase.
2. Apri **SQL Editor**, crea una nuova query e incolla `supabase/schema.sql`.
3. Esegui lo script.
4. In **Authentication → Providers** abilita Email (e Google se necessario).
5. Nel file HTML usa esclusivamente la `anon public key`, mai la `service_role key`.
6. L'app deve usare `supabase.auth.signUp()` / `supabase.auth.signInWithPassword()` e deve salvare i file in `appunti/<user.id>/nome-file`.

Lo schema usa RLS: ogni studente può leggere e modificare solo i propri dati. Non usare policy `using (true)` in produzione.
