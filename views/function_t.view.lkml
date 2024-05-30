view: function_t {
  sql_table_name: `ibps.function_t` ;;

  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }
  dimension: function_name {
    type: string
    sql: ${TABLE}.function_name ;;
  }
  measure: count {
    type: count
    drill_fields: [function_name]
  }
}
