view: pricing_group_t {
  sql_table_name: `ibps.pricing_group_t` ;;

  dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
  }
  dimension: area_region_name {
    type: string
    sql: ${TABLE}.area_region_name ;;
  }
  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: district_division_code {
    type: string
    sql: ${TABLE}.district_division_code ;;
  }
  dimension: district_division_name {
    type: string
    sql: ${TABLE}.district_division_name ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: function_distribution_code {
    type: string
    sql: ${TABLE}.function_distribution_code ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: pricing_group_name {
    type: string
    sql: ${TABLE}.pricing_group_name ;;
  }
  dimension: pricing_group_number {
    type: string
    sql: ${TABLE}.pricing_group_number ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
    drill_fields: [district_division_name, pricing_group_name, area_region_name]
  }
}
