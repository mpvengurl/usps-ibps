view: derived_salaries_benefits {
  sql_table_name: `usps-demo-421820.ibps.derived_salaries_benefits` ;;


dimension: Primary_key {
  type: string
  primary_key: yes
  sql: ${TABLE}.fiscal_year ||${TABLE}.fiscal_year_month|| ${TABLE}.finance_number ||${TABLE}.function_code ;;
}

dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension: district_division_code {
    type: string
    sql: ${TABLE}.district_division_code ;;
  }
  dimension: finance_number {
    type: string
    sql: ${TABLE}.finance_number ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: fiscal_year_month {
    type: string
    sql: ${TABLE}.fiscal_year_month ;;
  }
  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }
  dimension: function_distribution_code {
    type: string
    sql: ${TABLE}.function_distribution_code ;;
  }
  dimension: line {
    type: string
    sql: ${TABLE}.line ;;
  }
  dimension: pricing_group_number {
    type: string
    sql: ${TABLE}.pricing_group_number ;;
  }

  measure: Salary_benefit_expense {
    type: sum
    sql: ${TABLE}.ttl ;;
    value_format_name: usd
  }
}
