# /cloud

set -o pipefail

@ovh/cloud/projects() {
  ovhapi GET /cloud/project | jq .
}

@ovh/cloud/project/set() {
  export CLOUD_PROJECT_ID=${1:-$(ovhapi GET /cloud/project | jq -r '.[0]')}
  echo "OK: cloud project $CLOUD_PROJECT_ID selected"
}

@ovh/cloud/project() {
  declare projectID=${1:-$CLOUD_PROJECT_ID}
  ovhapi GET /cloud/project/$CLOUD_PROJECT_ID | jq .
}

@ovh/cloud/project/storages() {
  ovhapi GET /cloud/project/$CLOUD_PROJECT_ID/storage | jq .
}

@ovh/cloud/project/storage() {
  declare containerID=$1
  ovhapi GET /cloud/project/$CLOUD_PROJECT_ID/storage/$containerID | jq .
}

@ovh/cloud/project/user/set() {
  declare pattern=$1
  export CLOUD_USER_ID=${1:-$(ovhapi GET /cloud/project/$CLOUD_PROJECT_ID/user | jq -c '.[]' | grep "$pattern" | head -1 | jq -r '.id')}
  echo "OK: cloud user $CLOUD_USER_ID selected"
}

@ovh/cloud/project/_/user() {
  declare userID=${1:-$CLOUD_USER_ID}
  ovhapi GET /cloud/project/$CLOUD_PROJECT_ID/user/$userID | jq .
}

@ovh/cloud/users() {
  ovhapi GET /cloud/project/$CLOUD_PROJECT_ID/user | jq .
}

@ovh/cloud/user/delete() {
  declare userID=${1:-$CLOUD_USER_ID}
  ovhapi DELETE /cloud/project/$CLOUD_PROJECT_ID/user/$userID
}

@ovh/cloud/user/openrc() {
  declare userID=$1 region=${2:-GRA1}
 ovhapi GET "/cloud/project/$CLOUD_PROJECT_ID/user/$userID/openrc?region=$region"
}

@ovh/cloud/user/token() {
  declare userID=$1
  echo '{"password":"'$2'"}' \
    | ovhapi POST /cloud/project/$CLOUD_PROJECT_ID/user/$userID/token | jq -r '{"X-Auth-Token":.["X-Auth-Token"]}'
}

# /dbaas/queue

# @ovh/queue/apps/ids
@ovh/queue/apps/ids() {
  while read ID; do
    ovhapi GET /dbaas/queue/$ID
  done < <(ovhapi GET /dbaas/queue | jq -r '.[]')
}

# @ovh/queue/apps
@ovh/queue/apps() {
  while read ID; do
    ovhapi GET /dbaas/queue/$ID
  done < <(ovhapi GET /dbaas/queue | jq -r '.[]')
}

# @ovh/metrics/projects
@ovh/metrics/projects() {
  while read ID; do
    ovhapi GET /dbaas/timeseries/$ID
    export TS_PROJECT_ID=$ID
  done < <(ovhapi GET /dbaas/timeseries | jq -r '.[]')
}

# /dbaas/timeseries

# @ovh/metrics/keys
@ovh/metrics/keys() {
  while read ID; do
    ovhapi GET /dbaas/timeseries/$TS_PROJECT_ID/keys/$ID
  done < <(ovhapi GET /dbaas/timeseries/$TS_PROJECT_ID/keys | jq -r '.[]')
}

# /dedicated/server

# @ovh/dedicated/servers/ids
@ovh/dedicated/servers/ids() {
  ovhapi GET /dedicated/server | jq -r '.[]'
}

# @ovh/dedicated/servers
@ovh/dedicated/servers() {
  while read ID; do
    ovhapi GET "/dedicated/server/$ID"
  done < <(ovhapi GET /dedicated/server | jq -r '.[]')
}

# @ovh/dedicated/server <serverId>
@ovh/dedicated/server() {
  declare serverId=$1
  ovhapi GET "/dedicated/server/$serverId" | jq .
}

# @ovh/dedicated/server/set-rescue-mode <serverId> <email>
@ovh/dedicated/server/set-rescue-mode() {
  echo '{"bootId":1122,"rescueMail":"'$2'"}' \
    | ovhapi PUT "/dedicated/server/$1"
}

# @dedicated/server/set-normal-mode <serverId>
@ovh/dedicated/server/set-normal-mode() {
  declare serverId=$1
  echo '{"bootId":1,"rootDevice":null}' \
    | ovhapi PUT "/dedicated/server/$serverId"
}

# @dedicated/server/reboot <serverId>
@ovh/dedicated/server/reboot() {
  declare serverId=$1
  echo '{}' \
    | ovhapi POST "/dedicated/server/$serverId/reboot"
}

# /me/installationTemplate

@ovh/templates() {
  ovhapi GET /me/installationTemplate | jq '.[]'
}

@ovh/templates/partitions() {
  declare templateId=$1
  ovhapi GET /me/installationTemplate/$template/partitionScheme/default/partition | jq -r '.[]'
}

# @ovh/template <template>
@ovh/template() {
  declare templateId=$1
  ( for p in $(ovh_list_template_partitions $template | tr '\n' ' ' ); do
    ovhapi GET /me/installationTemplate/$template/partitionScheme/default/partition/$(sed "s|\/|%2F|g" <<< $p) &
  done; wait ) | jq -c .
}

# /ip

# @ovh/ip/reverse/set <ip> <dns>
@ovh/ip/reverse/set() {
  declare ip=$1 dns=$2
  echo '{"ipReverse":"'$1'","reverse":"'$2'"}' \
    | ovhapi POST "/ip/$1/reverse"
}

# /domain


# @ovh/domain <domain>
@ovh/domain() {
  declare domain=${1:-}
  ovhapi GET "/domain/$domain" | jq .
}

# @ovh/domain/zone <zoneName>
@ovh/domain/zone() {
  declare zoneName=${1:-}
  ovhapi GET "/domain/zone/$zoneName" | jq .
}

# @ovh/domain/refresh
@ovh/domain/refresh() {
  declare zoneName=$1
  echo '{}' \
    | ovhapi POST "/domain/zone/$zoneName/refresh" | jq .
}
