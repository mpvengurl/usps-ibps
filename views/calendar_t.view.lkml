view: calendar_t {
  sql_table_name: `ibps.calendar_t` ;;

  dimension: accounting_period {
    type: string
    sql: ${TABLE}.accounting_period ;;
  }
  dimension: budget_week {
    type: string
    sql: ${TABLE}.budget_week ;;
  }
  dimension_group: calendar_day {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.calendar_day ;;
  }
  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: fiscal_year_month {
    type: string
    sql: ${TABLE}.fiscal_year_month ;;
  }
  dimension: fiscal_year_quarter {
    type: number
    sql: ${TABLE}.fiscal_year_quarter ;;
  }
  dimension: is_delivery_day {
    type: yesno
    sql: ${TABLE}.is_delivery_day ;;
  }
  dimension: is_holiday {
    type: yesno
    sql: ${TABLE}.is_holiday ;;
  }
  dimension: is_pot_exclusion {
    type: yesno
    sql: ${TABLE}.is_pot_exclusion ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: pay_period {
    type: number
    sql: ${TABLE}.pay_period ;;
  }
  dimension: pay_period_week {
    type: number
    sql: ${TABLE}.pay_period_week ;;
  }
  dimension: split_week_number {
    type: string
    sql: ${TABLE}.split_week_number ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }

  dimension: unique_per_splitweek {
    type: number
    sql: dense_rank()over(partition by fiscal_year,fiscal_year_month,split_week_number,budget_week,accounting_period order by fiscal_year,split_week_number desc) ;;
  }
  measure: count {
    type: count
  }



  # measure: first_day_split_Week {
  #   type: min
  #   sql:  ;;

}
