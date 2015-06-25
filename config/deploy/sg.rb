run_piculet = proc do |*args|
  region =  ENV['REGION'] || ENV['AWS_REGION'] || ENV['AWS_DEFAULT_REGION'] || 'ap-northeast-1'
  cmd = [*%w(piculet -a -f), "sg/#{region}/Groupfile", '-r', region, *args]
  p cmd
  exec *cmd
end

task :apply do
  run_piculet[]
end

task :noop do
  run_piculet['--dry-run']
end
