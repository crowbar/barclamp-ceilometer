unless node['roles'].include?('ceilometer-agent')
  node['ceilometer']['services']['agent'].each do |name|
    service name do
      action [:stop, :disable]
    end
  end
  node['ceilometer']['services'].delete('agent')
  node.delete('ceilometer') if node['ceilometer']['services'].empty?
  node.save
end
