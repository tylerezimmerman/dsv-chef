require 'dsv'

resource_name :dsv_credential
provides :dsv_credential

property :name, String, name_property: true
property :client_id, String
property :client_secret, String
property :tenant, String
property :tld, String, default: "com"
property :query, String

action :create do
  begin
    v = Dsv::Vault.new(
      client_id: new_resource.client_id,
      client_secret: new_resource.client_secret,
      tenant: new_resource.tenant,
      tld: new_resource.tld
    )

    secret = Dsv::Secret.fetch(v, new_resource.query)

    node.run_state[new_resource.name] = secret
  rescue Exception => e
    raise "Could not find credential matching query!"
  end
end