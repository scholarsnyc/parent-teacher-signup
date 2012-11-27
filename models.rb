DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}signups.db")

class Appointment
  include DataMapper::Resource

  property :id, Serial
  property :student, String
  property :homeroom, String
  property :grade, Integer
  property :parent, String
  property :email, String
  
  belongs_to :slot
end

class Slot
  include DataMapper::Resource

  property :id, Serial
  property :day, String, :required => true
  property :time, String, :required => true
  property :capacity, Integer, :default => 7
  property :grade, Integer
  property :cohort, String
  
  has n, :appointments
  
  TIMEFRAMES = [
    "2:00-2:30pm",
    "2:31-3:00pm",
    "3:01-3:30pm",
    "3:30-4:00pm",
    "5:00-5:30pm",
    "5:31-6:00pm",
    "6:01-6:30pm",
    "6:31-7:00pm",
    "7:01-7:30pm"
  ]
  
  def self.batch_create(weekday, timeframe)
    6.upto(7).each do |g|
      Slot.create day: weekday, time: timeframe, capacity: 7, grade: g, cohort: "A"
      Slot.create day: weekday, time: timeframe, capacity: 7, grade: g, cohort: "B"
      Slot.create day: weekday, time: timeframe, capacity: 7, grade: g, cohort: "C"
    end
    Slot.create day: weekday, time: timeframe, capacity: 7, grade: 8, cohort: "A"
    Slot.create day: weekday, time: timeframe, capacity: 7, grade: 8, cohort: "B"
    Slot.create day: weekday, time: timeframe, capacity: 8, grade: 9
    Slot.create day: weekday, time: timeframe, capacity: 8, grade: 10
    Slot.create day: weekday, time: timeframe, capacity: 8, grade: 11
    Slot.create day: weekday, time: timeframe, capacity: 8, grade: 12
  end
  
  def self.populate!
    TIMEFRAMES.each do |t|
      self.batch_create("Thursday", t)
    end
  end
  
  def name
    "#{day}, #{time}"
  end
  
  def remaining
    capacity - appointments.count
  end
  
end

DataMapper.finalize
DataMapper.auto_upgrade!