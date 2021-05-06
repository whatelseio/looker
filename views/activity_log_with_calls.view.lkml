view: activity_log_with_calls {
    derived_table: {
      explore_source: activity_logs {
        column: activity_type_id {}
        column: contact_name {}
        # column: is_active {}
        column: phone_number {}
        column: notes {}
        column: artist_name {}
        column: activity_id { field: activity_calls.activity_id }
        column: call_id { field: activity_calls.call_id }
        column: url { field: activity_calls.url }
        column: updated_at_date { field: activity_calls.updated_at_date }

        # filters: {
        #   field: activity_calls.updated_at_date
        #   value: "45 days"
        # }
      }
      # datagroup_trigger: activity_log_w_calls_datagroup
      # indexes: ["updated_at_date"]
    }
    dimension: activity_type_id {
      label: "Activity Log Activity Type ID"
      type: number
    }
    dimension: artist_name {
      label: "Activity Log Artist Name"
      description: "I made this up to illustrate links on a dimension"
      type: string
      link: {
        label: "Google"
        url: "http://www.google.com/search?q={{ value }}"
        icon_url: "http://google.com/favicon.ico"
      }
    }
    dimension: contact_name {
      label: "Activity Log Contact Name"
    }

    dimension: phone_number {
      label: "Activity Log Phone Number"
    }
    dimension: notes {
      label: "Activity Log Notes"
    }
    dimension: activity_id {}
    dimension: call_id {}
    dimension: url {}
    dimension: updated_at_date {
      description: "Activity Calls Updated Date"
      type: date
    }
  }
