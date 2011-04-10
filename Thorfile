class Default < Thor
  include Thor::Actions

  desc "upgrade", "Upgrade system"
  def upgrade
    run "sudo apt-get update"
    run "sudo apt-get upgrade"
    run "gem update --system"
    run "gem update"
    run "rvm get head"
  end
end
