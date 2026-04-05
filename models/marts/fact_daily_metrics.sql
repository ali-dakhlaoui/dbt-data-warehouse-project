with events as (
    select
        date(occurred_at) as event_date,
        user_id,
        event_id
    from {{ ref('stg_events') }}
),

user_signups as (
    select
        date(created_at) as signup_date,
        user_id
    from {{ ref('stg_users') }}
),

user_conversions as (
    select
        date(converted_at) as conversion_date,
        user_id
    from {{ ref('stg_users') }}
    where converted_at is not null
),

user_churns as (
    select
        date(churned_at) as churn_date,
        user_id
    from {{ ref('stg_users') }}
    where churned_at is not null
),

subscriptions as (
    select
        date(started_at) as subscription_date,
        user_id,
        mrr
    from {{ ref('stg_subscriptions') }}
),

daily_metrics as (
    select
        e.event_date as date,
        count(distinct e.user_id) as daily_active_users,
        count(e.event_id) as total_events,
        count(distinct s.user_id) as new_users,
        count(distinct c.user_id) as converted_users,
        count(distinct h.user_id) as churned_users,
        sum(coalesce(sub.mrr, 0)) / 100.0 as mrr
    from events e
    left join user_signups s on e.event_date = s.signup_date and e.user_id = s.user_id
    left join user_conversions c on e.event_date = c.conversion_date and e.user_id = c.user_id
    left join user_churns h on e.event_date = h.churn_date and e.user_id = h.user_id
    left join subscriptions sub on e.user_id = sub.user_id
    group by e.event_date
)

select * from daily_metrics
order by date
