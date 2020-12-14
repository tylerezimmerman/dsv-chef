resource_name :dsv_secret
provides :dsv_secret

property :name, String, name_property: true
property :client_id, String
property :client_secret, String
property :tenant, String
property :tld, String, default: "com"
property :secret_path, String

action :read do
  require "dsv"
  begin
    v = Dsv::Vault.new(
      client_id: new_resource.client_id,
      client_secret: new_resource.client_secret,
      tenant: new_resource.tenant,
      tld: new_resource.tld,
    )

    secret = Dsv::Secret.fetch(v, new_resource.secret_path)

    node.run_state[new_resource.name] = secret
  rescue Exception => e
    raise "Could not find secret matching secret_path - Exception: #{e}"
  end
end
