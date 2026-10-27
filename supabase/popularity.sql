-- scores.popularity_last_7d: percentile rank (0–100) of each score's open
-- count in score_opens over the last 7 days. 100 = most opened; scores with no
-- opens tie at the bottom and get 0. Refreshed hourly by pg_cron.
-- Prerequisite: enable the pg_cron extension (Dashboard → Database → Extensions).
-- Idempotent: safe to re-run in the SQL editor.

alter table public.scores add column if not exists popularity_last_7d smallint
  not null default 0 check (popularity_last_7d between 0 and 100);

create index if not exists score_opens_created_at_idx on public.score_opens (created_at);

create or replace function public.refresh_score_popularity()
returns void language sql security definer set search_path = public as $$
  with counts as (
    select score_id, count(*) as n from score_opens
    where created_at > now() - interval '7 days' group by score_id
  ), ranked as (
    select s.id,
           round(100 * percent_rank() over (order by coalesce(c.n, 0)))::smallint as p
    from scores s left join counts c on c.score_id = s.id
  )
  update scores s set popularity_last_7d = r.p
  from ranked r where s.id = r.id;
$$;
-- Server-side only: clients must not be able to trigger it via RPC.
revoke execute on function public.refresh_score_popularity() from public, anon, authenticated;

-- Hourly. Scheduling under the same name replaces the existing job.
select cron.schedule('refresh-score-popularity', '0 * * * *',
  $$select public.refresh_score_popularity()$$);
