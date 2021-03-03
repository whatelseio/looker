connection: "lookerdb"

# include all the views
include: "/views/**/*.view"

datagroup: metrics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: metrics_default_datagroup

explore: activity_logs {
  label: "Activity Log"
  # group_label: "Activity Log"
  view_label: "Activity Log"

  join: activity_calls {
    type: left_outer
    sql_on: ${activity_logs.user_id} = ${activity_calls.user_id}  ;;
    relationship: many_to_many
    }
}

explore: activity_calls {}
