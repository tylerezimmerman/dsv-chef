# thycotic_vault cookbook

Provides a new resource `dsv_credential` and a sample cookbook. This resource allows integration into Thycotic's DSV. 

## Requirements

### Platforms
* All platforms supported

### Chef
* Chef 15+

## Custom Resources

### `dsv_credential`

#### Actions
* `:read` - Retrieves credential from Thycotic's DSV

#### Properties
* `name` - Name of the attribute
* `client_id` - Thycotic DSV Client ID
* `client_secret` - Thycotic DSV Client Secret
* `tenant` - Thycotic DSV Tenant
* `tld` - Thycotic DSV Top Level Domain
* `query` - The credential to query for

#### Examples

Retrives a credential the `/test/sdk/simple` credential from the vault and stores that value in `/tmp/test.txt`

```ruby
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
```