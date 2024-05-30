view: revenue_sub_line_number_t {
  sql_table_name: `ibps.revenue_sub_line_number_t` ;;

  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: is_negative_allowed {
    type: yesno
    sql: ${TABLE}.is_negative_allowed ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: revenue_group_code {
    type: string
    sql: ${TABLE}.revenue_group_code ;;
  }
  dimension: revenue_sub_line_number_code {
    type: string
    sql: ${TABLE}.revenue_sub_line_number_code ;;
  }
  dimension: revenue_sub_line_number_name {
    type: string
    sql: ${TABLE}.revenue_sub_line_number_name ;;
  }
  dimension: switch_1 {
    type: yesno
    sql: ${TABLE}.switch_1 ;;
  }
  dimension: switch_2 {
    type: yesno
    sql: ${TABLE}.switch_2 ;;
  }
  dimension: switch_3 {
    type: yesno
    sql: ${TABLE}.switch_3 ;;
  }
  dimension: switch_4 {
    type: yesno
    sql: ${TABLE}.switch_4 ;;
  }
  dimension: switch_5 {
    type: yesno
    sql: ${TABLE}.switch_5 ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
    drill_fields: [revenue_sub_line_number_name]
  }
}
