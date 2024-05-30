view: budget_transmittal_letter_t {
  sql_table_name: `ibps.budget_transmittal_letter_t` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension_group: active_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.active_end_date ;;
  }
  dimension_group: active_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.active_start_date ;;
  }
  dimension: area_region_code {
    hidden: yes
    sql: ${TABLE}.area_region_code ;;
  }
  dimension: budget_transmittal_letter_name {
    type: string
    sql: ${TABLE}.budget_transmittal_letter_name ;;
  }
  dimension: budget_transmittal_letter_text {
    type: string
    sql: ${TABLE}.budget_transmittal_letter_text ;;
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
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
    drill_fields: [id, budget_transmittal_letter_name]
  }
}

view: budget_transmittal_letter_t__area_region_code {

  dimension: budget_transmittal_letter_t__area_region_code {
    type: string
    sql: budget_transmittal_letter_t__area_region_code ;;
  }
}
