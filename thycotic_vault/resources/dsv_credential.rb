require 'dsv'

resource_name :dsv_credential
provides :dsv_credential

action :create do
  begin
    v = Dsv::Vault.new
  rescue
    raise "Could not find credential matching query: #{new_resource.query}!"
  end
end