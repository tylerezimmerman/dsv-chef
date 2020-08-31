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

dsv_credential 'cred' do
    client_id 'CLIENT_ID'
    client_secret 'CLIENT_SECRET'
    tenant 'tmg'
    tld 'com'
    query '/test/sdk/simple'
end

file '/tmp/test.txt' do
	sensitive true
	content lazy { node.run_state['cred']["data"]["password"] }
	only_if { node.run_state.key?('cred') }
end