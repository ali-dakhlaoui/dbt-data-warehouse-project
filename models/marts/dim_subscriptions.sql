with subscriptions as (
    select * from {{ ref('stg_subscriptions') }}
),

dim_subscriptions as (
    select
        subscription_id,
        user_id,
        plan,
        status,
        started_at,
        ended_at,
        mrr / 100.0 as mrr,
        case
            when status = 'active' then true
            else false
        end as is_active,
        case
            when ended_at is not null then datediff('day', started_at, ended_at)
            else datediff('day', started_at, current_timestamp)
        end as subscription_duration_days
    from subscriptions
    where subscription_id is not null
)

select * from dim_subscriptions
