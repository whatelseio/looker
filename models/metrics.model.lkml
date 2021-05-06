connection: "lookerdb"

# include all the views
include: "/views/**/*.view"

datagroup: metrics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "8 hour"
}

datagroup: activity_log_w_calls_datagroup {
  sql_trigger: SELECT MAX(updated_at_date) FROM activity_log_with_calls;;
  max_cache_age: "4 hour"
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

explore: activity_log_with_calls {
  persist_with: activity_log_w_calls_datagroup
}

explore: period_over_period {}
