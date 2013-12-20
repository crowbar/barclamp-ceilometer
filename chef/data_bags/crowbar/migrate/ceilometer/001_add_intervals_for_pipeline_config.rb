def upgrade ta, td, a, d
  a['cpu_interval'] = 600
  a['meters_interval'] = 600
  return a, d
end
def downgrade ta, td, a, d
  a.delete('cpu_interval')
  a.delete('meters_interval')
  return a, d
end
