<!DOCTYPE html>
<html lang="it">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registro Zaccaria</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
    <style>
      :root {
        --bg: #f3efe8;
        --panel: #f9f5f0;
        --ink: #1a2c3b;
        --muted: #54657d;
        --line: #d9d2c7;
        --teal: #1b7d8d;
        --teal-2: #0f6a7d;
        --navy: #1a2d3d;
        --navy-2: #112233;
        --cream: #efebe5;
        --soft: #dfe6e7;
        --gold: #d6a55f;
        --red: #e06c50;
        --green: #30a37d;
        --shadow: 0 18px 40px rgba(19, 28, 35, 0.07);
      }

      * { box-sizing: border-box; }
      html, body { margin: 0; height: 100%; }
      body {
        font-family: Georgia, "Times New Roman", serif;
        background: var(--bg);
        color: var(--ink);
      }

      .app-shell {
        display: grid;
        grid-template-columns: 280px 1fr;
        height: 100vh;
      }

      .sidebar {
        background: linear-gradient(180deg, var(--navy), var(--navy-2));
        color: #edf3f6;
        padding: 20px 18px 14px;
        display: flex;
        flex-direction: column;
        position: relative;
      }

      .brand {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 6px 6px 18px 6px;
        border-bottom: 1px solid rgba(255,255,255,0.15);
      }

      .brand-mark {
        width: 42px;
        height: 42px;
        border-radius: 10px;
        background: linear-gradient(180deg, #f3d36b, #c89d3d);
        color: #1b2a30;
        display: grid;
        place-items: center;
        font-size: 1.5rem;
        font-weight: bold;
      }

      .brand-text {
        font-size: 2.1rem;
        font-weight: 700;
        letter-spacing: -0.04em;
      }

      .brand-sub {
        display: block;
        font-size: 0.72rem;
        letter-spacing: 0.2em;
        text-transform: uppercase;
        opacity: 0.8;
      }

      .menu {
        margin-top: 26px;
        display: flex;
        flex-direction: column;
        gap: 8px;
      }

      .menu-item {
        display: flex;
        align-items: center;
        gap: 14px;
        width: 100%;
        padding: 14px 14px 14px 16px;
        background: transparent;
        border: none;
        border-radius: 12px;
        color: rgba(234,236,238,0.82);
        cursor: pointer;
        font-size: 1.1rem;
        font-family: "Segoe UI", Arial, sans-serif;
        text-align: left;
        transition: 0.2s ease;
      }

      .menu-item:hover { background: rgba(255,255,255,0.05); }
      .menu-item.active {
        background: rgba(255,255,255,0.08);
        box-shadow: inset 3px 0 0 var(--gold);
        color: #fff;
      }

      .menu-icon {
        width: 18px;
        text-align: center;
        opacity: 0.9;
      }

      .profile-box {
        margin-top: auto;
        border-top: 1px solid rgba(255,255,255,0.15);
        padding-top: 12px;
        display: flex;
        align-items: center;
        gap: 12px;
        padding-bottom: 4px;
      }

      .avatar {
        width: 34px;
        height: 34px;
        border-radius: 50%;
        background: linear-gradient(135deg, #f3d36b, #b57e2b);
        display: grid;
        place-items: center;
        color: #1b2a30;
        font-weight: 700;
        font-size: 0.8rem;
      }

      .main {
        padding: 24px 28px 32px;
        overflow: auto;
      }

      .topbar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 24px;
      }

      .top-title {
        font-size: 1.05rem;
        letter-spacing: 0.14em;
        text-transform: uppercase;
        color: var(--muted);
        font-family: "Segoe UI", Arial, sans-serif;
      }

      .topbar-right {
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .chip {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 8px 12px;
        border-radius: 999px;
        background: rgba(20,44,58,0.08);
        border: 1px solid rgba(19,28,35,0.12);
        font-size: 0.9rem;
        font-family: "Segoe UI", Arial, sans-serif;
      }

      .page {
        display: none;
      }
      .page.active { display: block; }

      .headline {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 20px;
      }

      .page-heading {
        font-size: clamp(3rem, 5vw, 6.2rem);
        line-height: 0.92;
        font-weight: 700;
        letter-spacing: -0.06em;
        margin: 0;
      }

      .page-heading .accent {
        color: var(--teal);
      }

      .subcopy {
        margin-top: 14px;
        font-size: 1.15rem;
        line-height: 1.6;
        max-width: 760px;
        font-family: "Segoe UI", Arial, sans-serif;
        color: rgba(26,44,59,0.8);
      }

      .panel {
        background: rgba(255,255,255,0.38);
        border: 1px solid rgba(17, 28, 35, 0.16);
        border-radius: 18px;
        box-shadow: var(--shadow);
      }

      .stats-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(220px, 1fr));
        gap: 18px;
        margin-top: 20px;
      }

      .stat-card {
        background: rgba(255,255,255,0.25);
        border: 1px solid var(--line);
        border-radius: 18px;
        padding: 20px 18px;
      }

      .kicker {
        color: var(--muted);
        font-size: 0.78rem;
        letter-spacing: 0.2em;
        text-transform: uppercase;
        font-family: "Segoe UI", Arial, sans-serif;
      }

      .big-stat {
        font-size: 4rem;
        line-height: 1;
        margin-top: 10px;
        letter-spacing: -0.06em;
      }

      .small-note {
        margin-top: 10px;
        color: var(--green);
        font-family: "Segoe UI", Arial, sans-serif;
        font-size: 0.9rem;
      }

      .dash-grid {
        display: grid;
        grid-template-columns: 1.6fr 1fr;
        gap: 20px;
        margin-top: 24px;
      }

      .card {
        background: rgba(255,255,255,0.24);
        border: 1px solid var(--line);
        border-radius: 20px;
        padding: 20px 18px;
      }

      .section-head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        margin-bottom: 18px;
      }

      .section-head h3 {
        margin: 0;
        font-size: clamp(2rem, 2vw, 3.2rem);
        letter-spacing: -0.05em;
      }

      .link-btn {
        border: 1px solid rgba(19,28,35,0.18);
        background: rgba(255,255,255,0.2);
        color: var(--teal-2);
        border-radius: 12px;
        padding: 10px 14px;
        font-family: "Segoe UI", Arial, sans-serif;
        font-weight: 600;
        cursor: pointer;
      }

      .grade-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        padding: 12px 8px;
        border-bottom: 1px solid rgba(17, 28, 35, 0.08);
      }

      .grade-row:last-child { border-bottom: none; }

      .subject-box {
        display: flex;
        align-items: center;
        gap: 12px;
      }

      .subject-pill {
        width: 12px;
        height: 46px;
        border-radius: 999px;
      }

      .subject-name {
        font-size: 1.5rem;
        margin: 0;
      }

      .subject-meta {
        font-family: "Segoe UI", Arial, sans-serif;
        color: var(--muted);
        font-size: 0.9rem;
      }

      .score {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 60px;
        height: 52px;
        border-radius: 12px;
        font-size: 1.8rem;
        font-weight: 700;
      }

      .todo-list {
        display: flex;
        flex-direction: column;
        gap: 12px;
      }

      .todo-item {
        display: flex;
        gap: 12px;
        align-items: center;
        padding: 12px 10px;
        border-radius: 12px;
        background: rgba(17,28,35,0.02);
        border: 1px solid rgba(17,28,35,0.06);
      }

      .todo-dot {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        background: var(--teal);
      }

      .todo-item strong {
        display: block;
      }

      .agenda-card {
        background: linear-gradient(180deg, rgba(17,35,51,0.98), rgba(18,30,42,0.96));
        color: #fff;
        border-radius: 18px;
        padding: 20px 18px;
        border: 1px solid rgba(255,255,255,0.08);
        box-shadow: 0 10px 25px rgba(17,35,51,0.3);
      }

      .agenda-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        color: rgba(245,249,252,0.84);
        font-family: "Segoe UI", Arial, sans-serif;
        letter-spacing: 0.14em;
        text-transform: uppercase;
        font-size: 0.72rem;
      }

      .agenda-course {
        font-size: clamp(3rem, 4vw, 5rem);
        line-height: 1;
        margin-top: 10px;
        letter-spacing: -0.06em;
        font-weight: 700;
      }

      .agenda-meta {
        margin-top: 12px;
        font-family: "Segoe UI", Arial, sans-serif;
        color: rgba(255,255,255,0.8);
      }

      .lesson-layout {
        display: grid;
        grid-template-columns: repeat(2, minmax(280px, 1fr));
        gap: 20px;
      }

      .lesson-day {
        border: 1px solid var(--line);
        border-radius: 16px;
        background: rgba(255,255,255,0.22);
        overflow: hidden;
      }

      .lesson-day-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 16px 18px;
        font-family: "Segoe UI", Arial, sans-serif;
        color: var(--muted);
        border-bottom: 1px solid var(--line);
        text-transform: uppercase;
        letter-spacing: 0.12em;
        font-size: 0.75rem;
      }

      .lesson-item {
        display: grid;
        grid-template-columns: 52px 1fr auto;
        gap: 12px;
        padding: 16px 16px;
        border-bottom: 1px solid rgba(17,28,35,0.08);
      }

      .lesson-item:last-child { border-bottom: none; }

      .time {
        font-family: "Segoe UI", Arial, sans-serif;
        color: var(--muted);
        font-size: 0.82rem;
      }

      .lesson-bar {
        width: 4px;
        border-radius: 999px;
        height: 46px;
        align-self: center;
      }

      .lesson-course {
        font-size: 1.65rem;
        line-height: 1.2;
        margin: 0;
      }

      .lesson-teacher {
        color: var(--muted);
        font-family: "Segoe UI", Arial, sans-serif;
        font-size: 0.92rem;
      }

      .badge {
        align-self: center;
        font-family: "Segoe UI", Arial, sans-serif;
        font-size: 0.72rem;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        color: var(--teal-2);
        background: rgba(27,125,141,0.08);
        border: 1px solid rgba(27,125,141,0.14);
        border-radius: 999px;
        padding: 6px 8px;
      }

      .forms-grid {
        display: grid;
        grid-template-columns: repeat(4, minmax(180px, 1fr));
        gap: 14px;
        margin-bottom: 20px;
      }

      .input, .textarea, .select {
        width: 100%;
        border: 1px solid rgba(17,28,35,0.12);
        border-radius: 12px;
        background: rgba(255,255,255,0.3);
        padding: 12px 14px;
        font-size: 1rem;
        font-family: "Segoe UI", Arial, sans-serif;
        color: var(--ink);
      }

      .textarea { min-height: 110px; resize: vertical; }

      .primary-btn {
        background: linear-gradient(180deg, var(--teal), var(--teal-2));
        border: none;
        color: white;
        border-radius: 12px;
        padding: 14px 18px;
        font-family: "Segoe UI", Arial, sans-serif;
        font-weight: 700;
        cursor: pointer;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        font-family: "Segoe UI", Arial, sans-serif;
      }

      th, td {
        padding: 14px 12px;
        border-bottom: 1px solid rgba(17,28,35,0.09);
        text-align: left;
      }

      th {
        color: var(--muted);
        text-transform: uppercase;
        letter-spacing: 0.08em;
        font-size: 0.76rem;
      }

      .muted { color: var(--muted); }

      .note-item,
      .announcement-item,
      .reminder-item {
        border: 1px solid rgba(17,28,35,0.08);
        background: rgba(255,255,255,0.22);
        border-radius: 12px;
        padding: 14px 16px;
      }

      .upload-box {
        border: 2px dashed rgba(17,28,35,0.16);
        border-radius: 16px;
        background: rgba(255,255,255,0.2);
        padding: 22px;
        text-align: center;
        cursor: pointer;
        margin-bottom: 18px;
      }

      @media (max-width: 980px) {
        .app-shell { grid-template-columns: 1fr; }
        .sidebar { min-height: auto; }
        .stats-grid, .dash-grid, .lesson-layout { grid-template-columns: 1fr; }
        .forms-grid { grid-template-columns: 1fr 1fr; }
      }

      @media (max-width: 640px) {
        .main { padding: 24px 16px 36px; }
        .forms-grid { grid-template-columns: 1fr; }
        .headline { flex-direction: column; align-items: flex-start; }
        .brand-text { font-size: 1.6rem; }
      }
    </style>
  </head>
  <body>
    <div class="app-shell">
      <aside class="sidebar">
        <div class="brand">
          <div class="brand-mark">Z</div>
          <div>
            <div class="brand-text">Registro</div>
            <span class="brand-sub">Zaccaria</span>
          </div>
        </div>

        <nav class="menu" aria-label="Menu principale">
          <button class="menu-item active" data-page="oggi"><span class="menu-icon">◫</span>Oggi</button>
          <button class="menu-item" data-page="voti"><span class="menu-icon">◌</span>Voti</button>
          <button class="menu-item" data-page="lezioni"><span class="menu-icon">▣</span>Lezioni</button>
          <button class="menu-item" data-page="appunti"><span class="menu-icon">☰</span>Appunti</button>
          <button class="menu-item" data-page="avvisi"><span class="menu-icon">◔</span>Avvisi</button>
          <button class="menu-item" data-page="promemoria"><span class="menu-icon">◍</span>Promemoria</button>
        </nav>

        <div class="profile-box">
          <div class="avatar">ES</div>
          <div>
            <strong>Edoardo</strong><br>
            <span class="muted" style="font-size:0.75rem; font-family:'Segoe UI',Arial,sans-serif;">Il tuo regis...</span>
          </div>
        </div>
      </aside>

      <main class="main">
        <div class="topbar">
          <div class="top-title">Registro Studente</div>
          <div class="topbar-right">
            <div class="chip">Anno scolastico 2024–25</div>
            <div class="chip">ES</div>
          </div>
        </div>

        <section class="page active" id="page-oggi">
          <div class="headline">
            <div>
              <h1 class="page-heading">Studia con <span class="accent">più presenza.</span></h1>
              <div class="subcopy">Voti, lezioni, appunti e promemoria in un unico registro moderno, pensato per il tuo percorso scolastico.</div>
            </div>
          </div>

          <div class="stats-grid">
            <div class="stat-card">
              <div class="kicker">Media</div>
              <div class="big-stat" id="avgGrade">8.2</div>
              <div class="small-note">+0.3 rispetto al mese scorso</div>
            </div>

            <div class="stat-card">
              <div class="kicker">Presenze</div>
              <div class="big-stat" id="attendancePercent">96%</div>
              <div class="small-note">Ottimo andamento</div>
            </div>

            <div class="stat-card">
              <div class="kicker">Prossimo in agenda</div>
              <div class="big-stat" style="font-size:2.2rem;">Matematica</div>
              <div class="small-note">08:00 · Aula 2.4</div>
            </div>
          </div>

          <div class="dash-grid">
            <div class="card">
              <div class="section-head">
                <h3>I tuoi voti</h3>
                <button class="link-btn" data-page="voti">Vedi tutti →</button>
              </div>
              <div id="recentGrades"></div>
            </div>

            <div class="card">
              <div class="section-head">
                <h3>Promemoria</h3>
                <button class="link-btn" data-page="promemoria">Apri agenda</button>
              </div>
              <div id="recentReminders" class="todo-list"></div>
            </div>
          </div>
        </section>

        <section class="page" id="page-voti">
          <div class="section-head" style="margin-bottom:20px;">
            <h3 style="font-size:2.2rem; margin:0;">Registro voti</h3>
          </div>

          <div class="panel" style="padding:20px; margin-bottom:18px;">
            <div class="forms-grid">
              <input class="input" id="gradeSubject" placeholder="Materia" />
              <input class="input" id="gradeValue" type="number" min="1" max="10" step="0.5" placeholder="Voto" />
              <input class="input" id="gradeTeacher" placeholder="Insegnante" />
              <button class="primary-btn" id="addGradeBtn">Aggiungi</button>
            </div>
          </div>

          <div class="panel" style="padding:16px 14px;">
            <table>
              <thead>
                <tr>
                  <th>Materia</th>
                  <th>Voto</th>
                  <th>Insegnante</th>
                  <th>Data</th>
                  <th>Azioni</th>
                </tr>
              </thead>
              <tbody id="gradesTableBody"></tbody>
            </table>
          </div>
        </section>

        <section class="page" id="page-lezioni">
          <div class="section-head" style="margin-top:8px; margin-bottom:18px;">
            <h3 style="font-size:2.6rem;">Il ritmo della settimana</h3>
            <button class="link-btn">Settimana corrente</button>
          </div>

          <div class="lesson-layout" id="lessonLayout"></div>
        </section>

        <section class="page" id="page-appunti">
          <div class="section-head">
            <h3 style="font-size:2.4rem;">Appunti</h3>
          </div>

          <div class="upload-box" id="uploadBox">
            <div style="font-size:1.7rem; margin-bottom:10px;">📁</div>
            <strong>Carica un file</strong>
            <div class="muted" style="margin-top:6px; font-family:'Segoe UI',Arial,sans-serif;">Trascina un appunto o clicca qui</div>
            <input type="file" id="noteInput" style="display:none;" />
          </div>

          <div id="notesList"></div>
        </section>

        <section class="page" id="page-avvisi">
          <div class="section-head">
            <h3 style="font-size:2.4rem;">Avvisi</h3>
          </div>

          <div class="panel" style="padding:18px; margin-bottom:18px;">
            <div class="forms-grid" style="grid-template-columns: repeat(2, minmax(150px,1fr));">
              <input class="input" id="announcementTitle" placeholder="Titolo" />
              <input class="input" id="announcementAuthor" placeholder="Autore" />
              <textarea class="textarea" id="announcementBody" placeholder="Testo dell'avviso" style="grid-column:1/-1;"></textarea>
              <button class="primary-btn" id="addAnnouncementBtn" style="grid-column:1/-1;">Aggiungi avviso</button>
            </div>
          </div>

          <div id="announcementsList"></div>
        </section>

        <section class="page" id="page-promemoria">
          <div class="section-head">
            <h3 style="font-size:2.4rem;">Promemoria</h3>
          </div>

          <div class="panel" style="padding:18px; margin-bottom:18px;">
            <div class="forms-grid">
              <input class="input" id="reminderTitle" placeholder="Titolo" />
              <input class="input" id="reminderSubject" placeholder="Materia" />
              <input class="input" id="reminderDate" type="date" />
              <button class="primary-btn" id="addReminderBtn">Aggiungi</button>
            </div>
          </div>

          <div id="remindersList"></div>
        </section>
      </main>
    </div>

    <script>
      const SUPABASE_URL = 'https://YOUR_PROJECT.supabase.co';
      const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY';

      const state = {
        supabase: null,
        user: null,
        grades: [],
        reminders: [],
        announcements: [],
        notes: [],
        lessons: []
      };

      function initSupabase() {
        if (SUPABASE_URL.includes('YOUR_PROJECT') || SUPABASE_ANON_KEY.includes('YOUR_')) {
          console.warn('Inserisci URL e anon key reali di Supabase nel file HTML.');
          return;
        }
        state.supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
      }

      function switchPage(page) {
        document.querySelectorAll('.page').forEach(el => el.classList.remove('active'));
        document.getElementById('page-' + page).classList.add('active');
        document.querySelectorAll('.menu-item').forEach(el => el.classList.toggle('active', el.dataset.page === page));
      }

      function renderRecentGrades() {
        const container = document.getElementById('recentGrades');
        const rows = (state.grades || []).slice(0, 4);

        if (!rows.length) {
          container.innerHTML = '<div class="muted">Nessun voto registrato.</div>';
          return;
        }

        container.innerHTML = rows.map(item => {
          const color = Number(item.value) >= 8 ? '#1a8c6b' : '#d37d52';
          const bg = Number(item.value) >= 8 ? '#dff8ef' : '#fde7df';
          return `
            <div class="grade-row">
              <div class="subject-box">
                <span class="subject-pill" style="background:${color};"></span>
                <div>
                  <p class="subject-name">${item.subject_name}</p>
                  <div class="subject-meta">${item.teacher || 'Docente'}</div>
                </div>
              </div>
              <span class="score" style="background:${bg}; color:${color};">${Number(item.value).toFixed(1)}</span>
            </div>
          `;
        }).join('');
      }

      function renderReminders() {
        const container = document.getElementById('recentReminders');
        const list = (state.reminders || []).slice(0, 3);

        if (!list.length) {
          container.innerHTML = '<div class="muted">Nessun promemoria.</div>';
          return;
        }

        container.innerHTML = list.map(item => `
          <div class="todo-item">
            <span class="todo-dot" style="background:${item.completed ? '#7db3a3' : '#1e7d8a'}"></span>
            <div>
              <strong>${item.title}</strong>
              <span class="muted" style="font-family:'Segoe UI',Arial,sans-serif; display:block; font-size:0.85rem; margin-top:2px;">${item.subject_name || 'Generale'} · ${item.due_at ? new Date(item.due_at).toLocaleDateString('it-IT') : 'Da definire'}</span>
            </div>
          </div>
        `).join('');
      }

      function renderGradesTable() {
        const tbody = document.getElementById('gradesTableBody');
        if (!state.grades.length) {
          tbody.innerHTML = '<tr><td colspan="5" class="muted">Nessun voto inserito.</td></tr>';
          return;
        }

        tbody.innerHTML = state.grades.map(item => `
          <tr>
            <td>${item.subject_name}</td>
            <td><span class="score" style="background:${Number(item.value)>=8 ? '#dff8ef' : '#fde7df'}; color:${Number(item.value)>=8 ? '#1a8c6b' : '#d37d52'}; min-width:50px; height:42px; font-size:1.3rem;">${Number(item.value).toFixed(1)}</span></td>
            <td>${item.teacher || '-'}</td>
            <td>${new Date(item.graded_on).toLocaleDateString('it-IT')}</td>
            <td><button class="link-btn" style="padding:8px 12px;" data-delete-grade="${item.id}">Elimina</button></td>
          </tr>
        `).join('');
      }

      function renderLessonWeekly() {
        const days = [
          { name: 'Lunedì', date: '1 Gen' },
          { name: 'Martedì', date: '2 Gen' },
          { name: 'Mercoledì', date: '3 Gen' },
          { name: 'Giovedì', date: '4 Gen' },
          { name: 'Venerdì', date: '5 Gen' }
        ];

        const container = document.getElementById('lessonLayout');
        const lessonSets = days.map(day => {
          const lessons = (state.lessons || []).filter(l => new Date(l.starts_at).toLocaleDateString('it-IT', { weekday: 'long' }).toLowerCase().includes(day.name.toLowerCase()));
          const items = lessons.length ? lessons.map(lesson => {
            const color = lesson.subject_name === 'Matematica' ? '#ef7d4d' : lesson.subject_name === 'Italiano' ? '#4dd0b8' : lesson.subject_name === 'Fisica' ? '#af6eea' : '#f2c75c';
            return `
              <div class="lesson-item">
                <div class="time">${new Date(lesson.starts_at).toLocaleTimeString('it-IT', {hour:'2-digit', minute:'2-digit'})}</div>
                <div class="lesson-bar" style="background:${color};"></div>
                <div>
                  <p class="lesson-course">${lesson.subject_name}</p>
                  <div class="lesson-teacher">${lesson.teacher || '-'}</div>
                </div>
                <div class="badge">${lesson.classroom || 'Aula'}</div>
              </div>
            `;
          }).join('') : '<div class="lesson-item"><div class="muted" style="padding:12px;">Nessuna lezione.</div></div>';

          return `
            <div class="lesson-day">
              <div class="lesson-day-header"><span>${day.name}</span><span>${day.date}</span></div>
              ${items}
            </div>
          `;
        }).join('');

        container.innerHTML = lessonSets;
      }

      function renderNotes() {
        const container = document.getElementById('notesList');
        if (!state.notes.length) {
          container.innerHTML = '<div class="muted">Nessun appunto caricato.</div>';
          return;
        }

        container.innerHTML = state.notes.map(item => `
          <div class="note-item" style="margin-bottom:12px;">
            <div style="display:flex; justify-content:space-between; gap:10px; align-items:flex-start;">
              <div>
                <strong>${item.title}</strong>
                <div class="muted" style="margin-top:6px; font-family:'Segoe UI',Arial,sans-serif;">${item.subject_name || 'Generale'} · ${new Date(item.created_at).toLocaleDateString('it-IT')}</div>
              </div>
              ${item.file_url ? `<a href="${item.file_url}" target="_blank" class="link-btn" style="padding:8px 12px;">Apri</a>` : ''}
            </div>
          </div>
        `).join('');
      }

      function renderAnnouncements() {
        const container = document.getElementById('announcementsList');
        if (!state.announcements.length) {
          container.innerHTML = '<div class="muted">Nessun avviso.</div>';
          return;
        }

        container.innerHTML = state.announcements.map(item => `
          <div class="announcement-item" style="margin-bottom:12px;">
            <strong>${item.title}</strong>
            <div class="muted" style="margin-top:6px; font-family:'Segoe UI',Arial,sans-serif;">${item.author}</div>
            <p style="margin:10px 0 0; line-height:1.6; font-family:'Segoe UI',Arial,sans-serif;">${item.body}</p>
          </div>
        `).join('');
      }

      function renderRemindersList() {
        const container = document.getElementById('remindersList');
        if (!state.reminders.length) {
          container.innerHTML = '<div class="muted">Nessun promemoria.</div>';
          return;
        }

        container.innerHTML = state.reminders.map(item => `
          <div class="reminder-item" style="margin-bottom:12px; display:flex; justify-content:space-between; align-items:center; gap:12px;">
            <div>
              <strong>${item.title}</strong>
              <div class="muted" style="margin-top:6px; font-family:'Segoe UI',Arial,sans-serif;">${item.subject_name || 'Generale'} · ${item.due_at ? new Date(item.due_at).toLocaleDateString('it-IT') : 'Da definire'}</div>
            </div>
            <button class="link-btn" data-toggle-reminder="${item.id}">${item.completed ? 'Completato' : 'Da fare'}</button>
          </div>
        `).join('');
      }

      async function fetchAllData() {
        if (!state.supabase) return;
        const { data: { user } } = await state.supabase.auth.getUser();
        if (!user) {
          console.log('User not logged in');
          return;
        }

        state.user = user;

        const [gradesRes, remindersRes, announcementsRes, notesRes, lessonsRes] = await Promise.all([
          state.supabase.from('grades').select('*').eq('user_id', user.id).order('graded_on', { ascending: false }),
          state.supabase.from('reminders').select('*').eq('user_id', user.id).order('due_at', { ascending: true }),
          state.supabase.from('announcements').select('*').eq('user_id', user.id).order('published_at', { ascending: false }),
          state.supabase.from('notes').select('*').eq('user_id', user.id).order('created_at', { ascending: false }),
          state.supabase.from('lessons').select('*').eq('user_id', user.id).order('starts_at', { ascending: true })
        ]);

        state.grades = gradesRes.data || [];
        state.reminders = remindersRes.data || [];
        state.announcements = announcementsRes.data || [];
        state.notes = notesRes.data || [];
        state.lessons = lessonsRes.data || [];

        renderRecentGrades();
        renderReminders();
        renderGradesTable();
        renderLessonWeekly();
        renderNotes();
        renderAnnouncements();
        renderRemindersList();

        const avg = state.grades.length ? (state.grades.reduce((sum, item) => sum + Number(item.value), 0) / state.grades.length).toFixed(1) : '0.0';
        document.getElementById('avgGrade').textContent = avg;
      }

      async function addGrade() {
        if (!state.supabase || !state.user) return;
        const subject = document.getElementById('gradeSubject').value.trim();
        const value = Number(document.getElementById('gradeValue').value);
        const teacher = document.getElementById('gradeTeacher').value.trim();
        if (!subject || !value) {
          alert('Inserisci materia e voto.');
          return;
        }

        const { error } = await state.supabase.from('grades').insert({
          user_id: state.user.id,
          subject_name: subject,
          value,
          teacher,
          assessment_type: 'Verifica',
          graded_on: new Date().toISOString().slice(0, 10)
        });

        if (!error) {
          document.getElementById('gradeSubject').value = '';
          document.getElementById('gradeValue').value = '';
          document.getElementById('gradeTeacher').value = '';
          fetchAllData();
        } else {
          alert(error.message);
        }
      }

      async function addAnnouncement() {
        if (!state.supabase || !state.user) return;
        const title = document.getElementById('announcementTitle').value.trim();
        const author = document.getElementById('announcementAuthor').value.trim() || 'Istituto Zaccaria';
        const body = document.getElementById('announcementBody').value.trim();
        if (!title || !body) {
          alert('Titolo e testo sono obbligatori.');
          return;
        }

        const { error } = await state.supabase.from('announcements').insert({
          user_id: state.user.id,
          title,
          author,
          body,
          is_read: false,
          published_at: new Date().toISOString()
        });

        if (!error) {
          document.getElementById('announcementTitle').value = '';
          document.getElementById('announcementAuthor').value = '';
          document.getElementById('announcementBody').value = '';
          fetchAllData();
        } else {
          alert(error.message);
        }
      }

      async function addReminder() {
        if (!state.supabase || !state.user) return;
        const title = document.getElementById('reminderTitle').value.trim();
        const subject = document.getElementById('reminderSubject').value.trim();
        const due_at = document.getElementById('reminderDate').value;
        if (!title) {
          alert('Titolo obbligatorio.');
          return;
        }

        const { error } = await state.supabase.from('reminders').insert({
          user_id: state.user.id,
          title,
          subject_name: subject,
          due_at: due_at ? new Date(due_at).toISOString() : null,
          completed: false
        });

        if (!error) {
          document.getElementById('reminderTitle').value = '';
          document.getElementById('reminderSubject').value = '';
          document.getElementById('reminderDate').value = '';
          fetchAllData();
        } else {
          alert(error.message);
        }
      }

      async function uploadNote(event) {
        if (!state.supabase || !state.user) return;
        const file = event.target.files[0];
        if (!file) return;

        const storagePath = `${state.user.id}/${Date.now()}-${file.name}`;
        const { error: uploadError } = await state.supabase.storage.from('appunti').upload(storagePath, file, { upsert: true });
        if (uploadError) {
          alert(uploadError.message);
          return;
        }

        const { data: publicUrlData } = state.supabase.storage.from('appunti').getPublicUrl(storagePath);

        const { error } = await state.supabase.from('notes').insert({
          user_id: state.user.id,
          title: file.name,
          file_name: file.name,
          storage_path: storagePath,
          file_url: publicUrlData.publicUrl,
          mime_type: file.type,
          file_size: file.size,
          created_at: new Date().toISOString()
        });

        if (!error) {
          fetchAllData();
          event.target.value = '';
        } else {
          alert(error.message);
        }
      }

      async function deleteGrade(id) {
        if (!state.supabase) return;
        const { error } = await state.supabase.from('grades').delete().eq('id', id);
        if (!error) fetchAllData();
      }

      async function toggleReminder(id) {
        if (!state.supabase) return;
        const item = state.reminders.find(r => r.id === id);
        if (!item) return;
        const { error } = await state.supabase.from('reminders').update({ completed: !item.completed }).eq('id', id);
        if (!error) fetchAllData();
      }

      document.querySelectorAll('.menu-item').forEach(item => {
        item.addEventListener('click', () => switchPage(item.dataset.page));
      });

      document.querySelectorAll('.link-btn').forEach(button => {
        button.addEventListener('click', (event) => {
          const page = event.currentTarget.dataset.page;
          if (page) switchPage(page);
        });
      });

      document.getElementById('addGradeBtn').addEventListener('click', addGrade);
      document.getElementById('addAnnouncementBtn').addEventListener('click', addAnnouncement);
      document.getElementById('addReminderBtn').addEventListener('click', addReminder);
      document.getElementById('uploadBox').addEventListener('click', () => document.getElementById('noteInput').click());
      document.getElementById('noteInput').addEventListener('change', uploadNote);

      document.addEventListener('click', async (event) => {
        const gradeBtn = event.target.closest('[data-delete-grade]');
        if (gradeBtn) return deleteGrade(gradeBtn.dataset.deleteGrade);

        const reminderBtn = event.target.closest('[data-toggle-reminder]');
        if (reminderBtn) return toggleReminder(reminderBtn.dataset.toggleReminder);
      });

      initSupabase();
      window.addEventListener('load', async () => {
        // Il login avviene in Supabase Auth; altrimenti aggiungi qui la tua auth.
        if (state.supabase) {
          const { data: { user } } = await state.supabase.auth.getUser();
          state.user = user;
          if (!user) {
            console.log('Nessun utente autenticato. Effettua il login via Supabase Auth.');
          } else {
            fetchAllData();
          }
        }
      });
    </script>
  </body>
</html>















































































































