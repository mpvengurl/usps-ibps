view: spread_work_load_indicator_plan_top_ten_t {
  sql_table_name: `ibps.spread_work_load_indicator_plan_top_ten_t` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: ranking {
    type: number
    sql: ${TABLE}.ranking ;;
  }
  dimension: spread_name {
    type: string
    sql: ${TABLE}.spread_name ;;
  }
  dimension: top_ten_record_owner {
    type: string
    sql: ${TABLE}.top_ten_record_owner ;;
  }
  measure: count {
    type: count
    drill_fields: [id, spread_name]
  }
}
