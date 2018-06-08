require 'gnuplot'
require 'csv'

def read_data(filename)
  filename = filename
  csv_contents = CSV.read(filename, :col_sep => ' ')
  csv_contents.shift

  times = []
  sizes = []
  csv_contents.each do |row|
    next if row[5].nil?
    times << row[5].to_s
    sizes << row[3]
  end
  p times
  p sizes
  [times,sizes]
end

def prepare_data(filename)
  Gnuplot::DataSet.new( read_data(filename) ) do |ds|
    ds.with = "lines"
    ds.linewidth = 4
    ds.title = File.basename(filename, ".*")
  end
end

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
    plot.terminal "png"
    plot.output './tmp/combined_result.png'
  
    plot.title  "The time and the heap size."
    plot.xlabel "CG Time in milliseconds"
    plot.ylabel "Total Heap Size (MB)"

    plot.data = [
                  './tmp/r193array_objects.csv',
                  './tmp/r200array_objects.csv',
                  './tmp/r210array_objects.csv',
                  './tmp/r242array_objects.csv'
                  # './tmp/r200objects.csv',
                  # './tmp/r210objects.csv',
                  # './tmp/r242objects.csv',
                  # './tmp/r193objects.csv'
                ].map{|filename| prepare_data(filename)}
  end
end
