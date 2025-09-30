view: d_expenses_salaries {
  sql_table_name: `usps-demo-421820.ibps.d_expenses_salaries` ;;

  dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
  }
  dimension: area_region_name {
    type: string
    sql: coalesce(${TABLE}.area_region_name, "Unassigned");;
    link: {
      label: "View BOPR Report for this Area"
      url: "https://d356d95d-1e8c-4f43-87c7-a2557d78f26d.looker.app/dashboards/Axwmlhr55iqVLLrv7ZvJW2?Area+Region+Name={{ value }} "
    }

    ##else ${TABLE}.area_region_name end ;;

  }
  dimension: district_division_code {
    type: string
    sql: ${TABLE}.district_division_code ;;
  }
  dimension: district_division_name {
    type: string
    sql: coalesce(${TABLE}.district_division_name, "Unassigned") ;;
    link: {
      label: "View BOPR Report for this Division"
      url: "https://d356d95d-1e8c-4f43-87c7-a2557d78f26d.looker.app/dashboards/Axwmlhr55iqVLLrv7ZvJW2?District+Division+Name={{ value }} "
    }
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
    link: {
    label: "View BOPR Report for this Finance Number"
    url: "https://d356d95d-1e8c-4f43-87c7-a2557d78f26d.looker.app/dashboards/Axwmlhr55iqVLLrv7ZvJW2?Finance+Number+Name={{ value }} "
  }
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
    drill_fields: [area_region_name,district_division_name, finance_number_name,salary_and_benefits]
  }

  measure: avg_salary_and_benefits {
    type: average
    sql: ${TABLE}.salary_and_benefits/1000  ;;
    value_format: "$#,##0"
    drill_fields: [area_region_name,district_division_name, finance_number_name,avg_salary_and_benefits]
  }


  measure: non_personnel_expenses {
    description: "Amount spend, expenses"
    type: sum
    sql: ${TABLE}.expenses  ;;
    value_format: "$#,##0"
    drill_fields: [ area_region_name,district_division_name, finance_number_name,non_personnel_expenses]
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

  #: package_volume_ratio {
   # type: number
   # label: "Package Volume Ratio (%)"
   #default_value: "0"
  #}

  #derived_table: {
    #sql: SELECT
           # expensetype,
           # fiscal_year,
           # area_region_name,
           # district_division_name,
           # expenses * (1 + {{package_volume_ratio}} / 100) AS #adjusted_expense,
           # finance_number_name  -- Assuming this column exists
          #FROM
           # d_expenses_salaries ;;
  #}

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
