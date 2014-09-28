# Only run Simplecov when not using Distributed Ruby
unless ENV['DRB']
  Simplecov.start
end
