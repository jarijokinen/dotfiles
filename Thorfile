class Default < Thor
  include Thor::Actions

  desc "upgrade", "Upgrade system"
  def upgrade
    run "sudo apt-get update"
    run "sudo apt-get upgrade"
    run "gem update --system"
    run "gem update"
    run "rvm update"
  end

  desc "app", "Create a new Rails application"
  def app(name)
    #template = "~/.rails/application.rb"
    options = "--skip-testunit --skip-prototype --skip-gemfile --force"
    #run "rails new #{name} -m #{template} #{options}"
    run "rails new #{name} #{options}"
  end
end
