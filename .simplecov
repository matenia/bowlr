# Only run Simplecov when not using Distributed Ruby
unless ENV['DRB']
  SimpleCov.start
end
