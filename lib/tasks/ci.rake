namespace :ci do
  task :test => ['db:drop', 'db:create', 'db:migrate', 'rake:test']
end