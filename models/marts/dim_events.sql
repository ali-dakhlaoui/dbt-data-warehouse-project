with events as (
    select * from {{ ref('stg_events') }}
),

dim_events as (
    select
        event_id,
        user_id,
        event_type,
        platform,
        occurred_at,
        session_id,
        date(occurred_at) as event_date,
        extract(hour from occurred_at) as event_hour
    from events
)

select * from dim_events
