
locals {
  default_params = {
    binlog_checksum                                            = "NONE"
    binlog_format                                              = "ROW"
    binlog_transaction_dependency_tracking                     = "WRITESET"
    character_set_server                                       = "utf8"
    collation_server                                           = "utf8_general_ci"
    connect_timeout                                            = 10
    enforce_gtid_consistency                                   = "ON"
    gtid-mode                                                  = "ON"
    innodb_autoextend_increment                                = 100
    innodb_checksum_algorithm                                  = "innodb"
    innodb_commit_concurrency                                  = 0
    innodb_flush_neighbors                                     = 0
    innodb_io_capacity_max                                     = 2000
    innodb_log_buffer_size                                     = 104857600
    innodb_stats_transient_sample_pages                        = 32
    innodb_thread_concurrency                                  = 0
    interactive_timeout                                        = 1000
    log_bin_trust_function_creators                            = 1
    log_error_verbosity                                        = 3
    log_output                                                 = "FILE"
    long_query_time                                            = 2
    max_allowed_packet                                         = 1073741824
    max_connect_errors                                         = 100
    max_execution_time                                         = 86400000
    max_heap_table_size                                        = 268435456
    optimizer_search_depth                                     = 0
    performance_schema                                         = 1
    slave_parallel_type                                        = "LOGICAL_CLOCK"
    slave_preserve_commit_order                                = 1
    slow_query_log                                             = 1
    sync_binlog                                                = 1
    table_definition_cache                                     = 15740
    table_open_cache                                           = 15740
    thread_cache_size                                          = 64
    tmp_table_size                                             = "268435456"
    wait_timeout                                               = 1000
  }

  aurora_cluster_params = {
    binlog_checksum                        = "NONE"
    binlog_format                          = "ROW"
    binlog_transaction_dependency_tracking = "WRITESET"
    character_set_server                   = "utf8"
    collation_server                       = "utf8_general_ci"
    connect_timeout                        = 10
    enforce_gtid_consistency               = "ON"
    gtid-mode                              = "ON"
    innodb_autoextend_increment            = 100
    innodb_commit_concurrency              = 0
    innodb_stats_transient_sample_pages    = 32
    interactive_timeout                    = 1000
    log_bin_trust_function_creators        = 1
    log_error_verbosity                    = 3
    log_output                             = "FILE"
    long_query_time                        = 2
    max_allowed_packet                     = 1073741824
    max_connect_errors                     = 100
    max_execution_time                     = 86400000
    max_heap_table_size                    = 268435456
    optimizer_search_depth                 = 0
    slow_query_log                         = 1
    table_definition_cache                 = 15740
    table_open_cache                       = 15740
    thread_cache_size                      = 64
    tmp_table_size                         = "268435456"
    wait_timeout                           = 1000
  }

  replica_overrides = {
    read_only                      = 1
    innodb_flush_log_at_trx_commit = 2
  }

  aurora_params = {
    connect_timeout                                            = 10
    interactive_timeout                                        = 1000
    log_bin_trust_function_creators                            = 1
    log_error_verbosity                                        = 3
    log_output                                                 = "FILE"
    long_query_time                                            = 2
    max_allowed_packet                                         = 1073741824
    max_connect_errors                                         = 100
    max_execution_time                                         = 86400000
    max_heap_table_size                                        = 268435456
    optimizer_search_depth                                     = 0
    performance_schema                                         = 1
    slow_query_log                                             = 1
    table_definition_cache                                     = 15740
    table_open_cache                                           = 15740
    thread_cache_size                                          = 64
    tmp_table_size                                             = "268435456"
    wait_timeout                                               = 1000
    performance_schema                                         = 1
    performance_schema_consumer_events_statements_current      = 1
    performance_schema_consumer_events_statements_history      = 1
    performance_schema_consumer_events_statements_history_long = 1
    performance_schema_consumer_events_waits_history           = 1
    performance_schema_consumer_events_waits_history_long      = 1
    performance-schema-consumer-events-waits-current           = "ON"
    performance_schema_max_digest_length                       = 4096
    performance_schema_max_sql_text_length                     = 4096
  }

  env_overrides = {
    qa = {
      innodb_read_io_threads  = 4
      innodb_write_io_threads = 4
      join_buffer_size        = 2097152
      slave_parallel_workers  = 8
      sort_buffer_size        = 2097152
      time_zone               = "US/Central"
    }

    uat = {
      innodb_read_io_threads  = 4
      innodb_write_io_threads = 4
      join_buffer_size        = 2097152
      slave_parallel_workers  = 8
      sort_buffer_size        = 2097152
      time_zone               = "US/Central"

      # UAT-only override by Pythian for it to stop paging.
      max_connections = 1700
    }
    prod = {
      innodb_read_io_threads  = 16
      innodb_write_io_threads = 16
      join_buffer_size        = 4194304
      slave_parallel_workers  = 16
      sort_buffer_size        = 5242880
      time_zone               = "US/Eastern"
    }
  }

  aurora_cluster_env_overrides = {
    qa = {
      join_buffer_size = 2097152
      sort_buffer_size = 2097152
      time_zone        = "US/Central"
    }

    uat = {
      join_buffer_size = 2097152
      sort_buffer_size = 2097152
      time_zone        = "US/Central"

      # UAT-only override by Pythian for it to stop paging.
      max_connections = 1700
    }
    prod = {
      join_buffer_size = 4194304
      sort_buffer_size = 5242880
      time_zone        = "US/Eastern"
    }
  }

  aurora_env_overrides = {
    qa = {
      join_buffer_size = 2097152
      sort_buffer_size = 2097152
    }

    uat = {
      join_buffer_size = 2097152
      sort_buffer_size = 2097152

      # UAT-only override by Pythian for it to stop paging.
      max_connections = 1700
    }
    prod = {
      join_buffer_size = 4194304
      sort_buffer_size = 5242880
    }
  }

  pending_reboot_parameters = [
    "collation_server",
    "enforce_gtid_consistency",
    "gtid-mode",
    "innodb_commit_concurrency",
    "innodb_read_io_threads",
    "innodb_write_io_threads",
    "performance_schema",
    "slave_parallel_type",
    "sync_binlog",
    "table_definition_cache",
  ]

  aurora_pending_reboot_parameters = [
    "binlog_format",
    "collation_server",
    "enforce_gtid_consistency",
    "gtid-mode",
    "innodb_commit_concurrency",
    "innodb_read_io_threads",
    "innodb_write_io_threads",
    "performance_schema",
    "slave_parallel_type",
    "sync_binlog",
    "table_definition_cache",
  ]

  primary_parameters        = merge(local.default_params, local.env_overrides[var.environment])
  replica_parameters        = merge(local.default_params, local.env_overrides[var.environment], local.replica_overrides)
  aurora_parameters         = merge(local.aurora_params, local.aurora_env_overrides[var.environment])
  aurora_cluster_parameters = merge(local.aurora_cluster_params, local.aurora_cluster_env_overrides[var.environment])
}


resource "aws_db_parameter_group" "aurora" {
  name   = "mysql-aurora-${var.environment}"
  family = "aurora-mysql8.0"

  dynamic "parameter" {
    for_each = { for k, v in local.aurora_parameters : k => v if v != null }
    content {
      apply_method = contains(local.pending_reboot_parameters, parameter.key) ? "pending-reboot" : null
      name         = parameter.key
      value        = parameter.value
    }
  }

  lifecycle {
    ignore_changes = [description]
  }
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_parameters" {
  name        = "mysql-aurora-cluster-${var.environment}"
  family      = "aurora-mysql8.0"
  description = "RDS aurora cluster parameter group"

  dynamic "parameter" {
    for_each = { for k, v in local.aurora_cluster_parameters : k => v if v != null }
    content {
      apply_method = contains(local.aurora_pending_reboot_parameters, parameter.key) ? "pending-reboot" : null
      name         = parameter.key
      value        = parameter.value
    }
  }

  lifecycle {
    ignore_changes = [description]
  }
}
