---
- dashboard: large_logistics_agency__budget_planning_demo_
  title: 'Large Logistics Agency : Budget Planning Demo '
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: nLKV3XJPoFr7D4jECLJzM1
  elements:
  - title: Budget Report Detail
    name: Budget Report Detail
    model: usps_ibps
    explore: bopr_paul
    type: table
    fields: [bopr_paul.BoprReportDescription, bopr_paul.line, bopr_paul.fiscal_year_month,
      bopr_paul.ttl, bopr_paul.description, bopr_paul.BoprReportLineNumberLabel]
    pivots: [bopr_paul.fiscal_year_month]
    filters:
      bopr_paul.BoprReportDescription: "-NULL"
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
      Area Region Code: bopr_paul.area_region_code
      District Division Code: bopr_paul.district_division_code
      Pricing Group Number: bopr_paul.pricing_group_number
      Function Distribution Code: bopr_paul.function_distribution_code
      Finance Number: bopr_paul.finance_number
    row: 15
    col: 0
    width: 24
    height: 13
  - title: Total Budget Alloted
    name: Total Budget Alloted
    model: usps_ibps
    explore: pricing_plan_paul
    type: single_value
    fields: [pricing_plan_paul.sum_of_dollars, pricing_plan_paul.sum_of_planhours]
    sorts: [pricing_plan_paul.sum_of_dollars desc]
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
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: pricing_plan_paul.sum_of_dollars,
            id: pricing_plan_paul.sum_of_dollars, name: Sum of Dollars}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    label_color: [black]
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    advanced_vis_config: "{chart: { legend: { enabled: true, align: 'center', verticalAlign:\
      \ 'bottom', }, }, series: [], }"
    value_labels: legend
    label_type: labPer
    up_color: "#7CB342"
    down_color: "#EA4335"
    total_color: "#1A73E8"
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    hidden_fields: [pricing_plan_paul.sum_of_planhours]
    hidden_pivots: {}
    listen: {}
    row: 0
    col: 0
    width: 7
    height: 3
  - title: Work Hours Over Time
    name: Work Hours Over Time
    model: usps_ibps
    explore: work_plan_paul
    type: looker_column
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Month of Workhour, orientation: left, series: [{axisId: F0 -
              work_plan_paul.total_plan_hours, id: F0 - work_plan_paul.total_plan_hours,
            name: F0}, {axisId: F1 - work_plan_paul.total_plan_hours, id: F1 - work_plan_paul.total_plan_hours,
            name: F1}, {axisId: F2A - work_plan_paul.total_plan_hours, id: F2A - work_plan_paul.total_plan_hours,
            name: F2A}, {axisId: F2B - work_plan_paul.total_plan_hours, id: F2B -
              work_plan_paul.total_plan_hours, name: F2B}, {axisId: F3A - work_plan_paul.total_plan_hours,
            id: F3A - work_plan_paul.total_plan_hours, name: F3A}, {axisId: F3B -
              work_plan_paul.total_plan_hours, id: F3B - work_plan_paul.total_plan_hours,
            name: F3B}, {axisId: F4 - work_plan_paul.total_plan_hours, id: F4 - work_plan_paul.total_plan_hours,
            name: F4}, {axisId: F5 - work_plan_paul.total_plan_hours, id: F5 - work_plan_paul.total_plan_hours,
            name: F5}, {axisId: F6 - work_plan_paul.total_plan_hours, id: F6 - work_plan_paul.total_plan_hours,
            name: F6}, {axisId: F7 - work_plan_paul.total_plan_hours, id: F7 - work_plan_paul.total_plan_hours,
            name: F7}, {axisId: F8 - work_plan_paul.total_plan_hours, id: F8 - work_plan_paul.total_plan_hours,
            name: F8}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: ''
    x_axis_datetime_label: "%m-%y"
    show_null_points: false
    interpolation: linear
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
    row: 8
    col: 0
    width: 17
    height: 7
  - title: Budget allocation by Business Function
    name: Budget allocation by Business Function
    model: usps_ibps
    explore: pricing_plan_paul
    type: looker_pie
    fields: [pricing_plan_paul.sum_of_dollars, pricing_plan_paul.sum_of_planhours,
      pricing_plan_paul.function_name]
    sorts: [pricing_plan_paul.sum_of_dollars desc]
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
    value_labels: legend
    label_type: labPer
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: pricing_plan_paul.sum_of_dollars,
            id: pricing_plan_paul.sum_of_dollars, name: Sum of Dollars}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    label_color: [black]
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    advanced_vis_config: "{chart: { legend: { enabled: true, align: 'center', verticalAlign:\
      \ 'bottom', }, }, series: [], }"
    up_color: "#7CB342"
    down_color: "#EA4335"
    total_color: "#1A73E8"
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    hidden_fields: [pricing_plan_paul.sum_of_planhours]
    hidden_pivots: {}
    listen: {}
    row: 0
    col: 7
    width: 17
    height: 8
  - title: Total Revenue
    name: Total Revenue
    model: usps_ibps
    explore: bopr_paul
    type: single_value
    fields: [bopr_paul.sum_dollars]
    filters:
      bopr_paul.BoprReportDescription: TOTAL ALL REVENUE
    sorts: [bopr_paul.sum_dollars desc 0]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Finance Number: bopr_paul.finance_number
      Function Distribution Code: bopr_paul.function_distribution_code
      Area Region Code: bopr_paul.area_region_code
      Pricing Group Number: bopr_paul.pricing_group_number
      District Division Code: bopr_paul.district_division_code
    row: 3
    col: 0
    width: 7
    height: 3
  - title: Worker Plan Hours by Business Function
    name: Worker Plan Hours by Business Function
    model: usps_ibps
    explore: work_plan_paul
    type: looker_grid
    fields: [work_plan_paul.total_plan_hours, work_plan_paul.function_code, work_plan_paul.function_name]
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
    sorts: [work_plan_paul.function_code, work_plan_paul.total_plan_hours desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
    show_sql_query_menu_options: false
    column_order: []
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_column_widths:
      work_plan_paul.function_code: 121
      work_plan_paul.function_name: 305
    series_cell_visualizations:
      sum_of_plan_hours:
        is_active: true
      work_plan_paul.total_plan_hours:
        is_active: false
    series_text_format:
      work_plan_paul.function_name:
        align: left
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: b6d19921-b2be-4bb1-88be-73eb21d3861e, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    hidden_pivots: {}
    defaults_version: 1
    truncate_column_names: false
    hidden_fields: [work_plan_paul.function_code]
    listen: {}
    row: 8
    col: 17
    width: 7
    height: 7
  - title: Total Worker Hours
    name: Total Worker Hours
    model: usps_ibps
    explore: work_plan_paul
    type: single_value
    fields: [work_plan_paul.total_plan_hours]
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
    sorts: [work_plan_paul.total_plan_hours desc]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    column_order: []
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      sum_of_plan_hours:
        is_active: true
      work_plan_paul.total_plan_hours:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    hidden_pivots: {}
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 6
    col: 0
    width: 7
    height: 2
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
  - name: Finance Line Item- Filter
    title: Finance Line Item- Filter
    type: field_filter
    default_value: "-NULL"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: usps_ibps
    explore: bopr_paul
    listens_to_filters: []
    field: bopr_paul.BoprReportDescription
