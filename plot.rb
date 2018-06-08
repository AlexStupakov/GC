require 'gnuplot'
require 'csv'

filename = './tmp/r193array_objects.csv'
csv_contents = CSV.read(filename, :col_sep => ' ')
csv_contents.shift

stat = {}
times = []
sizes = []
csv_contents.each do |row|
  next if row[5].nil?
  times << row[5].to_s
  sizes << row[3]
end
p times
p sizes

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
    plot.terminal "png"
    plot.output filename.sub(/csv$/,'png')
  
    plot.title  "The time and the heap size."
    plot.xlabel "CG Time in milliseconds"
    plot.ylabel "Total Heap Size (MB)"

    plot.data << Gnuplot::DataSet.new( [sizes] ) do |ds|
      ds.with = "linespoints"
      ds.linewidth = 4
      ds.title = File.basename(filename, ".*")
    end
  end
  
end
