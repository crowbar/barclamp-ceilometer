resource = "ceilometer"
main_role = "central"

unless node["roles"].include?("ceilometer-cagent")
  # HA part if node is in a cluster
  if File.exist?("/usr/sbin/crm")
    log "Removing #{resource}-#{main_role} resource"

    node[resource]["services"][main_role].each do |name|
      name.gsub!("openstack-","")
      pacemaker_primitive name do
        action [:stop, :delete]
        only_if "crm configure show #{name}"
      end
    end
  else
    # Non HA part if service is on a standalone node
    node[resource]["services"][main_role].each do |name|
      service name do
        action [:stop, :disable]
      end
    end
  end
  node[resource]["services"].delete(main_role)
  node.delete(resource) if node[resource]["services"].empty?

  node.save
end

