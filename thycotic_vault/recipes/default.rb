#
# Cookbook:: thycotic_vault
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
gem_package 'tss-sdk' do
    compile_time true
    version '0.0.1'
end

gem_package 'dsv-sdk' do
    compile_time true
    version '0.0.6'
end

tss_credential 'tss-cred' do
    username 'username'
    password 'password'
    tenant 'tmg'
    query '1'
end

file '/tmp/tss-test.txt' do
    sensitive true
	content lazy { node.run_state['tss-cred']['items'][0].to_s }
	only_if { node.run_state.key?('tss-cred') }
end

dsv_credential 'dsv-cred' do
    client_id 'CLIENT_ID'
    client_secret 'CLIENT_SECRET'
    tenant 'tmg'
    tld 'com'
    query '/test/sdk/simple'
end

file '/tmp/dsv-test.txt' do
	sensitive true
	content lazy { node.run_state['dsv-cred']["data"]["password"] }
	only_if { node.run_state.key?('dsv-cred') }
end