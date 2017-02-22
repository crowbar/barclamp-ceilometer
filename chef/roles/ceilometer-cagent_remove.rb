name "ceilometer-cagent_remove"
description "Deactivate Ceilometer Central Agent Role services"
run_list(
  "recipe[ceilometer::deactivate_central]"
)
default_attributes()
override_attributes()

