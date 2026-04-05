with source as (
    select * from {{ source('telemetry', 'raw_users') }}
),

renamed as (
    select
        user_id,
        email,
        full_name,
        company,
        plan,
        created_at,
        converted_at,
        churned_at,
        last_login_at
    from source
)

select * from renamed
