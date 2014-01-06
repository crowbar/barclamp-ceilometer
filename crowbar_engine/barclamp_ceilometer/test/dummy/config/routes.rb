Rails.application.routes.draw do

  mount BarclampCeilometer::Engine => "/barclamp_ceilometer"
end
