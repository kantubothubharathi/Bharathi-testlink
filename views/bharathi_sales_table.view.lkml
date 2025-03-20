view: bharathi_sales_table {
  sql_table_name: `bharathi_sales_dataset.bharathi_sales_table` ;;

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }
  dimension: customer_id {
    type: string
    sql: ${TABLE}.`Customer ID` ;;
  }
  dimension: customer_name {
    type: string
    sql: ${TABLE}.`Customer Name` ;;
  }
  dimension: discount {
    type: number
    sql: ${TABLE}.Discount ;;
  }
  dimension_group: order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: Date(${TABLE}.`Order Date`) ;;
    #sql: DATE(${TABLE}.Order Date)) ;;
  }
  dimension: order_id {
    type: string
    sql: ${TABLE}.`Order ID` ;;
  }
  dimension: postal_code {
    type: number
    sql: ${TABLE}.`Postal Code` ;;
  }
  dimension: product_id {
    type: string
    sql: ${TABLE}.`Product ID` ;;
  }
  dimension: product_name {
    type: string
    sql: ${TABLE}.`Product Name` ;;
  }
  dimension: profit {
    type: number
    #sql: ${TABLE}.Profit ;;
    sql: COALESCE(${TABLE}.profit, 0) ;;
  }
  dimension: profit_ratio {
    type: number
    sql: ${profit} / ${sales} ;;
  }
  dimension: quantity {
    type: number
    sql: ${TABLE}.Quantity ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }
  dimension: row_id {
    type: number
    sql: ${TABLE}.`Row ID` ;;
  }
  dimension: sales {
    type: number
    sql: ${TABLE}.Sales ;;
  }
  dimension: segment {
    type: string
    sql: ${TABLE}.Segment ;;
  }
  dimension_group: ship {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.`Ship Date` ;;
  }
  dimension: ship_mode {
    type: string
    sql: ${TABLE}.`Ship Mode` ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }
  dimension: subcategory {
    type: string
    sql: ${TABLE}.`Sub-Category` ;;
  }
  dimension: days_to_ship {
    type: number
    sql: DATE_DIFF(${ship_date}, ${order_date},DAY) ;;
  }
  measure: clv_segment {
    type: string
    sql:
    CASE
      WHEN ${total_sales} >= 10000 THEN 'High'
      WHEN ${total_sales} BETWEEN 5000 AND 9999 THEN 'Medium'
      ELSE 'Low'
    END ;;
    description: "Segments customers based on their total sales"
  }

  measure: total_orders {
    type: count_distinct
    sql: ${order_id} ;;
  }
  measure: total_sales {
    type: sum
    sql: ${sales} ;;
  }
  measure: sales_per_customer {
    type: number
    sql: ${total_sales} / COUNT(DISTINCT ${customer_id}) ;;
  }
  measure: count {
    type: count
    drill_fields: [product_name, customer_name]
  }
}
