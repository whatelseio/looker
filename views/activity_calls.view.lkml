view: activity_calls {
  sql_table_name: dbo.ActivityCalls ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Id ;;
  }

  dimension: activity_id {
    type: string
    sql: ${TABLE}.ActivityId ;;
  }

  dimension: call_id {
    type: string
    sql: ${TABLE}.CallId ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.CreatedAt ;;
  }

  dimension: is_deleted {
    type: yesno
    sql: ${TABLE}.Deleted = 'true';;
  }

  dimension: is_edited {
    type: yesno
    sql: ${TABLE}.IsEdited = 'true';;
  }

  dimension: provider_id {
    type: string
    sql: ${TABLE}.ProviderId ;;
  }

  dimension_group: updated_at {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.UpdatedAt ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.Url ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.UserId ;;
  }

  dimension: version {
    type: date_time
    hidden: yes
    sql: ${TABLE}.Version ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

  measure: provider_count {
    type: count_distinct
    sql: ${provider_id} ;;
  }

  measure: user_count {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: call_count {
    type: count_distinct
    sql: ${call_id} ;;
  }
}
