with users as (
    select * from {{ ref('int_users_with_subscriptions') }}
),

dim_users as (
    select
        user_id,
        email,
        full_name,
        company,
        current_plan,
        user_status,
        created_at,
        converted_at,
        churned_at,
        last_login_at,
        datediff('day', created_at, current_timestamp) as days_since_signup,
        case
            when churned_at is not null then datediff('day', churned_at, current_timestamp)
            when last_login_at is not null then datediff('day', last_login_at, current_timestamp)
            else null
        end as days_since_last_login,
        case
            when churned_at is null then true
            else false
        end as is_active
    from users
)

select * from dim_users
