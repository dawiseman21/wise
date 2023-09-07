




--Question 1
select state_name --include state names
    , region_name --include region names
from regions
order by state_name asc --sort states by alphabetical order

--Question 2
with pet_names as (
    select name
        , color
        --    , breed --don't need breed, but could bring it in at some point
    from dogs
    union --need to append the two tables. Names across the two are  simple
    select name
        , color
        --    , breed
    from cats
  )
select distinct name --limit results to unique pet names
from pet_names
where color = 'brown' --limit results to brown

/* Notes on Q2
If you wanted to tell whether it was a dog or cat, you could add 'dog'/'cat' as
 animal_type within the respective select statements within the CTE.

You could also apply the 'brown' filter condition to the CTE, but this is a little cleaner.
If you were worried about CTE response size, you'd want to apply the filter
condition within the CTE.
*/

--Question 3
with seller_item_base as ( --Using the same base CTE for both 3a and 3b
    select items.id as item_id
        , items.name as item_name
        , seller_id
        , sellers.name as seller_name
        , sellers.rating as seller_rating
    from items --no aliasing required
        left join sellers --no aliasing required
            on items.seller_id = sellers.id
    )
, response_3a as ( --
    select item_name --need item name. Show item name first.
        , seller_name --need seller name
    from seller_item_base
    where seller_rating > 4 --seller rating has to be greater than 4. If it were greater or equal, you'd just add an '=' to the filter condition
)
select * from response_3a; --This semicolon breaks the run. When you need the response for 3b, comment this row.

, seller_tally_items as ( --This gets the distinct item count for each seller
    select seller_id
        , seller_name
        , count(distinct item_id) as item_count --finds unique item count
    from seller_item_base
    group by 1,2 --aggregates by seller
)
, response_3b as ( --Given the item counts by seller, we can count the number of sellers with that unique value.
    select item_count as item_count_x --this will be your x axis
        , count(distinct seller_id) as seller_count_y --this will be your y axis
    from seller_tally_items
    group by 1 --aggregate by item counts
    order by 1 asc --don't need to sort, but you'd want it sorted for a histogram
)
select * from response_3b;

/*  Notes on Q3
SQL doesn't actually produce a histogram chart, but it can definitely do all the legwork
to format the data in a way that a chart can easily be produced. You'd simply drop the
results from response_3b into any visualization tool you want to use (e.g. Tableau, Excel,
Google Sheets, etc.)
*/