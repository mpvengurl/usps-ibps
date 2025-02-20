view: d_expenses_salaries {
  sql_table_name: `usps-demo-421820.ibps.d_expenses_salaries` ;;

  dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
  }
  dimension: area_region_name {
    type: string
    sql: ${TABLE}.area_region_name ;;
  }
  dimension: district_division_code {
    type: string
    sql: ${TABLE}.district_division_code ;;
  }
  dimension: district_division_name {
    type: string
    sql: ${TABLE}.district_division_name ;;
  }

  dimension: expensetype {
    type: string
    sql: ${TABLE}.expensetype ;;
  }
  dimension: finance_number {
    type: string
    sql: ${TABLE}.finance_number ;;
  }
  dimension: finance_number_name {
    type: string
    sql: ${TABLE}.finance_number_name ;;
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
  dimension: fpr_line {
    type: string
    sql: ${TABLE}.fpr_line ;;
  }
  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }
  dimension: line_description {
    type: string
    description: "Expense category"
    sql: ${TABLE}.line_description ;;
  }

  dimension: work_load_description {
    type: string
    description: "work_load_type and category"
    sql: ${TABLE}.work_load_description ;;
  }

  measure: work_load_indicators {
    type: sum
    sql: ${TABLE}.wli_total ;;
    drill_fields: [district_division_name, finance_number_name, area_region_name]
  }

  measure: salary_and_benefits {
    description: "salben , salandbennies"
    type: sum
    sql: ${TABLE}.salary_and_benefits/1000  ;;
    value_format: "$#,##0"
    drill_fields: [district_division_name, finance_number_name, area_region_name]
  }

  measure: avg_salary_and_benefits {
    type: average
    sql: ${TABLE}.salary_and_benefits/1000  ;;
    value_format: "$#,##0"
    drill_fields: [district_division_name, finance_number_name, area_region_name]
  }


  measure: non_personnel_expenses {
    description: "Amount spend, expenses"
    type: sum
    sql: ${TABLE}.expenses  ;;
    value_format: "$#,##0"
    drill_fields: [district_division_name, finance_number_name, area_region_name]
  }
 measure : Employee_Award_expenses {
   type: sum
  sql: ${TABLE}.expenses ;;
  filters: [line_description: "Employee Awards"]
  # sql: case when ${line_description}='Employee Awards' then ${TABLE}.expenses  else 0 end ;;
 }

  measure : fuel_expenses {
    type: sum
    sql: ${TABLE}.expenses ;;
    filters: [line_description: "Vehicle Fuel"]
    # sql: case when ${line_description}='Employee Awards' then ${TABLE}.expenses  else 0 end ;;
  }

  measure : package_volume{
  type: sum
  sql: ${TABLE}.wli_total ;;
  filters: [work_load_description: "City Carrier Packages"]
  # sql: case when ${line_description}='Employee Awards' then ${TABLE}.expenses  else 0 end ;;
}

  measure : possible_deliveries_volume{
    type: sum
    sql: ${TABLE}.wli_total ;;
    filters: [work_load_description: "Possible Deliveries"]
    # sql: case when ${line_description}='Employee Awards' then ${TABLE}.expenses  else 0 end ;;
  }

  measure: Ratio_of_salary_and_benefits_to_package_volume {
    type: number
    description: "ratio of salary and benefits to package volume"
    sql: ${salary_and_benefits}/NULLIF(${package_volume},0) ;;
  }
  measure: Ratio_of_salary_and_benefits_to_expenses {
    type: number
    description: "ratio of salary and benefits to expenses"
    sql: ${salary_and_benefits}/NULLIF(${non_personnel_expenses},0) ;;
  }

  measure: Ratio_of_fuel_to_possible_deliveries {
    type: number
    description: "fuel to possible deliveries ratio"
    sql: ${fuel_expenses}/NULLIF(${possible_deliveries_volume},0) ;;
  }
  measure: Ratio_of_fuel_to_package_volume{
    type: number
    description: "fuel to packages ratio"
    sql: ${fuel_expenses}/ NULLIF(${package_volume},0) ;;
  }



  measure: Ratio_of_salary_to_wlis {
    type: number
    sql: ${salary_and_benefits}/NULLIF(${work_load_indicators},0) ;;
  }
  measure: total {
    type: sum
    sql: ${TABLE}.wli_total+(${TABLE}.salary_and_benefits/1000)+ ${TABLE}.expenses;;
    value_format: "$#,##0"
  }
}
