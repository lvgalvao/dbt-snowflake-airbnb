{{
    config(
        materialized = 'incremental',
        on_schema_chrange='fail'
    )
}}

WITH src_reviews AS (
    SELECT * FROM {{ ref('bronze_reviews')}}
)

SELECT 
    {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'review_text']) }} as review_id,
* FROM src_reviews
WHERE review_text is not null

{% if is_incremental() %}
    AND review_date > (select max(review_date) from {{ this }})
{% endif %}