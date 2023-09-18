# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Use jammy64 (22.04 LTS).
  config.vm.box = "ubuntu/jammy64"
  # False because we'll use the insecure key. Do not do this in production,
  # assuming someone uses vagrant in production.
  config.ssh.insert_key = false
  # Disable the synced folder.
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define "app" do |app|
    app.vm.network :private_network, ip: "192.168.100.100"
  end
end
