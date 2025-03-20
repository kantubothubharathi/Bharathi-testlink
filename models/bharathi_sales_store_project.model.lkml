connection: "bharathi_sales_store_connection"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: bharathi_sales_store_project_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: bharathi_sales_store_project_default_datagroup

explore: bharathi_sales_table {}

