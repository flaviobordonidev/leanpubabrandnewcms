class User < ApplicationRecord
  scope :active, -> { where(active: true) }

  scope :older_than, ->(age) { where("age > ?", age) }

  scope :younger_than_thirty, -> { where("age < 30") } # rails c -> User.younger_than_thirty.first
  scope :younger_than, ->(age) { where("age < ?", age) } # rails c -> User.younger_than(30).first

  scope :age_between_25_30, -> { where(age: 25..30 ) }
  scope :age_between, ->(start, final) { where("age >= ? AND age <= ?", start, final)} # rails c -> User.age_between(25, 30)
  scope :age_between_v2, ->(start, final) { where("age BETWEEN ? AND ?", start, final)} # rails c -> User.age_between(25, 30)

  scope :created_at_test1, -> { where("created_at <= ?", Time.current) }
  scope :created_at_test2, -> { where("created_at <= '2022-06-16 05:53:45.789268'") }
  scope :created_at_test3, -> { where("created_at <= '2022-06-16'") }

  scope :created_at_2022, -> { where(created_at: Date.new(2022, 1, 1)...Date.new(2023, 1, 1)) }
  scope :created_at_2022_v2, -> { where("created_at >= '#{Date.new(2022, 1, 1)}' AND created_at < '#{Date.new(2023, 1, 1)}'") }
  scope :created_at_2022_v3, -> { where(created_at: Date.new(2022, 1, 1)..Date.new(2022, 12, 31)) }
  scope :created_at_2022_v4, -> { where("created_at >= '#{Date.new(2022, 1, 1)}' AND created_at <= '#{Date.new(2022, 12, 31)}'") }
  scope :created_at_2022_v5, -> { where("created_at >= '2022-01-01' AND created_at <= '2022-12-31'") }
  scope :created_at_2022_v6, ->(year) { where("created_at >= '?-01-01' AND created_at <= '?-12-31'", year, year) } # rails c -> User.created_at_2022_v6(2022)

  scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01' AND created_at <= '2022-12-31'") } 
  scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01' AND created_at <= '?-12-31'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)

  # rails c -> User.age_between_20_45.happy
  scope :age_between_20_45, -> { where(age: 20..45 ) }
  scope :happy, -> { where(happy: true) }

  scope :happy_age_20_45, -> {where("happy = true AND age BETWEEN 20 AND 45")}
  scope :happy_age, ->(start, final) {where("happy = true AND age BETWEEN ? AND ?", start, final)} # rails c -> User.happy_age(20, 45)
end
