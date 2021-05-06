view: period_over_period {

  ### Create a calendar table or use a view to build a date field for the view ###

  derived_table: {
    sql:  select a.full_date
          from (
              select dateadd(day, -1 * (a.a + (10 * b.a) + (100 * c.a) + (1000 * d.a) ), cast('2025-12-31' as datetime)) as full_date
              from (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union            all select 8 union all select 9) as a
              cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7            union all select 8 union all select 9) as b
              cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7            union all select 8 union all select 9) as c
              cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7            union all select 8 union all select 9) as d
          ) a
          where a.full_date between '2017-01-01' and '2025-12-31'
          ;;
    }

##### Period over Period Comparison {

### POP Analysis
    parameter: pop_comparison{
      label: "Period over Period Comparison"
      type: string
      allowed_value: { value: "Previous Week" }
      allowed_value: { value: "Previous Month" }
      allowed_value: { value: "Previous Quarter" }
      allowed_value: { value: "Previous Year" }
      allowed_value: { value: "Previous Period" }
    }

    filter: current_period_filter {
      type: date
      description: "Use this filter to define the current and previous period for analysis"
      sql: ${period} IS NOT NULL ;;
      convert_tz: no
    }


# ### This code is for Snowflake and Athena depending on the database dialect

    dimension: period {
      type: string
      description: "The reporting period as selected by the This Period Filter"
      sql:  CASE
              WHEN {% date_start current_period_filter %} is not null
                AND {% date_end current_period_filter %} is not null /* date ranges or in the past x days */
                AND {% parameter pop_comparison %} = 'Previous Period'
                THEN
                  CASE
                    WHEN ${full_date_raw} >= {% date_start current_period_filter %}
                      AND ${full_date_raw} < {% date_end current_period_filter %}
                      THEN concat('Current [ ', cast({% date_start current_period_filter %} as date), ' to ', cast(dateadd(day, -1,{% date_end
                          current_period_filter %}) as date), ' ]')
                    WHEN ${full_date_raw} >= dateadd(day, (-1 * (datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %} ))),{% date_start current_period_filter %})
                      AND ${full_date_raw} < {% date_start current_period_filter %}
                      THEN concat('Previous [ ', cast( dateadd(day, (-1 * (datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %}))),{% date_start current_period_filter %}) as date),
                            ' to ', cast(dateadd(day, -1,{% date_start current_period_filter %}) as date), ' ]')
                  END
              WHEN {% date_start current_period_filter %} is not null
                AND {% date_end current_period_filter %} is not null /* date ranges or in the past x days */
                AND {% parameter pop_comparison %} = 'Previous Week' /* date ranges or in the past x days */
              THEN
                CASE
                  WHEN ${full_date_raw} >=  {% date_start current_period_filter %}
                    AND ${full_date_raw} < {% date_end current_period_filter %}
                    THEN concat('Current [ ', cast({% date_start current_period_filter %} as date), ' to ', cast(dateadd(day, -1,{% date_end
                      current_period_filter %}) as date), ' ]')
                  WHEN ${full_date_raw} >= dateadd(week, -1,{% date_start current_period_filter %})
                    AND ${full_date_raw} < dateadd(day,datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %}),dateadd(week,-1,{% date_start current_period_filter %}))
                    THEN concat('Previous [ ', cast(dateadd(week, -1,{% date_start current_period_filter %}) as date), ' to ',
                       cast(dateadd(day,datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %}),dateadd(day,-1,dateadd(week,-1,{% date_start current_period_filter %}))) as date),
                       ' ]')
                END
              WHEN {% date_start current_period_filter %} is not null
                AND {% date_end current_period_filter %} is not null /* date ranges or in the past x days */
                AND {% parameter pop_comparison %} = 'Previous Month' /* date ranges or in the past x days */
              THEN
                CASE
                  WHEN ${full_date_raw} >=  {% date_start current_period_filter %}
                    AND ${full_date_raw} < {% date_end current_period_filter %}
                    THEN concat('Current [ ', cast({% date_start current_period_filter %} as date), ' to ', cast(dateadd(day, -1,{% date_end current_period_filter %}) as date), ' ]')
                  WHEN ${full_date_raw} >= dateadd(month, -1,{% date_start current_period_filter %})
                    AND ${full_date_raw} < dateadd(day,datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %}),dateadd(month,-1,{% date_start current_period_filter %}))
                    THEN concat('Previous [ ', cast(dateadd(month, -1,{% date_start current_period_filter %}) as date), ' to ',
                       cast(dateadd(day,datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %}),dateadd(day,-1,dateadd(month,-1,{% date_start current_period_filter %}))) as date),
                       ' ]')
                END
            WHEN {% date_start current_period_filter %} is not null
                AND {% date_end current_period_filter %} is not null /* date ranges or in the past x days */
                AND {% parameter pop_comparison %} = 'Previous Quarter' /* date ranges or in the past x days */
              THEN
                CASE
                  WHEN ${full_date_raw} >=  {% date_start current_period_filter %}
                    AND ${full_date_raw} < {% date_end current_period_filter %}
                    THEN concat('Current [ ', cast({% date_start current_period_filter %} as date), ' to ', cast(dateadd(day, -1,{% date_end current_period_filter %}) as date), ' ]')
                  WHEN ${full_date_raw} >= dateadd(quarter, -1,{% date_start current_period_filter %})
                    AND ${full_date_raw} < dateadd(day,datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %}),dateadd(quarter,-1,{% date_start current_period_filter %}))
                    THEN concat('Previous [ ', cast(dateadd(quarter, -1,{% date_start current_period_filter %}) as date), ' to ',
                       cast(dateadd(day,datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %}),dateadd(day,-1,dateadd(quarter,-1,{% date_start current_period_filter %}))) as date),
                       ' ]')
                END
              WHEN {% date_start current_period_filter %} is not null
                AND {% date_end current_period_filter %} is not null /* date ranges or in the past x days */
                AND {% parameter pop_comparison %} = 'Previous Year' /* date ranges or in the past x days */
              THEN
                CASE
                  WHEN ${full_date_raw} >=  {% date_start current_period_filter %}
                    AND ${full_date_raw} < {% date_end current_period_filter %}
                    THEN concat('Current [ ', cast({% date_start current_period_filter %} as date), ' to ', cast(dateadd(day, -1,{% date_end current_period_filter %}) as date), ' ]')
                  WHEN ${full_date_raw} >= dateadd(year, -1,{% date_start current_period_filter %})
                    AND ${full_date_raw} < dateadd(day,datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %}),dateadd(year,-1,{% date_start current_period_filter %}))
                    THEN concat('Previous [ ', cast(dateadd(year, -1,{% date_start current_period_filter %}) as date), ' to ',
                       cast(dateadd(day,datediff(day, {% date_start current_period_filter %},{% date_end current_period_filter %}),dateadd(day,-1,dateadd(year,-1,{% date_start current_period_filter %}))) as date),
                       ' ]')
                END
              END
              ;;
    }

    dimension_group: full_date {
      type: time
      timeframes: [raw, date, day_of_week, day_of_week_index, day_of_month, day_of_year, week, week_of_year]
      convert_tz: no
    }

  }
