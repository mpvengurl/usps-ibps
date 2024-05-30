view: hq_work_hour_plan_t {
  sql_table_name: `ibps.hq_work_hour_plan_t` ;;

  dimension: finance_nbr {
    type: string
    sql: ${TABLE}.financeNbr ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscalYear ;;
  }
  dimension: fy_total {
    type: string
    sql: ${TABLE}.fyTotal ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastUpdateDateTime ;;
  }
  dimension: ldc {
    type: string
    sql: ${TABLE}.ldc ;;
  }
  dimension: mo01 {
    type: number
    sql: ${TABLE}.mo01 ;;
  }
  dimension: mo02 {
    type: number
    sql: ${TABLE}.mo02 ;;
  }
  dimension: mo03 {
    type: number
    sql: ${TABLE}.mo03 ;;
  }
  dimension: mo04 {
    type: number
    sql: ${TABLE}.mo04 ;;
  }
  dimension: mo05 {
    type: number
    sql: ${TABLE}.mo05 ;;
  }
  dimension: mo06 {
    type: number
    sql: ${TABLE}.mo06 ;;
  }
  dimension: mo07 {
    type: number
    sql: ${TABLE}.mo07 ;;
  }
  dimension: mo08 {
    type: number
    sql: ${TABLE}.mo08 ;;
  }
  dimension: mo09 {
    type: number
    sql: ${TABLE}.mo09 ;;
  }
  dimension: mo10 {
    type: number
    sql: ${TABLE}.mo10 ;;
  }
  dimension: mo11 {
    type: number
    sql: ${TABLE}.mo11 ;;
  }
  dimension: mo12 {
    type: number
    sql: ${TABLE}.mo12 ;;
  }
  measure: count {
    type: count
  }
}
