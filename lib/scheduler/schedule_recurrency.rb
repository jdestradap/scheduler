module Scheduler
  class ScheduleRecurrency
    include IceCube

    attr_accessor :start_time, :end_time, :hash

    def initialize(opts={})
      if(opts[:start_time].present? && opts[:end_time].present?)
        @start_time = opts[:start_time]
        @end_time = opts[:end_time]
      elsif(opts[:hash].present?)
        @hash = opts[:hash]
      end
    end

    def schedule_from_hash
      Schedule.from_hash(hash)
    end

    # TODO should be set the start date filled by the user, not the currend date.
    def schedule_to_hash
      schedule = Schedule.new(@start_time, end_time: @end_time)
      schedule.add_recurrence_rule(Rule.daily)
      schedule.to_hash
    end
  end
end