name "ceilometer-server_remove"
description "Deactivate Ceilometer Server Role services"
run_list(
  "recipe[ceilometer::deactivate_server]"         
)
default_attributes()
override_attributes()

