---
- dashboard: large_logistics_agency__budget_planning_demo
  title: Large Logistics Agency - Budget Planning Demo
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: Axwmlhr55iqVLLrv7ZvJW2
  elements:
  - title: IBPS BOPR DEMO
    name: IBPS BOPR DEMO
    model: usps_ibps
    explore: bopr_paul
    type: table
    fields: [bopr_paul.BoprReportDescription, bopr_paul.line, bopr_paul.fiscal_year_month,
      bopr_paul.ttl, bopr_paul.description, bopr_paul.BoprReportLineNumberLabel]
    pivots: [bopr_paul.fiscal_year_month]
    filters: {}
    sorts: [bopr_paul.fiscal_year_month, bopr_paul.line, bopr_paul.description]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: round(sum(pivot_row(${bopr_paul.ttl})), 0)
      label: Total Line Value
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      table_calculation: total_line_value
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [bopr_paul.description, bopr_paul.line]
    listen:
      BoprReportDescription: bopr_paul.BoprReportDescription
      Area Region Code: bopr_paul.area_region_code
      District Division Code: bopr_paul.district_division_code
      Pricing Group Number: bopr_paul.pricing_group_number
      Function Distribution Code: bopr_paul.function_distribution_code
      Finance Number: bopr_paul.finance_number
    row: 0
    col: 0
    width: 24
    height: 13
  - title: Work Hours by Function
    name: Work Hours by Function
    model: usps_ibps
    explore: pricing_plan_paul
    type: looker_grid
    fields: [sum_of_dollars, sum_of_plan_hours, pricing_plan_paul.function_code, pricing_plan_paul.function_name]
    sorts: [sum_of_dollars desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - measure: sum_of_dollars
      based_on: pricing_plan_paul.dollars
      expression: ''
      label: Sum of Dollars
      type: sum
      _kind_hint: measure
      _type_hint: number
    - measure: sum_of_plan_hours
      based_on: pricing_plan_paul.plan_hours
      expression: ''
      label: Sum of Plan Hours
      type: sum
      _kind_hint: measure
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 13
    col: 0
    width: 10
    height: 8
  - title: Work Hours Over Time
    name: Work Hours Over Time
    model: usps_ibps
    explore: work_plan_paul
    type: looker_area
    fields: [work_plan_paul.total_plan_hours, work_plan_paul.function_code, work_plan_paul.first_day_of_split_week_month]
    pivots: [work_plan_paul.function_code]
    fill_fields: [work_plan_paul.first_day_of_split_week_month]
    filters:
      work_plan_paul.area_region_name: ''
      work_plan_paul.district_division_name: ''
      work_plan_paul.pricing_group_number: ''
      work_plan_paul.finance_number: ''
      work_plan_paul.finance_number_type: ''
      work_plan_paul.finance_number_name: ''
      work_plan_paul.district_division_code: ''
      work_plan_paul.lead_finance_number: ''
      work_plan_paul.area_region_code: ''
    sorts: [work_plan_paul.function_code, work_plan_paul.total_plan_hours desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: []
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      sum_of_plan_hours:
        is_active: true
    hidden_pivots: {}
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 13
    col: 10
    width: 14
    height: 8
  filters:
  - name: Area Region Code
    title: Area Region Code
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: usps_ibps
    explore: bopr_paul
    listens_to_filters: []
    field: bopr_paul.area_region_code
  - name: District Division Code
    title: District Division Code
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: usps_ibps
    explore: bopr_paul
    listens_to_filters: []
    field: bopr_paul.district_division_code
  - name: Function Distribution Code
    title: Function Distribution Code
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: usps_ibps
    explore: bopr_paul
    listens_to_filters: []
    field: bopr_paul.function_distribution_code
  - name: Pricing Group Number
    title: Pricing Group Number
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: usps_ibps
    explore: bopr_paul
    listens_to_filters: []
    field: bopr_paul.pricing_group_number
  - name: Finance Number
    title: Finance Number
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: usps_ibps
    explore: bopr_paul
    listens_to_filters: []
    field: bopr_paul.finance_number
  - name: BoprReportDescription
    title: BoprReportDescription
    type: field_filter
    default_value: "-NULL"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: usps_ibps
    explore: bopr_paul
    listens_to_filters: []
    field: bopr_paul.BoprReportDescription
