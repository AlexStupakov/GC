t = Time.now
GC::Profiler.enable
100000000.times do
  obj = Object.new
end
GC::Profiler.report
puts Time.now - t
