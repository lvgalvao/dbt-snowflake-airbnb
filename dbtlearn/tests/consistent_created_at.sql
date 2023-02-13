SELECT
    *
FROM
    {{ ref('fct_reviews')}} fct
JOIN {{ ref('dim_listings_cleansed')}} dim on (fct.listing_id=dim.LISTING_ID)

WHERE fct.review_date <= dim.created_at
LIMIT 10