# thycotic_secrets cookbook

Provides two new resources: `dsv_secret` and `tss_secret`, as well as a sample cookbook. This resource allows integration into Thycotic's DSV and TSS. 

## Requirements

### Platforms
* All platforms supported

### Chef
* Chef 15+

## Custom Resources

### `dsv_secret`

#### Actions
* `:read` - Retrieves secret from Thycotic's DSV

#### Properties
* `name` - Name of the attribute
* `client_id` - Thycotic DSV Client ID
* `client_secret` - Thycotic DSV Client Secret
* `tenant` - Thycotic DSV Tenant
* `tld` - Thycotic DSV Top Level Domain
* `query` - The credential to query for

### `tss_credential`

#### Actions
* `:read` - Retrieves credential from Thycotic's DSV

#### Properties
* `name` - Name of the attribute
* `username` - Thycotic TSS Username
* `password` - Thycotic TSS Password
* `tenant` - Thycotic DSV Tenant
* `query` - The credential to query for

#### Examples

Retrives a credential the `/test/sdk/simple` credential from the dsv vault and stores that value in `/tmp/test.txt`. Additionally demonstrates using TSS to retrive the first secret.

```ruby
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
```

## Testing

* Install [chef workstation](https://docs.chef.io/workstation/install_workstation/)
* `kitchen converge` will build the resources
* `kitchen login` will login to the instance where you can verify that the secret contents have been written to the files.