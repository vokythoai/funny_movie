# frozen_string_literal: true

require 'benchmark/ips'

# BenchmarkTest
class BenchmarkTest
  def initialize
    @array = [1,2,3,4,5,5,6,7,8,67,65,5,5,5,44,5,54]
  end

  def call
    benchmark_method
  end

  private

  attr_reader :array

  def benchmark_method
    Benchmark.ips do |x|
      x.config(time: 5, warmup: 2)
      x.time = 10
      x.warmup = 2

      x.report('fast') { fast }
      x.report('slow') { slow }

      x.compare!
    end
  end

  def fast
    (1..1000).map { |i| i.to_s }
  end

  def slow
    (1..1000).map(&:to_s)
  end
end
