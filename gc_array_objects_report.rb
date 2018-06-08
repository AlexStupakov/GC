t = Time.now
GC::Profiler.enable
arr = []
100000000.times do
  arr << Object.new
end
GC::Profiler.report
puts Time.now - t
