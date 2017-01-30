case node["platform"]
when "suse"
  default["ceilometer"]["services"] = {
    "agent" => ["openstack-ceilometer-agent-compute"],
    "central" => ["openstack-ceilometer-agent-central"],
    "server" => ["openstack-ceilometer-api", "openstack-ceilometer-collector", "openstack-ceilometer-udp", "mongodb"]
  }
end
