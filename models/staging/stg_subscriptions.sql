with source as (
    select * from {{ source('telemetry', 'raw_subscriptions') }}
),

renamed as (
    select
        subscription_id,
        user_id,
        plan,
        status,
        started_at,
        ended_at,
        mrr
    from source
)

select * from renamed
