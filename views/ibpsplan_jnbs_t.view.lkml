view: ibpsplan_jnbs_t {
  sql_table_name: `ibps.ibpsplan_jnbs_t` ;;

  dimension: acct {
    type: string
    sql: ${TABLE}.ACCT ;;
  }
  dimension: amr_ldc {
    type: string
    sql: ${TABLE}.AMR_LDC ;;
  }
  dimension: commas {
    type: string
    sql: ${TABLE}.commas ;;
  }
  dimension: empty1 {
    type: string
    sql: ${TABLE}.empty1 ;;
  }
  dimension: finance_number {
    type: string
    sql: ${TABLE}.finance_number ;;
  }
  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }
  dimension: jvnumb {
    type: string
    sql: ${TABLE}.JVNUMB ;;
  }
  dimension: period {
    type: string
    sql: ${TABLE}.period ;;
  }
  dimension: plan_hours1 {
    type: string
    sql: ${TABLE}.plan_hours1 ;;
  }
  dimension: plan_hours2 {
    type: string
    sql: ${TABLE}.plan_hours2 ;;
  }
  dimension: seg5 {
    type: string
    sql: ${TABLE}.SEG5 ;;
  }
  dimension: seg6 {
    type: string
    sql: ${TABLE}.SEG6 ;;
  }
  dimension: stamp_date {
    type: string
    sql: ${TABLE}.stamp_date ;;
  }
  dimension: subacct {
    type: string
    sql: ${TABLE}.SUBACCT ;;
  }
  dimension: ws_bg {
    type: string
    sql: ${TABLE}.WS_BG ;;
  }
  measure: count {
    type: count
  }
}
