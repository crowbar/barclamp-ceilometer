resource = "ceilometer"
main_role = "agent"

unless node['roles'].include?("#{resource}-#{main_role}")
  node[resource]["services"][main_role].each do |name|
    service name do
      action [:stop, :disable]
    end
  end
  node[resource]['services'].delete(main_role)
  node.delete(resource) if node[resource]['services'].empty?

  node.save
end
