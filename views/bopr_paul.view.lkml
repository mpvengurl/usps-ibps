
view: bopr_paul {
  derived_table: {
    sql:


    WITH cal AS (
    SELECT
        fiscal_year,
        budget_week,
        split_week_number,
        accounting_period,
        fiscal_year_quarter,
        fiscal_year_month
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY calendar_day ORDER BY last_update_date_time DESC) AS row_num
        FROM `ibps.calendar_t`
    ) t0
    WHERE row_num = 1
    GROUP BY 1, 2, 3, 4, 5, 6
),
work_hour_first AS (
    SELECT
        whp.fiscal_year,
        whp.finance_number,
        whp.function_code,
        whp.labor_distribution_code,
        whp.split_week_number,
        ld.hour_type_code,
        whp.plan_hours
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY fiscal_year, finance_number, function_code, labor_distribution_code, split_week_number ORDER BY last_update_date_time DESC) AS row_num
        FROM `ibps.work_hour_plan_t`
    ) whp
    INNER JOIN (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY fiscal_year, function_code, labor_distribution_code ORDER BY last_update_date_time_x DESC) AS row_num
        FROM `ibps.labor_distribution_t`
    ) ld ON whp.fiscal_year = ld.fiscal_year
    AND whp.function_code = ld.function_code
    AND whp.labor_distribution_code = ld.labor_distribution_code
    WHERE whp.row_num = 1
),
hour_group AS (
    SELECT
        fn.pricing_group_number,
        fn.area_region_code,
        LPAD(fn.function_distribution_code, 3, '0') AS function_distribution_code,
        fn.district_division_code,
        whs.*,
        CASE
            WHEN labor_distribution_code IN ('02/0200', '03/0300', '04/0400', '05/0500', '06/0600', '07/0700', '08/0800', '09/0900', '90/9000') THEN '10'
            WHEN labor_distribution_code IN ('10/1000', '11/1100', '12/1200', '13/1300', '14/1400', '15/1500', '16/1600', '17/1700', '18/1800', '19/1900', '91/9100') THEN '11'
            WHEN labor_distribution_code IN ('25/2500') THEN '12'
            WHEN labor_distribution_code IN ('30/3000', '31/3100', '32/3200', '33/13300', '34/3400') THEN '13'
            WHEN labor_distribution_code IN ('40/4000', '41/4100', '42/4200', '43/4300', '44/4400', '45/4500', '46/4600', '47/4700', '48/4800', '49/4900', '94/9400') THEN '14'
            WHEN labor_distribution_code IN ('50/5000', '51/5100', '52/5200', '53/5300', '54/5400', '55/5500', '56/5600', '57/5700', '58/5800', '59/5900', '95/9500') THEN '15'
            WHEN labor_distribution_code IN ('61/6100', '62/6200', '63/6300', '64/6400', '65/6500', '66/6600', '67/6700', '96/9600') THEN '16'
            WHEN labor_distribution_code IN ('70/7000', '71/7100', '72/7200', '73/7300', '74/7400', '75/7500', '76/7600', '77/7700', '78/7800', '79/7900', '97/9700') THEN '17'
            WHEN labor_distribution_code IN ('80/8000', '81/8100', '82/8200', '83/8300', '84/8400', '85/8500', '86/8600', '87/8700', '88/8800', '89/8900', '98/9800') THEN '18'
            WHEN labor_distribution_code IN ('68/6800') THEN '20'
            WHEN labor_distribution_code IN ('69/6900') THEN '21'
            WHEN labor_distribution_code IN ('20/2000', '21/2100', '22/2200', '23/2300', '24/2400', '25/2500', '26/2600', '27/2700', '27/2710', '28/2800', '29/2900', '29/2910', '92/9200') THEN '22'
            WHEN labor_distribution_code IN ('35/3500', '36/3600', '37/3700', '38/3800', '39/3900', '93/9310') THEN '23'
        END AS line,
        'WORK HOURS' AS description
    FROM work_hour_first whs
    INNER JOIN (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY fiscal_year, finance_number ORDER BY last_update_date_time DESC) AS row_num
        FROM `ibps.finance_number_t`
    ) fn ON fn.finance_number = whs.finance_number
    AND fn.fiscal_year = whs.fiscal_year
    WHERE fn.row_num = 1
),
hq_work_hour_plan AS (
    SELECT DISTINCT
        fiscalYear AS fiscal_year,
        financeNbr AS finance_number,
        ldc AS labor_distribution_code,
        fiscal_year_month , mo01, mo02, mo03, mo04, mo05, mo06, mo07, mo08, mo09, mo10, mo11, mo12, CAST(fyTotal AS INTEGER) AS fyTtl
    FROM `ibps.hq_work_hour_plan_t`
    INNER JOIN cal c ON fiscal_year = c.fiscal_year

),
hour_agg AS (
    SELECT
        hg.fiscal_year,
        pricing_group_number,
        finance_number,
        area_region_code,
        function_distribution_code,
        district_division_code,
        function_code,
        line,
        description,
        CASE
            WHEN fiscal_year_month = '1' THEN 'Mo.01 OCT'
            WHEN fiscal_year_month = '2' THEN 'Mo.02 NOV'
            WHEN fiscal_year_month = '3' THEN 'Mo.03 DEC'
            WHEN fiscal_year_month = '4' THEN 'Mo.04 JAN'
            WHEN fiscal_year_month = '5' THEN 'Mo.05 FEB'
            WHEN fiscal_year_month = '6' THEN 'Mo.06 MAR'
            WHEN fiscal_year_month = '7' THEN 'Mo.07 APR'
            WHEN fiscal_year_month = '8' THEN 'Mo.08 MAY'
            WHEN fiscal_year_month = '9' THEN 'Mo.09 JUN'
            WHEN fiscal_year_month = '10' THEN 'Mo.10 JUL'
            WHEN fiscal_year_month = '11' THEN 'Mo.11 AUG'
            WHEN fiscal_year_month = '12' THEN 'Mo.12 SEP'
        END AS fiscal_year_month,
        SUM(plan_hours) AS ttl
    FROM hour_group hg
    INNER JOIN cal ON cal.fiscal_year = SUBSTRING(hg.pricing_group_number, 1, 4)
    AND cal.split_week_number = hg.split_week_number
    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    UNION DISTINCT
    SELECT
        hwhp.fiscal_year,
        fn.pricing_group_number,
        hwhp.finance_number,
        fn.area_region_code,
        fn.function_distribution_code,
        fn.district_division_code,
        ld.function_code,
        '24' AS line,
        'WORK HOURS' AS description,
        CASE
            WHEN fiscal_year_month = '1' THEN 'Mo.01 OCT'
            WHEN fiscal_year_month = '2' THEN 'Mo.02 NOV'
            WHEN fiscal_year_month = '3' THEN 'Mo.03 DEC'
            WHEN fiscal_year_month = '4' THEN 'Mo.04 JAN'
            WHEN fiscal_year_month = '5' THEN 'Mo.05 FEB'
            WHEN fiscal_year_month = '6' THEN 'Mo.06 MAR'
            WHEN fiscal_year_month = '7' THEN 'Mo.07 APR'
            WHEN fiscal_year_month = '8' THEN 'Mo.08 MAY'
            WHEN fiscal_year_month = '9' THEN 'Mo.09 JUN'
            WHEN fiscal_year_month = '10' THEN 'Mo.10 JUL'
            WHEN fiscal_year_month = '11' THEN 'Mo.11 AUG'
            WHEN fiscal_year_month = '12' THEN 'Mo.12 SEP'
        END AS fiscal_year_month,
        CASE
            WHEN fiscal_year_month = '1' THEN mo01
            WHEN fiscal_year_month = '2' THEN mo02
            WHEN fiscal_year_month = '3' THEN mo03
            WHEN fiscal_year_month = '4' THEN mo04
            WHEN fiscal_year_month = '5' THEN mo05
            WHEN fiscal_year_month = '6' THEN mo06
            WHEN fiscal_year_month = '7' THEN mo07
            WHEN fiscal_year_month = '8' THEN mo08
            WHEN fiscal_year_month = '9' THEN mo09
            WHEN fiscal_year_month = '10' THEN mo10
            WHEN fiscal_year_month = '11' THEN mo11
            WHEN fiscal_year_month = '12' THEN mo12
        END AS ttl
    FROM hq_work_hour_plan hwhp
    LEFT JOIN `ibps.finance_number_t` fn ON fn.finance_number = hwhp.finance_number AND fn.fiscal_year = hwhp.fiscal_year
    LEFT JOIN `ibps.labor_distribution_t` ld ON ld.labor_distribution_code = hwhp.labor_distribution_code AND ld.fiscal_year = hwhp.fiscal_year
),
composite_rate AS (
    SELECT
        function_code,
        pricing_group_number,
        CASE
            WHEN accounting_period = '1' THEN 'Mo.01 OCT'
            WHEN accounting_period = '2' THEN 'Mo.02 NOV'
            WHEN accounting_period = '3' THEN 'Mo.02 NOV'
            WHEN accounting_period = '4' THEN 'Mo.03 DEC'
            WHEN accounting_period = '5' THEN 'Mo.03 DEC'
            WHEN accounting_period = '6' THEN 'Mo.04 JAN'
            WHEN accounting_period = '7' THEN 'Mo.05 FEB'
            WHEN accounting_period = '8' THEN 'Mo.06 MAR'
            WHEN accounting_period = '9' THEN 'Mo.07 APR'
            WHEN accounting_period = '10' THEN 'Mo.08 MAY'
            WHEN accounting_period = '11' THEN 'Mo.09 JUN'
            WHEN accounting_period = '12' THEN 'Mo.10 JUL'
            WHEN accounting_period = '13' THEN 'Mo.11 AUG'
            WHEN accounting_period = '14' THEN 'Mo.12 SEP'
        END AS accounting_period_month
        , pp.accounting_period
        , AVG(pricing_rate) AS composite_rate
    FROM `ibps.pricing_plan_t` pp
    GROUP BY 1, 2, 3, 4
),
function_dollars AS (
    SELECT
        hour_agg.fiscal_year,
        hour_agg.pricing_group_number,
        hour_agg.finance_number,
        hour_agg.area_region_code,
        hour_agg.function_distribution_code,
        hour_agg.district_division_code,
        hour_agg.function_code,
        hour_agg.line,
        'DOLLARS' AS description,
        hour_agg.fiscal_year_month,
        hour_agg.ttl * cr.composite_rate AS ttl
    FROM hour_agg
    LEFT JOIN composite_rate cr ON hour_agg.function_code = cr.function_code
    AND hour_agg.pricing_group_number = cr.pricing_group_number
    AND hour_agg.fiscal_year_month = cr.accounting_period_month
    WHERE line IS NOT NULL
    AND composite_rate IS NOT NULL
),
totalSalariesAndBennies AS (
    SELECT
        hour_agg.fiscal_year,
        hour_agg.pricing_group_number,
        hour_agg.finance_number,
        hour_agg.area_region_code,
        hour_agg.function_distribution_code,
        hour_agg.district_division_code,
        hour_agg.function_code,
        '24' AS line,
        'TOTAL DOLLARS' AS description,
        hour_agg.fiscal_year_month,
        hour_agg.ttl * cr.composite_rate AS ttl
    FROM hour_agg
    LEFT JOIN composite_rate cr ON hour_agg.function_code = cr.function_code
    AND hour_agg.pricing_group_number = cr.pricing_group_number
    AND hour_agg.fiscal_year_month = cr.accounting_period_month
),
totalHours AS (
    SELECT
        hour_agg.fiscal_year,
        hour_agg.pricing_group_number,
        hour_agg.finance_number,
        hour_agg.area_region_code,
        hour_agg.function_distribution_code,
        hour_agg.district_division_code,
        hour_agg.function_code,
        '25' AS line,
        'TOTAL WORK HOURS' AS description,
        hour_agg.fiscal_year_month,
        hour_agg.ttl AS ttl
    FROM hour_agg
    LEFT JOIN composite_rate cr ON hour_agg.function_code = cr.function_code
    AND hour_agg.pricing_group_number = cr.pricing_group_number
    AND hour_agg.fiscal_year_month = cr.accounting_period_month
),
workHourRate AS (
    SELECT
        hour_agg.fiscal_year,
        hour_agg.pricing_group_number,
        hour_agg.finance_number,
        hour_agg.area_region_code,
        hour_agg.function_distribution_code,
        hour_agg.district_division_code,
        hour_agg.function_code,
        '26' AS line,
        'WORK HOUR RATE' AS description,
        hour_agg.fiscal_year_month,
        cr.composite_rate AS ttl
    FROM hour_agg
    LEFT JOIN composite_rate cr ON hour_agg.function_code = cr.function_code
    AND hour_agg.pricing_group_number = cr.pricing_group_number
    AND hour_agg.fiscal_year_month = cr.accounting_period_month
),
allUp AS (
    SELECT
        *
    FROM hour_agg
    WHERE line IS NOT NULL
    UNION ALL
    SELECT
        *
    FROM function_dollars
    WHERE line IS NOT NULL
    UNION ALL
    SELECT
        *
    FROM totalSalariesAndBennies
    WHERE line IS NOT NULL
    UNION ALL
    SELECT
        *
    FROM totalHours
    WHERE line IS NOT NULL
    UNION ALL
    SELECT
        *
    FROM workHourRate
    WHERE line IS NOT NULL
)
SELECT
    *,
    CASE
        WHEN line = '10' AND description = 'DOLLARS' THEN 'OPERATIONS SUPPORT (F0)'
        WHEN line = '10' AND description = 'WORK HOURS' THEN '    F0 WORK HOURS'
        WHEN line = '11' AND description = 'DOLLARS' THEN 'MAIL PROCESSING (F1)'
        WHEN line = '11' AND description = 'WORK HOURS' THEN '    F1 WORK HOURS'
        WHEN line = '12' and description = 'DOLLARS' THEN 'RURAL DELIVERY(F2A)'
        WHEN line = '12' AND description = 'WORK HOURS' THEN '    F2A WORK HOURS'
        WHEN line = '13' AND description = 'DOLLARS' THEN 'VEHICLE SERVICES (F3A)'
        WHEN line = '13' AND description = 'WORK HOURS' THEN '    F3A WORK HOURS'

        WHEN line = '14' AND description = 'DOLLARS' THEN 'CUSTOMER SERVICE(F4)'
        WHEN line = '14' AND description = 'WORK HOURS' THEN '    F4 WORK HOURS'
        WHEN line = '15' AND description = 'DOLLARS' THEN 'FINANCE (F5)'
        WHEN line = '15' AND description = 'WORK HOURS' THEN '    F5 WORK HOURS'
        WHEN line = '16' AND description = 'DOLLARS' THEN 'HUMAN RESOURCES (F6)'
        WHEN line = '15' AND description = 'WORK HOURS' THEN '    F6 WORK HOURS'
        WHEN line = '17' AND description = 'DOLLARS' THEN 'CUSTOMER SERVICE & SALES (F7)'
        WHEN line = '17' AND description = 'WORK HOURS' THEN 'F7 WORK HOURS'

        WHEN line = '18' AND description = 'DOLLARS' THEN 'ADMINISTRATION (F8)'
        WHEN line = '18' AND description = 'WORK HOURS' THEN '    F8 WORK HOURS'

        WHEN line = '22' AND description = 'DOLLARS' THEN 'CITY DELIVERY (F2B)'
        WHEN line = '22' AND description = 'WORK HOURS' THEN '    F2B WORK HOURS'

        WHEN line = '23' AND description = 'DOLLARS' THEN'PLANT & EQUIP MAINT (F3B)'
        WHEN line = '23' and description = 'WORK HOURS' THEN '    F3B WORK HOURS'
        WHEN line = '24' AND description = 'TOTAL DOLLARS' THEN 'TOTAL SALARIES & BENEFITS'
        WHEN line = '25' and description = 'TOTAL WORK HOURS' THEN 'TOTAL WORK HOURS'
        WHEN line = '26' and description = 'WORK HOUR RATE' THEN 'WORK HOUR RATE'
        END AS BoprReportDescription
      ,
      CASE
        WHEN description = 'TOTAL DOLLARS' THEN '**'
        WHEN description = 'TOTAL WORK HOURS' THEN '**'
        WHEN description = 'WORK HOUR RATE' THEN '**'
        ELSE line
      END AS BoprReportLineNumberLabel
      from allUP
      WHERE LINE IS NOT NULL


      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: BoprReportLineNumberLabel {
    label: "Line No."
    type: string
    sql: ${TABLE}.BoprReportLineNumberLabel ;;
  }

  dimension: BoprReportDescription {
    type: string
    sql: ${TABLE}.BoprReportDescription ;;
  }


  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }

  dimension: pricing_group_number {
    type: string
    sql: ${TABLE}.pricing_group_number ;;
  }

  dimension: finance_number {
    type: string
    sql: ${TABLE}.finance_number ;;
  }

  dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
  }

  dimension: function_distribution_code {
    type: string
    sql: ${TABLE}.function_distribution_code ;;
  }

  dimension: district_division_code {
    type: string
    sql: ${TABLE}.district_division_code ;;
  }

  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }

  dimension: line {
    type: string
    sql: ${TABLE}.line ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: fiscal_year_month {
    label: "FY Mo."
    type: string
    sql: ${TABLE}.fiscal_year_month ;;
  }

  measure: ttl {
    type: number
    label: "Line Value"
    link: {
      label: "Drill into total"
      url: "https://google.com"
    }
    sql: CASE
        WHEN ${TABLE}.description = 'WORK HOUR RATE' THEN AVG(${TABLE}.ttl)
        ELSE SUM(${TABLE}.ttl)
    END ;;
    drill_fields: [detail*]
    value_format: "[<=100]$0.00;#,##0"


  }

  set: detail {
    fields: [
      fiscal_year,
      pricing_group_number,
      finance_number,
      area_region_code,
      function_distribution_code,
      district_division_code,
      function_code,
      line,
      description,
      fiscal_year_month,
      ttl
    ]
  }
}
