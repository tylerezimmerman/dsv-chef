#
# Cookbook:: thycotic_secrets
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

gem_package 'dsv-sdk' do
    version '0.0.6'
end

gem_package 'tss-sdk' do
    version '0.0.1'
end

tss_secret 'tss-secret' do
    username 'CLIENT_ID'
    password 'CLIENT_SECRET'
    tenant 'tmg'
    query '1'
end

dsv_secret 'dsv-secret' do
    client_id 'CLIENT_ID'
    client_secret 'CLIENT_SECRET'
    tenant 'tmg'
    tld 'com'
    query '/test/sdk/simple'
end

file '/tmp/dsv-test.txt' do
	sensitive true
	content lazy { node.run_state['dsv-secret']["data"]["password"] }
	only_if { node.run_state.key?('dsv-secret') }
end

file '/tmp/tss-test.txt' do
	sensitive true
	content lazy { node.run_state['tss-secret']["data"]["password"] }
	only_if { node.run_state.key?('tss-secret') }
end