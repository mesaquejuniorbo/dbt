{% test valid_email(model, column_name) %}

    with validation as (
    select {{ column_name }} as email
    from {{ model }}
    where {{ column_name }} is not null
      and {{ column_name }} not like '%_@_%.__%'
    )

    select *
    from validation

{% endtest %}
