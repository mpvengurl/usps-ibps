view: pricing_plan_t {
  sql_table_name: `ibps.pricing_plan_t` ;;

  dimension: accounting_period {
    type: string
    sql: ${TABLE}.accounting_period ;;
  }
  dimension: base_hours {
    type: number
    sql: ${TABLE}.base_hours ;;
  }
  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: employee_category_code {
    type: string
    sql: ${TABLE}.employee_category_code ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }
  dimension: hour_type_code {
    type: string
    sql: ${TABLE}.hour_type_code ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: plan_hours {
    type: number
    sql: ${TABLE}.plan_hours ;;
  }
  dimension: plan_pricing_dollars {
    type: number
    sql: ${TABLE}.plan_pricing_dollars ;;
  }
  dimension: pricing_group_number {
    type: string
    sql: ${TABLE}.pricing_group_number ;;
  }
  dimension: pricing_mix_percentage {
    type: number
    sql: ${TABLE}.pricing_mix_percentage ;;
  }
  dimension: pricing_rate {
    type: number
    sql: ${TABLE}.pricing_rate ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
  }
}
