unless node['roles'].include?('ceilometer-server')
  node['ceilometer']['services']['server'].each do |name|
    service name do
      action [:stop, :disable]
    end
  end
  node['ceilometer']['services'].delete('server')
  node.delete('ceilometer') if node['ceilometer']['services'].empty?
  node.save
end
