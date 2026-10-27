-- Row Level Security policies for the Scores2Go Supabase project.
-- The publishable key in lib/main.dart is public by design; these policies are
-- what actually protect user data. Idempotent: safe to re-run in the SQL editor.
-- Unchanged and not managed here: user_favorites (owner-only ALL), scores
-- (public read), user_score_collections DELETE (owner-only).

-- user_score_collections: owner-only
drop policy if exists "Enable read access for all users" on public.user_score_collections;
drop policy if exists "Enable insert for authenticated users only" on public.user_score_collections;
drop policy if exists "Owner select" on public.user_score_collections;
drop policy if exists "Owner insert" on public.user_score_collections;
drop policy if exists "Owner update" on public.user_score_collections;
create policy "Owner select" on public.user_score_collections for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "Owner insert" on public.user_score_collections for insert to authenticated
  with check ((select auth.uid()) = user_id);
create policy "Owner update" on public.user_score_collections for update to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);

-- score_collection_scores: ownership via parent collection
drop policy if exists "Enable read access for all users" on public.score_collection_scores;
drop policy if exists "Enable insert for authenticated users only" on public.score_collection_scores;
drop policy if exists "Enable delete for users based on user_id" on public.score_collection_scores;
drop policy if exists "Owner select" on public.score_collection_scores;
drop policy if exists "Owner insert" on public.score_collection_scores;
drop policy if exists "Owner delete" on public.score_collection_scores;
create policy "Owner select" on public.score_collection_scores for select to authenticated
  using (exists (select 1 from public.user_score_collections c
                 where c.id = user_score_collection_id and c.user_id = (select auth.uid())));
create policy "Owner insert" on public.score_collection_scores for insert to authenticated
  with check (exists (select 1 from public.user_score_collections c
                      where c.id = user_score_collection_id and c.user_id = (select auth.uid())));
create policy "Owner delete" on public.score_collection_scores for delete to authenticated
  using (exists (select 1 from public.user_score_collections c
                 where c.id = user_score_collection_id and c.user_id = (select auth.uid())));

-- user_feedback: insert-only from the client (no read access). Signed-in users
-- submit as themselves; anonymous users submit with user_id null (the column
-- default auth.uid() yields null for anon). Constraints cap what a script
-- holding the public key can write. NOT VALID skips checking existing rows.
alter table public.user_feedback alter column user_id drop not null;
alter table public.user_feedback drop constraint if exists user_feedback_feedback_length;
alter table public.user_feedback add constraint user_feedback_feedback_length
  check (char_length(feedback) <= 2000) not valid;
alter table public.user_feedback drop constraint if exists user_feedback_stars_range;
alter table public.user_feedback add constraint user_feedback_stars_range
  check (stars between 1 and 5) not valid;

drop policy if exists "Enable insert for authenticated users only" on public.user_feedback;
drop policy if exists "Own insert" on public.user_feedback;
drop policy if exists "Anon insert" on public.user_feedback;
create policy "Own insert" on public.user_feedback for insert to authenticated
  with check ((select auth.uid()) = user_id);
create policy "Anon insert" on public.user_feedback for insert to anon
  with check (user_id is null);
