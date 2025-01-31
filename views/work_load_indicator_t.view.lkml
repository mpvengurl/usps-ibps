view: work_load_indicator_t {
  sql_table_name: `ibps.work_load_indicator` ;;

  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }

  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
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
  dimension: work_load_indicator_code {
    type: string
    sql: ${TABLE}.work_load_indicator_code ;;
  }
  dimension: work_load_indicator_name {
    type: string
    sql: ${TABLE}.work_load_indicator_name ;;
  }
  measure: count {
    type: count
    drill_fields: [work_load_indicator_name]
  }
}
