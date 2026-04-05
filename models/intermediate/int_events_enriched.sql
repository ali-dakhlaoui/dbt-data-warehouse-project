with events as (
    select * from {{ ref('stg_events') }}
),

user_events_enriched as (
    select
        e.*,
        u.email,
        u.full_name,
        u.company,
        u.plan,
        u.created_at as user_created_at,
        u.converted_at
    from events e
    left join {{ ref('stg_users') }} u using (user_id)
)

select * from user_events_enriched
