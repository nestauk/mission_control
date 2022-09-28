class Capacity
  attr_reader :weeks, :by_person

  def initialize(q_params)
    return unless q_params

    @data = ActiveRecord::Base.connection.execute(
      "SELECT date_trunc('week', p.week)::date AS week_of, people.slug, m.id, m.avg_time_per_week, p.title, p.public_uid
      FROM (
        SELECT * FROM projects, generate_series(start_date, end_date, '1 week') AS week
        WHERE status IN (#{validate_param(q_params, :status_in, '0, 1, 2, 3')})
      ) AS p
      JOIN memberships AS m ON m.memberable_id=p.id AND memberable_type='Project'
      JOIN people ON people.id = m.contact_id
      WHERE m.contact_id IN (#{validate_param(q_params, :memberships_contact_id_in)})"
      )
      .group_by_week(week_start: :monday, series: true) { |a| a["week_of"].to_datetime }

    @weeks = []
    @people = Set.new
    @by_person = {}

    generate_weeks_and_people
    generate_by_person_data
  end

  private

  def generate_weeks_and_people
    @data.each do |date, array|
      @weeks << date
      array.each { |h| @people << h['slug'] }
    end
  end

  def generate_by_person_data
    @people.sort.each do |person|
      @weeks.each do |week|
        @by_person[person] = [] unless @by_person[person]
        @by_person[person] << @data[week]
      end
    end
  end

  def validate_param(params, param, empty_val = "null")
    values = params[param].reject(&:empty?)
    values.empty? ? empty_val : values.join(', ')
  end
end
