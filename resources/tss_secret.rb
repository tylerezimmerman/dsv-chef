resource_name :tss_secret
provides :tss_secret

property :name, String, name_property: true
property :username, String
property :password, String
property :server_url, String
property :secret_id, String

action :read do
  require "tss"
  begin
    server = Tss::Server.new({
      username: new_resource.username,
      password: new_resource.password,
      server_url: new_resource.server_url,
    })

    secret = Tss::Secret.fetch(server, new_resource.secret_id)

    node.run_state[new_resource.name] = secret
  rescue Exception => e
    raise "Could not find secret matching secret_id - Exception: #{e}"
  end
end
