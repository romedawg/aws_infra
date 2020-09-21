resource "pagerduty_schedule" "shared_services_stack_schedule_v2" {
  name        = "Shared Services Stack Schedule Chicago/Bratislava"
  time_zone   = "America/Chicago"
  description = ""

  layer {
    # Whole weekend is scheduled at once to not break it up.
    name                   = "Layer 1"
    start                  = "2020-05-01T22:00:00-05:00"
    rotation_virtual_start = "2020-05-01T22:00:00-05:00"
    # Rotation takes one week - it is then restricted to just a weekend.
    rotation_turn_length_seconds = 7 * 86400
    users = [
      "${module.rrafacz.id}",
    ]
    restriction {
      # Weekend shift follows Chicago Friday shift, starts at 22:00 Friday of Chicago time.
      # That way, weekend shifts can end by the time Bratislava gets Monday morning shift.
      type              = "weekly_restriction"
      start_day_of_week = 5
      start_time_of_day = "22:00:00"
      duration_seconds  = 2 * 86400
    }
  }
  layer {
    # Chicago week-day.
    name                         = "Layer 2"
    start                        = "2020-05-01T10:00:00-05:00"
    rotation_virtual_start       = "2020-05-01T10:00:00-05:00"
    rotation_turn_length_seconds = 43200
    users = [
      "${module.rrafacz.id}",
    ]
    restriction {
      type              = "weekly_restriction"
      start_day_of_week = 1
      start_time_of_day = "10:00:00"
      duration_seconds  = 43200
    }
    restriction {
      type              = "weekly_restriction"
      start_day_of_week = 2
      start_time_of_day = "10:00:00"
      duration_seconds  = 43200
    }
    restriction {
      type              = "weekly_restriction"
      start_day_of_week = 3
      start_time_of_day = "10:00:00"
      duration_seconds  = 43200
    }
    restriction {
      type              = "weekly_restriction"
      start_day_of_week = 4
      start_time_of_day = "10:00:00"
      duration_seconds  = 43200
    }
    restriction {
      type              = "weekly_restriction"
      start_day_of_week = 5
      start_time_of_day = "10:00:00"
      duration_seconds  = 43200
    }
  }
  layer {
    # Bratislava week-day.
    name                         = "Layer 3"
    start                        = "2020-05-01T22:00:00-05:00"
    rotation_virtual_start       = "2020-05-01T22:00:00-05:00"
    rotation_turn_length_seconds = 43200
    users = [
      "${module.rrafacz.id}",
    ]
    restriction {
      type              = "weekly_restriction"
      start_day_of_week = 1
      start_time_of_day = "22:00:00"
      duration_seconds  = 43200
    }
    restriction {
      type              = "weekly_restriction"
      start_day_of_week = 2
      start_time_of_day = "22:00:00"
      duration_seconds  = 43200
    }
    restriction {
      type              = "weekly_restriction"
      start_day_of_week = 3
      start_time_of_day = "22:00:00"
      duration_seconds  = 43200
    }
    restriction {
      type              = "weekly_restriction"
      start_day_of_week = 4
      start_time_of_day = "22:00:00"
      duration_seconds  = 43200
    }
    restriction {
      # Bratislave doesn't take shift after Chicago's Friday shift.
      # It takes the first Monday shift - it's "Sunday" in Chicago hours.
      type              = "weekly_restriction"
      start_day_of_week = 7
      start_time_of_day = "22:00:00"
      duration_seconds  = 43200
    }
  }
}
