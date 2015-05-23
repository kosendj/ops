task :'dry-run' do
  run_locally do
    execute :bundle, 'exec', 'roadwork', '-a', '--dry-run', '-f', "#{__dir__}/../../r53/Routefile"
  end
end


task :apply do
  run_locally do
    execute :bundle, 'exec', 'roadwork', '-a', '-f', "#{__dir__}/../../r53/Routefile"
  end
end
