
view: revenue_details {
  derived_table: {
    sql:
     ------------------------------------ START REVENUE SECTION
      with revenueSection as (


      WITH
      revenue_first AS
      ( SELECT fiscal_year ,finance_number ,
      case WHEN revenue_sub_line_number_code IN ('A0','A1','A2','A3','A4','A5','A6','A7','A8','A9') THEN '01'
      WHEN revenue_sub_line_number_code IN ('C0','C1','C2','C3','C4','C5','C6','C7','C8','C9') THEN '02'
      WHEN revenue_sub_line_number_code IN ('E0','E1','E2','E3','E4','E5','E6','E7','E8','E9') THEN '03'
      WHEN revenue_sub_line_number_code IN ('G0','G1','G2','G3','G4','G5','G6','G7','G8','G9') THEN '04'
      WHEN revenue_sub_line_number_code IN ('I0','I1','I2','I3','I4','I5','I6','I7','I8','I9') THEN '05'
      WHEN revenue_sub_line_number_code IN ('K0','K1','K2','K3','K4','K5','K6','K7','K8','K9') THEN '06'
      WHEN revenue_sub_line_number_code IN ('L0','L1','L2','L3','L4','L5','L6','L7','L8','L9','M0','M1','M2','M3','M4','M5','M6','M7','M8','M9') THEN '07'
      WHEN revenue_sub_line_number_code IN ('Q0') THEN '08'
      WHEN revenue_sub_line_number_code IN ('R0') THEN '09' END AS line ,
      fiscal_year_month ,plan_dollars ,function_distribution_code
      FROM ( SELECT *,row_number() OVER (PARTITION BY fiscal_year,finance_number,revenue_sub_line_number_code,fiscal_year_month ORDER BY last_update_date_time DESC) AS row_num
      FROM `ibps.revenue_plan_t`
      )rs WHERE row_num =1 ),

      hq_fdc AS
      ( SELECT fiscal_year, finance_number, function_distribution_code
      FROM (SELECT *,row_number() OVER (PARTITION BY fiscal_year,finance_number ORDER BY last_update_date_time DESC) AS row_num
      FROM `ibps.finance_number_t` )d WHERE row_num =1 ),

      hq_revenue_first as ( SELECT fiscalYear ,financeNbr ,
      case WHEN lineNbr IN ('A0','A1','A2','A3','A4','A5','A6','A7','A8','A9') THEN '01'
      WHEN lineNbr IN ('C0','C1','C2','C3','C4','C5','C6','C7','C8','C9') THEN '02'
      WHEN lineNbr IN ('E0','E1','E2','E3','E4','E5','E6','E7','E8','E9') THEN '03'
      WHEN lineNbr IN ('G0','G1','G2','G3','G4','G5','G6','G7','G8','G9') THEN '04'
      WHEN lineNbr IN ('I0','I1','I2','I3','I4','I5','I6','I7','I8','I9') THEN '05'
      WHEN lineNbr IN ('K0','K1','K2','K3','K4','K5','K6','K7','K8','K9') THEN '06'
      WHEN lineNbr IN ('L0','L1','L2','L3','L4','L5','L6','L7','L8','L9','M0','M1','M2','M3','M4','M5','M6','M7','M8','M9') THEN '07'
      WHEN lineNbr IN ('Q0') THEN '08'
      WHEN lineNbr IN ('R0') THEN '09' END AS line ,
      month ,
      --CAST(EXTRACT(MONTH FROM (DATE_ADD(PARSE_DATE("%Y%m%d",CONCAT(fiscalYear,LPAD(month,2,'0'),'01')),INTERVAL -1 QUARTER))) AS STRING) AS month,
      expAmt, hq_fdc.function_distribution_code
      FROM ( SELECT *,row_number() OVER (PARTITION BY fiscalYear,financeNbr,lineNbr,month ORDER BY lastUpdateDateTime DESC) AS row_num
      FROM `ibps.hq_line_number_plan_t`
      where DATE(lastUpdateDateTime)  >= DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY)
      and lineNbr in ('A0','A1','A2','A3','A4','A5','A6','A7','A8','A9',
      'C0','C1','C2','C3','C4','C5','C6','C7','C8','C9','E0','E1','E2','E3','E4','E5','E6','E7','E8','E9',
      'G0','G1','G2','G3','G4','G5','G6','G7','G8','G9','I0','I1','I2','I3','I4','I5','I6','I7','I8','I9',
      'K0','K1','K2','K3','K4','K5','K6','K7','K8','K9','L0','L1','L2','L3','L4','L5','L6','L7','L8','L9','M0','M1','M2','M3','M4','M5','M6','M7','M8','M9',
      'Q0','R0')
      )rs
      left join hq_fdc
      on rs.financeNbr = hq_fdc.finance_number
      and rs.fiscalYear = hq_fdc.fiscal_year
      WHERE row_num =1 ),

      revenue_second AS ( SELECT *,
      case WHEN line ='01' THEN 'TOTAL PERMIT'
      WHEN line ='02' THEN 'TOTAL OTHER COMM'
      WHEN line ='03' THEN 'TOT SHIPPING CHARGES'
      WHEN line ='04' THEN 'TOT SHIPPING SERVICES'
      WHEN line ='05' THEN 'TOT SHIPPING PRODUCTS'
      WHEN line ='06' THEN 'TOT OTH SHIPPING CHAN'
      WHEN line ='07' THEN 'TOTAL OTHER INCOME'
      WHEN line ='08' THEN 'APPROPRIATIONS'
      WHEN line ='09' THEN 'INVESTMENT INCOME' END AS description FROM revenue_first
      UNION ALL
      SELECT fiscalYear as fiscal_year,
      financeNbr as finance_number,
      line,
      month as fiscal_year_month,
      expAmt as plan_dollars,
      function_distribution_code,
      case WHEN line ='01' THEN 'TOTAL PERMIT'
      WHEN line ='02' THEN 'TOTAL OTHER COMM'
      WHEN line ='03' THEN 'TOT SHIPPING CHARGES'
      WHEN line ='04' THEN 'TOT SHIPPING SERVICES'
      WHEN line ='05' THEN 'TOT SHIPPING PRODUCTS'
      WHEN line ='06' THEN 'TOT OTH SHIPPING CHAN'
      WHEN line ='07' THEN 'TOTAL OTHER INCOME'
      WHEN line ='08' THEN 'APPROPRIATIONS'
      WHEN line ='09' THEN 'INVESTMENT INCOME' END AS description FROM hq_revenue_first),
      finance_number_t AS
      ( SELECT finance_number_name, area_region_code, area_region_name, district_division_code, district_division_name, function_distribution_code,
      manager_of_post_office_operations, cost_ascertaining_group, pricing_group_number, finance_number, fiscal_year, user_modified
      FROM (SELECT *,row_number() OVER (PARTITION BY fiscal_year,finance_number ORDER BY last_update_date_time DESC) AS row_num
      FROM `ibps.finance_number_t` )d WHERE row_num =1),

      revenue_group AS
      ( SELECT rs.fiscal_year ,pricing_group_number ,rs.finance_number ,area_region_code ,fn.function_distribution_code ,district_division_code ,
      line ,description ,fiscal_year_month ,sum(plan_dollars) AS total
      FROM revenue_second rs
      INNER JOIN finance_number_t fn on fn. finance_number = rs.finance_number AND fn.fiscal_year = rs.fiscal_year AND
      LPAD(fn.function_distribution_code,3,'0') = LPAD(rs.function_distribution_code,3,'0')
      GROUP BY 1,2,3,4,5,6,7,8,9 )


      SELECT
      revenue_group.fiscal_year,
      revenue_group.pricing_group_number,
      revenue_group.finance_number,
      revenue_group.area_region_code,
      revenue_group.function_distribution_code,
      revenue_group.district_division_code,
      'nil' as function_code,
      line,
      description,
      revenue_group.fiscal_year_month,
      total AS ttl
      FROM revenue_group
      where line != '08' and line != '09'

      )

      , rev_totalCommercialRevenue as (
      SELECT
      revenueSection.fiscal_year,
      revenueSection.pricing_group_number,
      revenueSection.finance_number,
      revenueSection.area_region_code,
      revenueSection.function_distribution_code,
      revenueSection.district_division_code,
      'nil' as function_code,
      '02A' as line,
      'TOTAL COMMERCIAL REVENUE' as description,
      revenueSection.fiscal_year_month,
      CASE WHEN
      line = '01' OR line = '02' THEN ttl
      ELSE 0
      END AS ttl
      FROM revenueSection

      ), rev_subtotalRetailUnitSales as (
      SELECT
      revenueSection.fiscal_year,
      revenueSection.pricing_group_number,
      revenueSection.finance_number,
      revenueSection.area_region_code,
      revenueSection.function_distribution_code,
      revenueSection.district_division_code,
      'nil' as function_code,
      '05A' as line,
      'SUBTOTAL SHIPPING UNIT SALES' as description,
      revenueSection.fiscal_year_month,
      CASE WHEN
      line = '03' OR line = '04' OR line = '05' THEN ttl
      ELSE 0
      END AS ttl
      FROM revenueSection

      ), rev_totalRetailRev as (
      SELECT
      revenueSection.fiscal_year,
      revenueSection.pricing_group_number,
      revenueSection.finance_number,
      revenueSection.area_region_code,
      revenueSection.function_distribution_code,
      revenueSection.district_division_code,
      'nil' as function_code,
      '06A' as line,
      'TOTAL SHIPPING REVENUE' as description,
      revenueSection.fiscal_year_month,
      CASE WHEN
      line = '03' OR line = '04' OR line = '05' OR line = '06' THEN ttl
      ELSE 0
      END AS ttl
      FROM revenueSection

      ), rev_totalAllRevenue as (
      SELECT
      revenueSection.fiscal_year,
      revenueSection.pricing_group_number,
      revenueSection.finance_number,
      revenueSection.area_region_code,
      revenueSection.function_distribution_code,
      revenueSection.district_division_code,
      'nil' as function_code,
      '07A' as line,
      'TOTAL ALL REVENUE' as description,
      revenueSection.fiscal_year_month,
      CASE WHEN
      line = '03' OR line = '04' OR line = '05' OR line = '06' OR line = '07' THEN ttl
      ELSE 0
      END AS ttl
      FROM revenueSection

      )
      ------------------------------------ START WORK HOURS SECTION
      , cal AS (
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
      ------------------------------------ START EXPENSES SECTION


      expensesSection as (

      with field_line_first AS (
      SELECT
      fiscal_year,
      finance_number,
      description,
      line_number_code AS line_number,
      fiscal_year_month,
      plan_dollars,
      function_distribution_code

      FROM (
      SELECT
      *,
      CASE
      WHEN line_number_code ='27' THEN 'FLEX PLAN ADJ-FIELD'
      WHEN line_number_code ='28' THEN 'OTHER LEAVE FLEX'
      WHEN line_number_code ='29' THEN 'FLEX PLAN ADJ-SAL'
      WHEN line_number_code ='2A' THEN 'PERFORMANCE BSD COM'
      WHEN line_number_code ='2B' THEN 'SEV. PAY/SURV.BEN.P'
      WHEN line_number_code ='2C' THEN 'EMPLOYEE AWARDS'
      WHEN line_number_code ='2D' THEN 'MISC COMPENSATION'
      WHEN line_number_code ='2E' THEN 'UNEMPLY COMPENSATION'
      WHEN line_number_code ='2F' THEN 'ANNUIT LIFE INS&WCHB'
      WHEN line_number_code ='2W' THEN 'Currently Not active'
      WHEN line_number_code ='2H' THEN 'REPRICING ANNUAL LEA'
      WHEN line_number_code ='2I' THEN 'OTHER COMPENSATION'
      WHEN line_number_code ='2J' THEN 'WORKERS COMP CHG BK'
      WHEN line_number_code ='2K' THEN 'HEALTH BEN. RETIREES'
      WHEN line_number_code ='2M' THEN 'RELOCATION BENEFITS'
      WHEN line_number_code ='25' THEN 'LEAVE LIABILITY ADJ'
      WHEN line_number_code ='31' THEN 'SUPPLIES'
      WHEN line_number_code ='32' THEN 'FURNITURE & EQUIPME'
      WHEN line_number_code ='33' THEN 'SUPPL-INVENTORY ISS'
      WHEN line_number_code ='34' THEN 'SERVICES'
      WHEN line_number_code ='35' THEN 'MEDICAL'
      WHEN line_number_code ='36' THEN 'CONSULT SERV X ADV'
      WHEN line_number_code ='37' THEN 'EQUP RENT&REPAIR-OT'
      WHEN line_number_code ='38' THEN 'COST OF SALE ITEMS'
      WHEN line_number_code ='39' THEN 'ADVERTISING'
      WHEN line_number_code ='3A' THEN 'SUP/SERV EXP REDUC'
      WHEN line_number_code ='3B' THEN 'PROJECTS EXPENSED'
      WHEN line_number_code ='3C' THEN 'NOT USED currently'
      WHEN line_number_code ='3D' THEN 'TRAVEL OTH. THAN TR'
      WHEN line_number_code ='3E' THEN 'TRAINING'
      WHEN line_number_code ='3F' THEN 'CONTRACT JOB CLEANE'
      WHEN line_number_code ='3G' THEN 'CONTRACT STATIONS'
      WHEN line_number_code ='3H' THEN 'VEHICLE MAINT. SERV'
      WHEN line_number_code ='3I' THEN 'VEHICLE FUEL'
      WHEN line_number_code ='3J' THEN 'VEHICLE HIRE'
      WHEN line_number_code ='3K' THEN 'CARFARE,T,F,& SPEC'
      WHEN line_number_code ='3L' THEN 'RURAL CARR.EQUIP.MA'
      WHEN line_number_code ='3M' THEN 'ACCIDENT COST'
      WHEN line_number_code ='3N' THEN 'OTHER EXP RED/RECOV'
      WHEN line_number_code ='3P' THEN 'TRANS. HIGHWAY'
      WHEN line_number_code ='3Q' THEN 'TRANS. RAIL'
      WHEN line_number_code ='3R' THEN 'TRANS. AIR'
      WHEN line_number_code ='3S' THEN 'TRANS. OTHER'
      WHEN line_number_code ='3T' THEN 'TRANS EXP REDUCTION'
      WHEN line_number_code ='3X' THEN 'INTL TRANSPORTATION'
      WHEN line_number_code ='3U' THEN 'PRINTING'
      WHEN line_number_code ='3V' THEN 'IRM CHARGEBACK'
      WHEN line_number_code ='41' THEN 'RENT'
      WHEN line_number_code ='42' THEN 'FUEL & UTILITIES'
      WHEN line_number_code ='43' THEN 'DEPRECIATION'
      WHEN line_number_code ='44' THEN 'MISCELLANEOUS'
      WHEN line_number_code ='45' THEN 'COMMUNICATIONS'
      WHEN line_number_code ='46' THEN 'INFO TECH'
      WHEN line_number_code ='48' THEN 'INSP RECOVERIES'
      WHEN line_number_code ='49' THEN 'HOMELAND SECURITY'
      WHEN line_number_code ='5A' THEN 'BOND INTEREST EXPENS'
      WHEN line_number_code ='5D' THEN 'INT EXP TO CAP PRJ'
      WHEN line_number_code ='5G' THEN 'INDEMNITIES'
      WHEN line_number_code ='5H' THEN 'MISC JUDGEMENTS'
      WHEN line_number_code ='5I' THEN 'BUDGET ADJUSTMENTS'
      WHEN line_number_code ='5B' THEN 'NOTE INTEREST EXPENS'
      WHEN line_number_code ='5C' THEN 'OTHER INTEREST EXP'
      WHEN line_number_code ='5E' THEN 'ACCRUED INTEREST-CSR'
      WHEN line_number_code ='6A' THEN 'C S BLDG CONSTR'
      WHEN line_number_code ='6B' THEN 'C S BLDG PURCHASES'
      WHEN line_number_code ='6C' THEN 'C S BLDG EXPANSNS'
      WHEN line_number_code ='6D' THEN 'M P BLDG CONSTR'
      WHEN line_number_code ='6E' THEN 'M P BLDG PURCHASES'
      WHEN line_number_code ='6F' THEN 'M P BLDG EXPANSNS'
      WHEN line_number_code ='6G' THEN 'BLDG IMPROVEMENT F'
      WHEN line_number_code ='6H' THEN 'FIXED MECHANIZATION'
      WHEN line_number_code ='6J' THEN 'NON-FIXED MECH'
      WHEN line_number_code ='6K' THEN 'OTHER PACKAGE HANDLNG'
      WHEN line_number_code ='6L' THEN 'AUTO EQUIPMENT'
      WHEN line_number_code ='6M' THEN 'CAPITALIZED SOFTWAR'
      WHEN line_number_code ='6N' THEN 'VEHICLE PURCHASES'
      WHEN line_number_code ='6O' THEN 'VEHICLE AUX EQUIP'
      WHEN line_number_code ='6P' THEN 'VEHICLE FREIGHT'
      WHEN line_number_code ='6Q' THEN 'LOBBY EQUIPMENT'
      WHEN line_number_code ='6R' THEN 'WINDOW SERV EQUIP'
      WHEN line_number_code ='6S' THEN 'SELF/SERV EQUIP'
      WHEN line_number_code ='6U' THEN 'ADM/GEN SPT EQUIP'
      WHEN line_number_code ='6V' THEN 'MAINT EQUIPMENT'
      WHEN line_number_code ='6w' THEN 'ADP EQUIPMENT'
      WHEN line_number_code ='6X' THEN 'CAPITAL CREDIT CARD'
      END

      AS description,
      ROW_NUMBER() OVER (PARTITION BY fiscal_year, finance_number, line_number_code, fiscal_year_month ORDER BY last_update_date_time DESC) AS row_num

      FROM

      `ibps.line_number_plan_t`
      )ls

      WHERE

      row_num =1 ),  --END field_line_first
      hq_line_first AS (
      SELECT

      fiscalYear AS fiscal_year,
      financeNbr AS finance_number,
      description AS description,
      lineNbr AS line_number,
      month AS fiscal_year_month,
      --CAST(EXTRACT(MONTH FROM (DATE_ADD(PARSE_DATE("%Y%m%d",CONCAT(fiscalYear,LPAD(month,2,'0'),'01')),INTERVAL -1 QUARTER))) AS STRING) AS fiscal_year_month,
      expAmt AS plan_dollars,
      ' ' AS function_distribution_code

      FROM (
      SELECT

      *,
      CASE

      WHEN lineNbr ='10' THEN 'OPERATIONS SUPPORT (F0)'
      WHEN lineNbr ='11' THEN 'PACKAGE PROCESSING (F1)'
      WHEN lineNbr ='12' THEN 'EXTENDED DISPATCH (F2A)'
      WHEN lineNbr ='13' THEN 'VEHICLE SERVICES (F3A)'
      WHEN lineNbr ='14' THEN 'CUSTOMER SERVICE (F4)'
      WHEN lineNbr ='15' THEN 'FINANCE (F5)'
      WHEN lineNbr ='16' THEN 'HUMAN RESOURCES (F6)'
      WHEN lineNbr ='17' THEN 'CUSTOMER SERVICE & SALES (F7)'
      WHEN lineNbr ='18' THEN 'ADMINISTRATION (F8)'
      WHEN lineNbr ='20' THEN 'LIMITED DUTY'
      WHEN lineNbr ='21' THEN 'REHABILITATION'
      WHEN lineNbr ='22' THEN 'LOCAL DISPATCH (F2B)'
      WHEN lineNbr ='23' THEN 'PLANT & EQUIP MAINT (F3B)'
      WHEN lineNbr ='24' THEN 'HQ GENERAL MGMT'
      WHEN lineNbr ='27' THEN 'FLEX PLAN ADJ-FIELD'
      WHEN lineNbr ='28' THEN 'OTHER LEAVE FLEX'
      WHEN lineNbr ='29' THEN 'FLEX PLAN ADJ-SAL'
      WHEN lineNbr ='2A' THEN 'PERFORMANCE BSD COM'
      WHEN lineNbr ='2B' THEN 'SEV. PAY/SURV.BEN.P'
      WHEN lineNbr ='2C' THEN 'EMPLOYEE AWARDS'
      WHEN lineNbr ='2D' THEN 'MISC COMPENSATION'
      WHEN lineNbr ='2E' THEN 'UNEMPLY COMPENSATION'
      WHEN lineNbr ='2F' THEN 'ANNUIT LIFE INS&WCHB'
      WHEN lineNbr ='2W' THEN 'Currently Not active'
      WHEN lineNbr ='2H' THEN 'REPRICING ANNUAL LEA'
      WHEN lineNbr ='2I' THEN 'OTHER COMPENSATION'
      WHEN lineNbr ='2J' THEN 'WORKERS COMP CHG BK'
      WHEN lineNbr ='2K' THEN 'HEALTH BEN. RETIREES'
      WHEN lineNbr ='2M' THEN 'RELOCATION BENEFITS'
      WHEN lineNbr ='25' THEN 'LEAVE LIABILITY ADJ'
      WHEN lineNbr ='31' THEN 'SUPPLIES'
      WHEN lineNbr ='32' THEN 'FURNITURE & EQUIPME'
      WHEN lineNbr ='33' THEN 'SUPPL-INVENTORY ISS'
      WHEN lineNbr ='34' THEN 'SERVICES'
      WHEN lineNbr ='35' THEN 'MEDICAL'
      WHEN lineNbr ='36' THEN 'CONSULT SERV X ADV'
      WHEN lineNbr ='37' THEN 'EQUP RENT&REPAIR-OT'
      WHEN lineNbr ='38' THEN 'COST OF SALE ITEMS'
      WHEN lineNbr ='39' THEN 'ADVERTISING'
      WHEN lineNbr ='3A' THEN 'SUP/SERV EXP REDUC'
      WHEN lineNbr ='3B' THEN 'PROJECTS EXPENSED'
      WHEN lineNbr ='3C' THEN 'NOT USED currently'
      WHEN lineNbr ='3D' THEN 'TRAVEL OTH. THAN TR'
      WHEN lineNbr ='3E' THEN 'TRAINING'
      WHEN lineNbr ='3F' THEN 'CONTRACT JOB CLEANE'
      WHEN lineNbr ='3G' THEN 'CONTRACT STATIONS'
      WHEN lineNbr ='3H' THEN 'VEHICLE MAINT. SERV'
      WHEN lineNbr ='3I' THEN 'VEHICLE FUEL'
      WHEN lineNbr ='3J' THEN 'VEHICLE HIRE'
      WHEN lineNbr ='3K' THEN 'CARFARE,T,F,& SPEC'
      WHEN lineNbr ='3L' THEN 'RURAL CARR.EQUIP.MA'
      WHEN lineNbr ='3M' THEN 'ACCIDENT COST'
      WHEN lineNbr ='3N' THEN 'OTHER EXP RED/RECOV'
      WHEN lineNbr ='3P' THEN 'TRANS. HIGHWAY'
      WHEN lineNbr ='3Q' THEN 'TRANS. RAIL'
      WHEN lineNbr ='3R' THEN 'TRANS. AIR'
      WHEN lineNbr ='3S' THEN 'TRANS. OTHER'
      WHEN lineNbr ='3T' THEN 'TRANS EXP REDUCTION'
      WHEN lineNbr ='3X' THEN 'INTL TRANSPORTATION'
      WHEN lineNbr ='3U' THEN 'PRINTING'
      WHEN lineNbr ='3V' THEN 'IRM CHARGEBACK'
      WHEN lineNbr ='41' THEN 'RENT'
      WHEN lineNbr ='42' THEN 'FUEL & UTILITIES'
      WHEN lineNbr ='43' THEN 'DEPRECIATION'
      WHEN lineNbr ='44' THEN 'MISCELLANEOUS'
      WHEN lineNbr ='45' THEN 'COMMUNICATIONS'
      WHEN lineNbr ='46' THEN 'INFO TECH'
      WHEN lineNbr ='48' THEN 'INSP RECOVERIES'
      WHEN lineNbr ='49' THEN 'HOMELAND SECURITY'
      WHEN lineNbr ='5A' THEN 'BOND INTEREST EXPENS'
      WHEN lineNbr ='5D' THEN 'INT EXP TO CAP PRJ'
      WHEN lineNbr ='5G' THEN 'INDEMNITIES'
      WHEN lineNbr ='5H' THEN 'MISC JUDGEMENTS'
      WHEN lineNbr ='5I' THEN 'BUDGET ADJUSTMENTS'
      WHEN lineNbr ='5B' THEN 'NOTE INTEREST EXPENS'
      WHEN lineNbr ='5C' THEN 'OTHER INTEREST EXP'
      WHEN lineNbr ='5E' THEN 'ACCRUED INTEREST-CSR'
      WHEN lineNbr ='5F' THEN 'FIN LEASE INT EXP'
      WHEN lineNbr ='6A' THEN 'C S BLDG CONSTR'
      WHEN lineNbr ='6B' THEN 'C S BLDG PURCHASES'
      WHEN lineNbr ='6C' THEN 'C S BLDG EXPANSNS'
      WHEN lineNbr ='6D' THEN 'M P BLDG CONSTR'
      WHEN lineNbr ='6E' THEN 'M P BLDG PURCHASES'
      WHEN lineNbr ='6F' THEN 'M P BLDG EXPANSNS'
      WHEN lineNbr ='6G' THEN 'BLDG IMPROVEMENT F'
      WHEN lineNbr ='6H' THEN 'FIXED MECHANIZATION'
      WHEN lineNbr ='6J' THEN 'NON-FIXED MECH'
      WHEN lineNbr ='6K' THEN 'OTHER PACKAGE HANDLNG'
      WHEN lineNbr ='6L' THEN 'AUTO EQUIPMENT'
      WHEN lineNbr ='6M' THEN 'CAPITALIZED SOFTWAR'
      WHEN lineNbr ='6N' THEN 'VEHICLE PURCHASES'
      WHEN lineNbr ='6O' THEN 'VEHICLE AUX EQUIP'
      WHEN lineNbr ='6P' THEN 'VEHICLE FREIGHT'
      WHEN lineNbr ='6Q' THEN 'LOBBY EQUIPMENT'
      WHEN lineNbr ='6R' THEN 'WINDOW SERV EQUIP'
      WHEN lineNbr ='6S' THEN 'SELF/SERV EQUIP'
      WHEN lineNbr ='6U' THEN 'ADM/GEN SPT EQUIP'
      WHEN lineNbr ='6V' THEN 'MAINT EQUIPMENT'
      WHEN lineNbr ='6W' THEN 'ADP EQUIPMENT'
      WHEN lineNbr ='6X' THEN 'CAPITAL CREDIT CARD'
      ELSE lineNbr

      END

      AS description,
      ROW_NUMBER() OVER (PARTITION BY fiscalYear, financeNbr, lineNbr, month ORDER BY lastUpdateDateTime DESC) AS row_num

      FROM

      `ibps.hq_line_number_plan_t`
      WHERE DATE(lastUpdateDateTime)  >= DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY) AND lineNbr IN

      ('10','11','12','13','14','15','16','17','18','20','21','22','23','24','27','28','29','2A','2B','2C','2D','2E','2F','2W','2H','2I','2J','2K','2M','25','31','32','33','34','35','36','37',
      '38','39','3A', '3B','3C','3D','3E','3F','3G','3H','3I','3J','3K','3L','3M','3N','3P','3Q','3R','3S','3T','3X','3U', '3V','41','42','43', '44','45', '46','48','49','5A','5D','5F','5G','5H','5I','5B','5C','5E','6A','6B','6C','6D','6E','6F','6G','6H','6J','6K','6L','6M','6N','6O','6P','6Q','6R', '6S','6U','6V','6W','6X')
      )ls

      WHERE

      row_num =1 ),  --END hq_line_first
      finance_number_t AS (
      SELECT

      finance_number_name,
      area_region_code,
      area_region_name,
      district_division_code,
      district_division_name,
      function_distribution_code,
      manager_of_post_office_operations,
      cost_ascertaining_group,
      pricing_group_number,
      finance_number,
      fiscal_year,
      user_modified,
      FROM (
      SELECT

      *,
      ROW_NUMBER() OVER (PARTITION BY fiscal_year, finance_number ORDER BY last_update_date_time DESC) AS row_num

      FROM

      `ibps.finance_number_t`
      )d

      WHERE row_num =1
      ),  --END finance_number_t
      line_agg AS (
      (SELECT

      ls.fiscal_year,
      pricing_group_number,
      ls.finance_number,
      area_region_code,
      fn.function_distribution_code,
      district_division_code,
      'nil' as function_code,
      ls.line_number as line,
      ls.description,
      ls.fiscal_year_month,
      SUM(plan_dollars) AS ttl

      FROM
      field_line_first ls
      LEFT JOIN
      finance_number_t fn

      ON
      fn. finance_number = ls.finance_number
      AND fn.fiscal_year = ls.fiscal_year
      AND LPAD(fn.function_distribution_code,3,'0') = LPAD(ls.function_distribution_code,3,'0')
      GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 )
      UNION ALL
      (SELECT

      hls.fiscal_year,
      pricing_group_number,
      hls.finance_number,
      area_region_code,
      fn.function_distribution_code,
      district_division_code,
      'nil' as function_code,
      hls.line_number as line,
      hls.description,
      hls.fiscal_year_month,
      SUM(plan_dollars) AS ttl
      FROM
      hq_line_first hls
      LEFT JOIN
      finance_number_t fn
      ON
      fn. finance_number = hls.finance_number
      AND fn.fiscal_year = hls.fiscal_year
      GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 )
      )  --END line_agg
      SELECT
      *
      FROM
      line_agg

      ),

      exp_totalSalBenPlusFlex as (

      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '29A' as line,
      'TOTAL SAL & BEN + FLEX' as description,
      expensesSection.fiscal_year_month,
      SUM
      (CASE WHEN
      expensesSection.line in ('27', '28', '29') THEN expensesSection.ttl
      ELSE 0
      END) + totalSalariesAndBennies.ttl AS ttl
      FROM expensesSection
      LEFT JOIN totalSalariesAndBennies
      ON expensesSection.finance_number = totalSalariesAndBennies.finance_number
      AND expensesSection.fiscal_year_month = totalSalariesAndBennies.fiscal_year_month
      GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, totalSalariesAndBennies.ttl

      ),

      exp_TotalOtherPersonellComp as (
      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '2MA' as line,
      'TOTAL OTHER PERSONELL COMP' as description,
      expensesSection.fiscal_year_month,
      CASE WHEN
      line in ('2A', '2C', '2F', '2J', '2M') THEN ttl
      ELSE 0
      END AS ttl
      FROM expensesSection
      ),


      exp_TotalPersonellComp as (
      SELECT
      exp_TotalOtherPersonellComp.fiscal_year,
      exp_TotalOtherPersonellComp.pricing_group_number,
      exp_TotalOtherPersonellComp.finance_number,
      exp_TotalOtherPersonellComp.area_region_code,
      exp_TotalOtherPersonellComp.function_distribution_code,
      exp_TotalOtherPersonellComp.district_division_code,
      'nil' as function_code,
      '2MB' as line,
      'TOTAL PERSONELL COMP' as description,
      exp_TotalOtherPersonellComp.fiscal_year_month,
      SUM(exp_TotalOtherPersonellComp.ttl) + totalSalariesAndBennies.ttl as ttl
      FROM exp_TotalOtherPersonellComp
      LEFT JOIN totalSalariesAndBennies
      ON exp_TotalOtherPersonellComp.finance_number = totalSalariesAndBennies.finance_number
      AND exp_TotalOtherPersonellComp.fiscal_year_month = totalSalariesAndBennies.fiscal_year_month
      group BY 1, 2,3,4,5,6,7,8,9, 10, totalSalariesAndBennies.ttl

      ),


      exp_SubtotalSupliesAndServices as (
      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '39A' as line,
      'SUBTOTAL SUPPLIES & SVCS' as description,
      expensesSection.fiscal_year_month,
      CASE WHEN
      line in ('31', '32', '33', '34', '35', '36', '37', '38', '39') THEN ttl
      ELSE 0
      END AS ttl
      FROM expensesSection
      ),

      exp_SubtotalOtherExpenses as (
      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '3MA' as line,
      'SUBTOTAL OTHER EXPENSES' as description,
      expensesSection.fiscal_year_month,
      CASE WHEN
      line in ('3B', '3D', '3E', '3F', '3G', '3H', '3I', '3J', '3K', '3L', '3M' ) THEN ttl
      ELSE 0
      END AS ttl
      FROM expensesSection
      ),

      exp_SubtotalTransporationExpenses as (
      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '3SA' as line,
      'SUBTOTAL TRANSP EXPENSES' as description,
      expensesSection.fiscal_year_month,
      CASE WHEN
      line in ('3P', '3R', '3S' ) THEN ttl
      ELSE 0
      END AS ttl
      FROM expensesSection
      ),

      exp_SubtotalMiscExpense as (
      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '46A' as line,
      'SUBTOTAL MISC EXPENSES' as description,
      expensesSection.fiscal_year_month,
      CASE WHEN
      line in ('3U', '41', '42', '43', '44', '45', '46' ) THEN ttl
      ELSE 0
      END AS ttl
      FROM expensesSection
      ),

      exp_TotalNonPersonellExpense as (
      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '46B' as line,
      'TOTAL NON-PERSONNEL EXPENSE' as description,
      expensesSection.fiscal_year_month,
      CASE WHEN
      line in
      ('31', '32', '33', '34', '35', '36', '37', '38', '39'
      '3B', '3D', '3E', '3F', '3G', '3H', '3I', '3J', '3K', '3L', '3M'
      '3P', '3R', '3S'
      '3U', '41', '42', '43', '44', '45', '46' ) THEN ttl
      ELSE 0
      END AS ttl
      FROM expensesSection
      ),

      exp_TotalNonPersonellExpenseLessTransp as (
      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '46C' as line,
      'TOTAL NON PERS EXP LESS TRANSP' as description,
      expensesSection.fiscal_year_month,
      CASE WHEN
      line in
      ('31', '32', '33', '34', '35', '36', '37', '38', '39'
      '3B', '3D', '3E', '3F', '3G', '3H', '3I', '3J', '3K', '3L', '3M'
      '3U', '41', '42', '43', '44', '45', '46' ) THEN ttl
      ELSE 0
      END AS ttl
      FROM expensesSection
      ),

      exp_TotalNonPersonellExpenseLessFlexLines as (
      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '46D' as line,
      'TOTAL NON PERS EXP LESS FLEX LINES' as description,
      expensesSection.fiscal_year_month,
      CASE WHEN
      line in
      ('31', '32', '33', '34', '35', '36', '37', '38', '39'
      '3B', '3D', '3E', '3F', '3G', '3H', '3I', '3J', '3K', '3L', '3M'
      '3U', '44', '45', '46' )THEN ttl
      ELSE 0
      END AS ttl
      FROM expensesSection
      ),

      exp_TotalOperatingExpense as (
      SELECT
      exp_totalSalBenPlusFlex.fiscal_year,
      exp_totalSalBenPlusFlex.pricing_group_number,
      exp_totalSalBenPlusFlex.finance_number,
      exp_totalSalBenPlusFlex.area_region_code,
      exp_totalSalBenPlusFlex.function_distribution_code,
      exp_totalSalBenPlusFlex.district_division_code,
      'nil' as function_code,
      '46F' as line,
      'TOTAL OPERATING EXPENSE (TOE)' as description,
      exp_totalSalBenPlusFlex.fiscal_year_month,
      exp_totalSalBenPlusFlex.ttl
      FROM exp_totalSalBenPlusFlex
      UNION ALL
      SELECT
      exp_TotalNonPersonellExpense.fiscal_year,
      exp_TotalNonPersonellExpense.pricing_group_number,
      exp_TotalNonPersonellExpense.finance_number,
      exp_TotalNonPersonellExpense.area_region_code,
      exp_TotalNonPersonellExpense.function_distribution_code,
      exp_TotalNonPersonellExpense.district_division_code,
      'nil' as function_code,
      '46F' as line,
      'TOTAL OPERATING EXPENSE (TOE)' as description,
      exp_TotalNonPersonellExpense.fiscal_year_month,
      exp_TotalNonPersonellExpense.ttl
      FROM exp_TotalNonPersonellExpense
      UNION ALL
      SELECT
      exp_TotalOtherPersonellComp.fiscal_year,
      exp_TotalOtherPersonellComp.pricing_group_number,
      exp_TotalOtherPersonellComp.finance_number,
      exp_TotalOtherPersonellComp.area_region_code,
      exp_TotalOtherPersonellComp.function_distribution_code,
      exp_TotalOtherPersonellComp.district_division_code,
      'nil' as function_code,
      '46F' as line,
      'TOTAL OPERATING EXPENSE (TOE)' as description,
      exp_TotalOtherPersonellComp.fiscal_year_month,
      exp_TotalOtherPersonellComp.ttl
      FROM exp_TotalOtherPersonellComp
      ),

      exp_TotalAllExpense as (
      SELECT
      expensesSection.fiscal_year,
      expensesSection.pricing_group_number,
      expensesSection.finance_number,
      expensesSection.area_region_code,
      expensesSection.function_distribution_code,
      expensesSection.district_division_code,
      'nil' as function_code,
      '5CA' as line,
      'TOTAL ALL EXPENSE (TAE)' as description,
      expensesSection.fiscal_year_month,
      CASE WHEN
      expensesSection.line in ('5C') THEN expensesSection.ttl
      ELSE 0
      END  AS ttl
      FROM expensesSection
      UNION ALL
      select
      exp_TotalOperatingExpense.fiscal_year,
      exp_TotalOperatingExpense.pricing_group_number,
      exp_TotalOperatingExpense.finance_number,
      exp_TotalOperatingExpense.area_region_code,
      exp_TotalOperatingExpense.function_distribution_code,
      exp_TotalOperatingExpense.district_division_code,
      'nil' as function_code,
      '5CA' as line,
      'TOTAL ALL EXPENSE (TAE)' as description,
      exp_TotalOperatingExpense.fiscal_year_month,
      exp_TotalOperatingExpense.ttl
      from exp_TotalOperatingExpense

      ),

      exp_NetIncome as(
      select
      exp_TotalAllExpense.fiscal_year,
      exp_TotalAllExpense.pricing_group_number,
      exp_TotalAllExpense.finance_number,
      exp_TotalAllExpense.area_region_code,
      exp_TotalAllExpense.function_distribution_code,
      exp_TotalAllExpense.district_division_code,
      'nil' as function_code,
      '5CB' as line,
      'NET INCOME' as description,
      exp_TotalAllExpense.fiscal_year_month,
      SUM(exp_TotalAllExpense.ttl) * -1
      from exp_TotalAllExpense
      group by 1,2,3,4,5,6,7,8,9,10
      UNION ALL
      SELECT
      rev_totalAllRevenue.fiscal_year,
      rev_totalAllRevenue.pricing_group_number,
      rev_totalAllRevenue.finance_number,
      rev_totalAllRevenue.area_region_code,
      rev_totalAllRevenue.function_distribution_code,
      rev_totalAllRevenue.district_division_code,
      'nil' as function_code,
      '5CB' as line,
      'NET INCOME' as description,
      rev_totalAllRevenue.fiscal_year_month,
      SUM(rev_totalAllRevenue.ttl)
      from rev_totalAllRevenue
      group by 1,2,3,4,5,6,7,8,9,10
      ),

      ------------------------------------ START ALL UP SECTION
      allUp AS (
      SELECT *
      FROM revenueSection
      WHERE line IS NOT NULL
      UNION ALL


      select * from rev_totalCommercialRevenue
      WHERE line IS NOT NULL
      UNION ALL

      select * from rev_subtotalRetailUnitSales
      WHERE line is not null
      union all

      select * from rev_totalRetailRev
      where line is not null
      union all

      select * from rev_totalAllRevenue
      where line is not null
      union all


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

      UNION ALL

      SELECT * FROM expensesSection
      WHERE line is not null

      union all
      select * from exp_totalSalBenPlusFlex
      where line is not null

      union all
      select * from exp_TotalOtherPersonellComp
      where line is not null

      union all
      select * from exp_TotalPersonellComp
      where line is not null

      union all
      select * from exp_SubtotalSupliesAndServices
      where line is not null

      union all
      select * from exp_SubtotalOtherExpenses
      where line is not null

      union all
      select * from exp_SubtotalTransporationExpenses
      where line is not null

      union all
      select * from exp_SubtotalMiscExpense
      where line is not null

      union all
      select * from exp_TotalNonPersonellExpense
      where line is not null


      union all
      select * from exp_TotalNonPersonellExpenseLessTransp
      where line is not null

      union all
      select * from exp_TotalNonPersonellExpenseLessFlexLines
      where line is not null

      union all
      select * from exp_TotalOperatingExpense
      where line is not null

      union all
      select * from exp_TotalAllExpense
      where line is not null

      union all
      select * from exp_NetIncome
      where line is not null


      )
      SELECT
      *,
      CASE
      WHEN line = '10' AND description = 'DOLLARS' THEN 'OPERATIONS SUPPORT (F0)'
      WHEN line = '10' AND description = 'WORK HOURS' THEN '    F0 WORK HOURS'
      WHEN line = '11' AND description = 'DOLLARS' THEN 'PACKAGE PROCESSING (F1)'
      WHEN line = '11' AND description = 'WORK HOURS' THEN '    F1 WORK HOURS'
      WHEN line = '12' and description = 'DOLLARS' THEN 'EXTENDED DISPATCH(F2A)'
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

      WHEN line = '22' AND description = 'DOLLARS' THEN 'LOCAL DISPATCH (F2B)'
      WHEN line = '22' AND description = 'WORK HOURS' THEN '    F2B WORK HOURS'

      WHEN line = '23' AND description = 'DOLLARS' THEN'PLANT & EQUIP MAINT (F3B)'
      WHEN line = '23' and description = 'WORK HOURS' THEN '    F3B WORK HOURS'
      WHEN line = '24' AND description = 'TOTAL DOLLARS' THEN 'TOTAL SALARIES & BENEFITS'
      WHEN line = '25' and description = 'TOTAL WORK HOURS' THEN 'TOTAL WORK HOURS'
      WHEN line = '26' and description = 'WORK HOUR RATE' THEN 'WORK HOUR RATE'
      ELSE description
      END AS BoprReportDescription
      ,
      CASE
      WHEN description = 'TOTAL COMMERCIAL REVENUE' THEN '**'
      WHEN description = 'SUBTOTAL SHIPPING UNIT SALES' THEN '**'
      WHEN description = 'TOTAL SHIPPING REVENUE' THEN '**'
      WHEN description = 'TOTAL ALL REVENUE' THEN '**'

      WHEN description = 'TOTAL DOLLARS' THEN '**'
      WHEN description = 'TOTAL WORK HOURS' THEN '**'
      WHEN description = 'WORK HOUR RATE' THEN '**'

      when description = 'TOTAL SAL & BEN + FLEX' then '**'
      when description = 'TOTAL OTHER PERSONELL COMP' then '**'
      when description = 'TOTAL PERSONELL COMP' then '**'
      when description = 'SUBTOTAL SUPPLIES & SVCS' then '**'
      when description = 'SUBTOTAL OTHER EXPENSES' then '**'
      when description = 'SUBTOTAL TRANSP EXPENSES' then '**'
      when description = 'SUBTOTAL MISC EXPENSES' then '**'
      when description = 'TOTAL NON-PERSONNEL EXPENSE' then '**'
      when description = 'TOTAL NON PERS EXP LESS TRANSP' then '**'
      when description = 'TOTAL NON PERS EXP LESS FLEX LINES' then '**'
      when description = 'TOTAL OPERATING EXPENSE (TOE)' then '**'
      when description = 'TOTAL ALL EXPENSE (TAE)' then '**'
      when description = 'NET INCOME' then '**'

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


  dimension: LineNumberLabel {
    label: "Line No."
    type: string
    sql: ${TABLE}.BoprReportLineNumberLabel ;;
  }

  dimension: Description {
    label: "Line Description "
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
    value_format: "0.000,,\" M\""
    ##value_format: "[<=100]$0.00;#,##0"
    # value_format: "#,##0"


  }

  measure: sum_dollars{
    type: sum
    sql: ${TABLE}.ttl/100 ;;
    value_format: "$0.000,,\" M\""

  }

  measure: Total_revenue {
    type: sum
    sql: CASE
        WHEN ${TABLE}.description = 'TOTAL ALL REVENUE' THEN sum(${TABLE}.ttl)
    END ;;
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
