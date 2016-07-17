
ovh_cloud_select_project() {
  CLOUD_PROJECT_ID=$(ovhapi GET /cloud/project | jq -r '.[0]')
  echo "OK: cloud project $CLOUD_PROJECT_ID selected"
}

ovh_cloud_list_users_ids() {
  ovhapi GET /cloud/project/$CLOUD_PROJECT_ID/user | jq -c '.[]' | grep dops | jq -r .id
}

ovh_cloud_rm_user() {
  ovhapi DELETE /cloud/project/$CLOUD_PROJECT_ID/user/$1
}

ovh_queue_list_apps() {
  while read ID; do
    ovhapi GET /dbaas/queue/$ID
  done < <(ovhapi GET /dbaas/queue | jq -r '.[]')
}

ovh_dbaas_queue_list_apps() {
  while read ID; do
    ovhapi GET /dbaas/queue/$ID
  done < <(ovhapi GET /dbaas/queue | jq -r '.[]')
}

ovh_dbaas_timeseries_list_projects() {
  while read ID; do
    ovhapi GET /dbaas/timeseries/$ID
    export TS_PROJECT_ID=$ID
  done < <(ovhapi GET /dbaas/timeseries | jq -r '.[]')
}

ovh_dbaas_timeseries_list_keys() {
  while read ID; do
    ovhapi GET /dbaas/timeseries/$TS_PROJECT_ID/keys/$ID
  done < <(ovhapi GET /dbaas/timeseries/$TS_PROJECT_ID/keys | jq -r '.[]')
}

# ovh_sd_set_rescue_mode <serverId> <email>
ovh_sd_set_rescue_mode() {
  echo '{"bootId":1122,"rescueMail":"'$2'"}' \
    | ovhapi PUT "/dedicated/server/$1"
}

# ovh_sd_set_normal_mode <serverId>
ovh_sd_set_normal_mode() {
  echo '{"bootId":1,"rootDevice":null}' \
    | ovhapi PUT "/dedicated/server/$1"
}

# ovh_sd_reboot <serverId>
ovh_sd_reboot() {
  echo '{}' \
    | ovhapi POST "/dedicated/server/$1/reboot"
}

ovh_list_templates() {
  ovhapi GET /me/installationTemplate | jq '.[]'
}

ovh_list_template_partitions() {
  ovhapi GET /me/installationTemplate/$1/partitionScheme/default/partition | jq -r '.[]'
}

# ovh_get_template <template>
ovh_get_template() {
  declare template=$1
  ( for p in $(ovh_list_template_partitions $template | tr '\n' ' ' ); do
    ovhapi GET /me/installationTemplate/$template/partitionScheme/default/partition/$(sed "s|\/|%2F|g" <<< $p) &
  done; wait ) | jq -c .
}

# ovh_sd_set_reverse <ip> <dns>
ovh_sd_set_reverse() {
  echo '{"ipReverse":"'$1'","reverse":"'$2'"}' \
    | ovhapi POST "/ip/$1/reverse"
}
