view: line_number_plan_t {
  label: "Expenses"
  sql_table_name: `ibps.line_number_plan_t` ;;

  dimension: Primary_key {
    type: string
    primary_key: yes
    sql: ${TABLE}.fiscal_year || ${TABLE}.finance_number ;;
  }

  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: finance_number {
    type: string
    sql: ${TABLE}.finance_number ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: fiscal_year_month {
    type: string
    sql: ${TABLE}.fiscal_year_month ;;
  }
  dimension: function_distribution_code {
    type: string
    sql: ${TABLE}.function_distribution_code ;;
  }
  # dimension_group: last_update_date {
  #   type: time
  #   timeframes: [raw, time, date, week, month, quarter, year]
  #   sql: ${TABLE}.last_update_date_time ;;
  # }
  dimension: line_number_code {
    type: string
    sql: ${TABLE}.line_number_code ;;
  }
  dimension: line_number_group_code {
    type: string
    sql: ${TABLE}.line_number_group_code ;;
  }
  # dimension: plan_dollars {
  #   type: number
  #   sql: ${TABLE}.plan_dollars ;;
  # }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: Totalexpense {
    type: sum
    sql: ${TABLE}.plan_dollars ;;
    value_format_name: usd
    ##value_format:"$#,##0"
  }
}
