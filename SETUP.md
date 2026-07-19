# Colorado Boys Trip 2026 — setup guide

You have two files that matter:
- `index.html` — the whole app (open it directly in a browser, no install needed)
- `supabase-schema.sql` — run this once inside Supabase to create the shared storage table

Right now `index.html` works standalone (it saves to your browser only). Follow the steps below to turn on shared, synced storage.

## 1. Create a Supabase project (free)
1. Go to supabase.com and sign up / log in.
2. Click "New project." Pick any name (e.g. `colorado-trip`), set a database password (save it somewhere), pick a region close to you.
3. Wait ~2 minutes for it to spin up.

## 2. Create the shared table
1. In your Supabase project, open the **SQL Editor** in the left sidebar.
2. Click "New query," paste in the entire contents of `supabase-schema.sql`, and click **Run**.
3. If the last line (`alter publication supabase_realtime add table trip_state;`) errors, that's fine — instead go to **Database → Replication** in the sidebar and toggle realtime **on** for the `trip_state` table manually.

## 3. Get your project keys
1. In Supabase, go to **Project Settings → API**.
2. Copy the **Project URL** (looks like `https://xxxxxxxx.supabase.co`).
3. Copy the **anon public** key (a long string starting with `eyJ...`).

## 4. Connect the app
1. Open `index.html` in a text editor.
2. Find this block near the top of the `<script>` section:
   ```js
   const SUPABASE_URL = "YOUR_SUPABASE_URL";
   const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";
   ```
3. Replace the two placeholder strings with your actual URL and anon key from step 3.
4. Save the file, then open it in your browser. The yellow "not connected" banner should disappear. Try editing something, then reload the page — if it's still there, it's working.

## 5. Test sharing
Open the file in a different browser (or send it to a friend to open on their own computer, once it's live — see step 6). Edits made in one should appear in the other within a second or two, since realtime sync is on.

## 6. Put it on GitHub and deploy
1. Create a new repository on GitHub (e.g. `colorado-trip-2026`). Public is simplest; private + inviting your friends as collaborators also works.
2. Push `index.html` to the repo, named exactly `index.html` (this matters for step 7).
   ```
   git init
   git add index.html
   git commit -m "Trip planner"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/colorado-trip-2026.git
   git push -u origin main
   ```
3. In the repo on GitHub, go to **Settings → Pages**.
4. Under "Build and deployment," set Source to **Deploy from a branch**, branch `main`, folder `/ (root)`. Save.
5. Wait a minute, then refresh — GitHub gives you a live URL like `https://YOUR_USERNAME.github.io/colorado-trip-2026/`.
6. Send that link to your friends. Anyone who opens it can edit and everyone stays in sync.

## Notes on security
This setup uses Supabase's public "anon" key directly in the HTML, and the database is open to anyone who has that key (i.e. anyone who opens your site) to read and write. That's a reasonable tradeoff for a casual trip planner shared with friends — there's no login step to get in anyone's way. It is not appropriate for anything sensitive (don't put payment info, personal documents, etc. into this app).

## If you want to go further later
The original handoff `README.md` includes a more fully-relational database schema (separate `trips`, `days`, `activities`, `tasks` tables) and covers additional sections (Participants, Flights, Expenses, etc.) if you ever want to rebuild this as a more "production" app, possibly with real authentication. This version intentionally keeps things simple to get you a working, shareable planner fast.
