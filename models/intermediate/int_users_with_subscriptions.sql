with users as (
    select * from {{ ref('stg_users') }}
),

subscriptions as (
    select 
        user_id,
        subscription_id,
        status as subscription_status,
        mrr,
        row_number() over (partition by user_id order by started_at desc) as rn
    from {{ ref('stg_subscriptions') }}
),

user_subscriptions as (
    select
        u.user_id,
        u.email,
        u.full_name,
        u.company,
        u.plan as current_plan,
        u.created_at,
        u.converted_at,
        u.churned_at,
        u.last_login_at,
        s.subscription_id,
        s.subscription_status,
        s.mrr,
        case
            when u.churned_at is not null then 'churned'
            when u.converted_at is not null then 'converted'
            else 'free'
        end as user_status
    from users u
    left join subscriptions s on u.user_id = s.user_id and s.rn = 1
)

select * from user_subscriptions
