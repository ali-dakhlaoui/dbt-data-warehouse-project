with events as (
    select * from {{ ref('dim_events') }}
),

fact_events as (
    select
        event_id,
        user_id,
        occurred_at,
        event_date,
        event_hour,
        event_type,
        platform,
        session_id
    from events
)

select * from fact_events
