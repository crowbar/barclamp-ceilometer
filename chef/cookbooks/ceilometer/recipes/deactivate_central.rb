unless node['roles'].include?('ceilometer-central')
  node['ceilometer']['services']['central'].each do |name|
    service name do
      action [:stop, :disable]
    end
  end
  node['ceilometer']['services'].delete('central')
  node.delete('ceilometer') if node['ceilometer']['services'].empty?
  node.save
end
