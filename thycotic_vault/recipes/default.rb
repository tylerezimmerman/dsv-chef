#
# Cookbook:: thycotic_vault
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

gem_package 'dsv-sdk' do
    compile_time true
    version '0.0.6'
    action :install
end

require 'dsv'
v = Dsv::Vault.new