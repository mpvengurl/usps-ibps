view: hq_revenue_plan_t {
  sql_table_name: `ibps.hq_revenue_plan_t` ;;

  dimension: cap_amt {
    type: number
    sql: ${TABLE}.capAmt ;;
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
  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }
  dimension: sub_line_code {
    type: string
    sql: ${TABLE}.subLineCode ;;
  }
  measure: count {
    type: count
  }
}
