# project requirement for vagrant
Vagrant.require_version ">= 2.1.2"

# vagrant version 
Vagrant.configure("2") do |config|
  # vagrant centos 7 
  config.vm.box = "centos/7"

  # vagrant check update
  config.vm.box_check_update = false

  # vagrant hostname
  config.vm.hostname = "localhost"

  # project private network
  config.vm.network "private_network",
    ip: "192.168.100.0"

  # project shared folder
  config.vm.synced_folder "./projects",
    "/var/www/html/projects",
    type: "virtualbox"

  # things to do if virtualbox
  config.vm.provider "virtualbox" do |vb|
    # virtual box  RAM
    vb.memory = 2048

    # virtual box  CPU process usage
    vb.cpus = 4

    # virtual box  graphic user interface off
    vb.gui = false

    # virtual box name
    vb.name = "Web Development Stack CAMP"

    # needed for widnows 10 machine
    vb.customize [
      "setextradata",
      :id,
      "VBoxInternal2/SharedFoldersEnableSymlinksCreate/var/www/html/projects",
      "1"
    ]
  end

  # shell provision file
  config.vm.provision :shell,
    path: "./provision/bootstrap.sh"
end
