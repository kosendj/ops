task :'dry-run' do
  run_locally do
    execute :bundle, 'exec', 'miam', '-a', '--dry-run', '-f', "#{__dir__}/../../iam/IAMfile"
  end
end


task :apply do
  run_locally do
    execute :bundle, 'exec', 'miam', '-a', '-f', "#{__dir__}/../../iam/IAMfile"
  end
end
