connection: "lookerdb"

# include all the views
include: "/views/**/*.view"

datagroup: metrics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: metrics_default_datagroup

explore: activity_logs {}
