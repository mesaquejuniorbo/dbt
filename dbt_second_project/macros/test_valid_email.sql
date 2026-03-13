{% test valid_email(model, column_name) %}

    select {{ column_name }}
    from {{ model }}
    where {{ column_name }} is not null
      and {{ column_name }} not like '%_@_%.__%'

{% endtest %}
