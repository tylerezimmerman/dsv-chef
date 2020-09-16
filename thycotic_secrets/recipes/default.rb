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

dsv_secret 'dsv-secret' do
    client_id 'af8eb095-bdac-4d5a-9b4d-632c5bf7009c'
    client_secret 'secret'
    tenant 'tmg'
    tld 'com'
    secret_path '/test/secret'
end

tss_secret 'tss-secret' do
    username 'sdk_test_app'
    password 'password'
    tenant 'tmg'
    secret_id '1'
end

file '/tmp/dsv-test.txt' do
	sensitive true
	content lazy { node.run_state['dsv-secret']["data"]["password"] }
	only_if { node.run_state.key?('dsv-secret') }
end

file '/tmp/tss-test.txt' do
	sensitive true
	content lazy { node.run_state['tss-secret']["data"] }
	only_if { node.run_state.key?('tss-secret') }
end