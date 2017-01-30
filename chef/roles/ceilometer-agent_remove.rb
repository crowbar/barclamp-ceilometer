name "ceilometer-agent_remove"
description "Deactivate Ceilometer Agent Role services"
run_list(
  "recipe[ceilometer::deactivate_agent]"
)
default_attributes()
override_attributes()

