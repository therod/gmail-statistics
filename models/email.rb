class Email < ActiveRecord::Base

  scope :year, ->(date) { where("date between ? and ?", date.to_date.beginning_of_year, date.to_date.end_of_year ) }
  scope :month, ->(date) { where("date between ? and ?", date.to_date.beginning_of_month, date.to_date.end_of_month ) }
  scope :week, ->(date) { where("date between ? and ?", date.to_date.beginning_of_week, date.to_date.end_of_week ) }

  def day
    date.strftime('%A')
  end

  def month
    date.strftime('%B')
  end

  def week
    date.strftime('%Y-%W')
  end

  def year
    date.strftime('%Y')
  end

  def self.dates
    all.map(&:date)
  end

  def self.plot_week(date)
    date = date.to_date
    g = Gruff::AccumulatorBar.new

    data = week(date).all
    grouped_data = data.group_by {|e| e.day }
    g.title = "Sent E-Mails for #{date.strftime("Week %W (%Y)")}"
    g.hide_legend = true

    # g.data 'Savings', (1..12).to_a.map { rand(100) }
    # g.labels = (0..11).to_a.inject({}) {|memo, index| {index => '12-26'}.merge(memo)}

    g.labels = {0 => 'Monday', 1 => 'Tuesday', 2 => 'Wednesday', 3 => 'Thursday', 4 => 'Friday', 5 => 'Saturday', 6 => 'Sunday' }

    g.labels.each do |label|
      count = grouped_data.select {|x| x == label[1] }[label[1]].count rescue nil
      count = 0 if count.nil?
      puts "#{label[1]} => #{count}"
      g.data label[1], count
    end

    g.theme = {
      :colors => ['#aedaa9', '#12a702'],
      :marker_color => '#dddddd',
      :font_color => 'black',
      :background_colors => 'white'
      # :background_image => File.expand_path(File.dirname(__FILE__) + "/../assets/backgrounds/43things.png")
    }

    g.marker_font_size = 18
    g.maximum_value = 1000
    g.minimum_value = 0

    g.write('output/accum_bar.png')
  end

end
