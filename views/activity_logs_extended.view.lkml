include: "/views/activity_logs.view"
view: activity_logs_extended {
  extends: [activity_logs]

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
    type: yesno
    sql: ${TABLE}.BoolFour = 'true';;
  }

  dimension: bool_one {
    type: yesno
    sql: ${TABLE}.BoolOne = 'true';;
  }

  dimension: bool_three {
    type: yesno
    sql: ${TABLE}.BoolThree = 'true';;
  }

  dimension: bool_two {
    type: yesno
    sql: ${TABLE}.BoolTwo = 'true';;
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

  dimension: is_deleted {
    type: yesno
    sql: ${TABLE}.Deleted = 'true' ;;
  }

  dimension: is_active {
    type: yesno
    sql: ${TABLE}.IsActive = 'true' ;;
  }

  dimension: is_contact {
    type: yesno
    sql: ${TABLE}.IsContact = 'true' ;;
  }

  dimension: is_current_call {
    type: yesno
    sql: ${TABLE}.IsCurrentCall = 'true' ;;
  }

  dimension: is_identified {
    type: yesno
    sql: ${TABLE}.IsIdentified = 'true' ;;
  }

  dimension: is_incoming {
    type: yesno
    sql: ${TABLE}.IsIncoming = 'true' ;;
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
    sql: CONVERT(DATETIME, ${TABLE}.Version, 120) ;;  # ${TABLE}.Version
  }

  dimension: artist_name {
    description: "Added this to illustrate linking to a URL"
    type: string
    sql:  case substring(${phone_number},1,1)
            when '0' then 'Madonna'
            when '1' then 'Enya'
            when '2' then 'Sting'
            when '3' then 'Yanni'
            when '4' then 'Ronaldo'
            when '5' then 'The Weekend'
            when '6' then 'Jennifer Nettles'
            when '7' then 'Popeye'
            when '8' then 'Batman'
            when '9' then 'The Hulk'
            else 'Jack Benny'
          end
            ;;
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
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
