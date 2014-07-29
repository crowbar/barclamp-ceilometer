def upgrade ta, td, a, d
  d['elements']['ceilometer-swift-proxy-middleware'] = []
  return a, d
end

def downgrade ta, td, a, d
  d.delete['elements']['ceilometer-swift-proxy-middleware']
  return a, d
end
