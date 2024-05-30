view: hq_line_number_plan_t {
  sql_table_name: `ibps.hq_line_number_plan_t` ;;

  dimension: exp_amt {
    type: number
    sql: ${TABLE}.expAmt ;;
  }
  dimension: finance_nbr {
    type: string
    sql: ${TABLE}.financeNbr ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscalYear ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastUpdateDateTime ;;
  }
  dimension: line_nbr {
    type: string
    sql: ${TABLE}.lineNbr ;;
  }
  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }
  measure: count {
    type: count
  }
}
