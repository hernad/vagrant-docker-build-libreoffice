ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
 
Vagrant.configure("2") do |config|

  config.vm.define "lobuild" do |a|
    a.vm.provider "docker" do |d|
      d.build_dir = "."
      d.build_args = ["-t=lobuild"]
      d.name = "lobuild"
      d.remains_running = false
      d.vagrant_machine = "dockerhost"
      d.vagrant_vagrantfile = "./DockerHostVagrantfile"
    end
  end

end
