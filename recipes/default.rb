#
# Cookbook:: thycotic_secrets
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

gem_package "dsv-sdk" do
  version "0.0.6"
end

gem_package "tss-sdk" do
  version "0.0.1"
end

dsv_data_bag = data_bag_item("thycotic", "thycotic_dsv")

dsv_secret "dsv-secret" do
  client_id       dsv_data_bag["thycotic_client_id"]
  client_secret   dsv_data_bag["thycotic_client_secret"]
  tenant          dsv_data_bag["thycotic_tenant"]
  tld             dsv_data_bag["thycotic_tld"]
  secret_path     dsv_data_bag["thycotic_secret_path"]
end

tss_data_bag = data_bag_item("thycotic", "thycotic_tss")

tss_secret "tss-secret" do
  username    tss_data_bag["thycotic_username"]
  password    tss_data_bag["thycotic_password"]
  server_url  tss_data_bag["thycotic_server_url"]
  secret_id   tss_data_bag["thycotic_secret_id"]
end

file "/tmp/dsv-test.txt" do
  sensitive true
  content lazy { node.run_state["dsv-secret"].to_s }
  only_if { node.run_state.key?("dsv-secret") }
end

file "/tmp/tss-test.txt" do
  sensitive true
  content lazy { node.run_state["tss-secret"].to_s }
  only_if { node.run_state.key?("tss-secret") }
end
