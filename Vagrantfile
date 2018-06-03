AZ=3
nodePerAZ=2
gfs=2

Vagrant.configure("2") do |config|
  
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  # Use IP resolver to get DHCP configured address
  config.hostmanager.ip_resolver = proc do |vm|
      result = ""
      vm.communicate.execute("ip add show eth1") do |type, data|
        result << data if type == :stdout
      end
      (ip = /inet (\d+\.\d+\.\d+\.\d+)/.match(result)) && ip[1]
  end

  config.vm.box = "debian/stretch64"
	config.vm.network "private_network", type: "dhcp" 
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end

  gfs.downto(1).each do |i|
    config.vm.define "gfs#{i}" do |node| # Provisionning into main nodeAZ1N1
      node.vm.hostname = "gfs#{i}.swarm"
    end
  end

  AZ.downto(1).each do |az|
    nodePerAZ.downto(1).each do |i|
      config.vm.define "nodeAZ#{az}N#{i}" do |node|
        node.vm.hostname = "nodeAZ#{az}N#{i}.swarm"
        if az == 1 && i == 1
          node.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible/playbook.yml"
            ansible.groups = {
              "swarm-managers" => ["nodeAZ[1:#{AZ}]N1"],
              "swarm-workers" => ["nodeAZ[1:#{AZ}]N[2:#{nodePerAZ}]"],
              "docker-nodes:children" => ["swarm-managers", "swarm-workers"],
              "gluster-nodes" => ["gfs[1:#{gfs}]"]
            }
            ansible.limit = "all"
            ansible.verbose = false
          end
        end


      end
  	end  
  end



end
