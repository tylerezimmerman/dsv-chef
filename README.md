## PUBLIC ARCHIVE

> ***NOTE***
> This repo is archived.
> This is still available under the licensing terms, but is not being actively developed or updated any further. Please see [DelineaXPM](https://github.com/DelineaXPM) for active projects.


# DSV Chef Cookbook

Provides a new resources: `dsv_secret`, as well as a sample cookbook. This resource allows integration into Thycotic's DSV.

## Requirements

### Platforms

- All platforms supported

### Chef

- Chef 15+

## Custom Resources

### `dsv_secret`

#### Actions

- `:read` - Retrieves secret from Thycotic's DSV

#### Properties

- `name` - Name of the attribute
- `client_id` - Thycotic DSV Client ID
- `client_secret` - Thycotic DSV Client Secret
- `tenant` - Thycotic DSV Tenant
- `tld` - Thycotic DSV Top Level Domain
- `secret_path` - The secret path to query for

#### Examples

Retrives a credential the `/test/sdk/simple` credential from the dsv vault and stores that value in `/tmp/dsv-test.txt`.

```ruby
gem_package "dsv-sdk" do
  version "0.0.6"
end

dsv_data_bag = data_bag_item("thycotic", "thycotic_dsv")

dsv_secret "dsv-secret" do
  client_id       dsv_data_bag["thycotic_client_id"]
  client_secret   dsv_data_bag["thycotic_client_secret"]
  tenant          dsv_data_bag["thycotic_tenant"]
  tld             dsv_data_bag["thycotic_tld"]
  secret_path     dsv_data_bag["thycotic_secret_path"]
end

file "/tmp/dsv-test.txt" do
  sensitive true
  content lazy { node.run_state["dsv-secret"].to_s }
  only_if { node.run_state.key?("dsv-secret") }
end
```

## Testing

- Install [chef workstation](https://docs.chef.io/workstation/install_workstation/)
- Create a `databags` folder containing your testing secrets 
- `kitchen converge` will build the resources
- `kitchen login` will login to the instance where you can verify that the secret contents have been written to the files.
