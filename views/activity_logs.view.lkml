view: activity_logs {
  sql_table_name: dbo.ActivityLogs ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: no
    type: string
    sql: ${TABLE}.Id ;;
  }

  dimension: activity_type_id {
    type: number
    sql: ${TABLE}.ActivityTypeId ;;
  }

  dimension: bool_four {
    type: string
    sql: ${TABLE}.BoolFour ;;
  }

  dimension: bool_one {
    type: string
    sql: ${TABLE}.BoolOne ;;
  }

  dimension: bool_three {
    type: string
    sql: ${TABLE}.BoolThree ;;
  }

  dimension: bool_two {
    type: string
    sql: ${TABLE}.BoolTwo ;;
  }

  dimension_group: call_end_time {
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
    sql: ${TABLE}.CallEndTime ;;
  }

  dimension: call_id {
    type: string
    sql: ${TABLE}.CallId ;;
  }

  dimension_group: call_start_time {
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
    sql: ${TABLE}.CallStartTime ;;
  }

  dimension: contact_id {
    type: string
    sql: ${TABLE}.ContactId ;;
  }

  dimension: contact_name {
    type: string
    sql: ${TABLE}.ContactName ;;
  }

  dimension: conversation_id {
    type: string
    sql: ${TABLE}.ConversationId ;;
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

  dimension: deleted {
    type: string
    sql: ${TABLE}.Deleted ;;
  }

  dimension: is_active {
    type: string
    sql: ${TABLE}.IsActive ;;
  }

  dimension: is_contact {
    type: string
    sql: ${TABLE}.IsContact ;;
  }

  dimension: is_current_call {
    type: string
    sql: ${TABLE}.IsCurrentCall ;;
  }

  dimension: is_identified {
    type: string
    sql: ${TABLE}.IsIdentified ;;
  }

  dimension: is_incoming {
    type: string
    sql: ${TABLE}.IsIncoming ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.Notes ;;
  }

  dimension: phone_number {
    type: string
    sql: ${TABLE}.PhoneNumber ;;
  }

  dimension: string_four {
    type: string
    sql: ${TABLE}.StringFour ;;
  }

  dimension: string_one {
    type: string
    sql: ${TABLE}.StringOne ;;
  }

  dimension: string_three {
    type: string
    sql: ${TABLE}.StringThree ;;
  }

  dimension: string_two {
    type: string
    sql: ${TABLE}.StringTwo ;;
  }

  dimension: transcription {
    type: string
    sql: ${TABLE}.Transcription ;;
  }

  dimension: transcription_data {
    type: string
    sql: ${TABLE}.TranscriptionData ;;
  }

  dimension: transcription_source {
    type: number
    sql: ${TABLE}.TranscriptionSource ;;
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

  dimension: user_id {
    type: string
    sql: ${TABLE}.UserId ;;
  }

  dimension: version {
    type: date_time
    sql: ${TABLE}.Version ;;
  }

  measure: count {
    type: count
    drill_fields: [id, contact_name]
  }

  measure: user_count {
    type: count_distinct
    sql:  ${user_id} ;;
  }

  measure: activity_type_count {
    type: count_distinct
    sql: ${activity_type_id} ;;
  }

}
