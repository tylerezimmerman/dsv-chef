# thycotic_secrets cookbook

Provides a new resource `dsv_secret` and a sample cookbook. This resource allows integration into Thycotic's DSV. 

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
* `query` - The secret to query for

#### Examples

Retrives a secret the `/test/sdk/simple` secret from the vault and stores that value in `/tmp/test.txt`

```ruby
gem_package 'dsv-sdk' do
    compile_time true
    version '0.0.6'
    action :install
end

dsv_secret 'secret' do
    client_id 'CLIENT_ID'
    client_secret 'CLIENT_SECRET'
    tenant 'tmg'
    tld 'com'
    query '/test/sdk/simple'
end

file '/tmp/test.txt' do
	sensitive true
	content lazy { node.run_state['secret']["data"]["password"] }
	only_if { node.run_state.key?('secret') }
end
```