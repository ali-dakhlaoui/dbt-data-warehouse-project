with source as (
    select * from {{ source('telemetry', 'raw_events') }}
),

renamed as (
    select
        event_id,
        user_id,
        event_type,
        event_properties,
        occurred_at,
        session_id,
        platform,
        ip_address
    from source
)

select * from renamed
