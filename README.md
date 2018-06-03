# swarm playground

Vagrant, ansible to deploy my swarm playground

## Requirements

* vagrant (and virtual box) : `sudo apt-get install vagrant`
* vagrant plugin hostmanager : `vagrant plugin install vagrant-hostmanager`
* ansible : `sudo apt-get install ansible`

## How to

Simple !

`vagrant up`

Vagrant can ask you for sudo password to update your hosts file (see https://github.com/devopsgroup-io/vagrant-hostmanager)

Change the number of nodes with `AZ`, `nodePerAZ` and `gfs` variables at the top of `Vagrantfile`

This Vagrantfile deploys:
- `AZ*nodePerAZ` nodes, AZ for Availability Zone (swarm nodes are labeled)
- `gfs` glusterFS nodes

GlusterFS volume plugin is also installed (driver: glusterfs).

## SSH Access

List all nodes:

```
vagrant status
```

Acces to a node:

```
vagrant ssh nodeAZ1N1
```

## Deploy Swarm UI & Portainer

- Swarm UI: `bash ui.sh`, http://nodeAZ1N1.swarm:8080
- Portainer: `vagrant ssh nodeAZ1N1 -c "docker stack deploy -c /vagrant/portainer-agent-stack.yml portainer"` http://nodeAZ1N1.swarm:9000